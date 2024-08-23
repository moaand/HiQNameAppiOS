import SwiftUI

class EmployeeViewModel : ObservableObject {
    @Published var employees = [Employee]()
    @Published private var currentEmployeeIndex = 0
    @Published var score = 0
    
    func fetchEmployees() {
        // "http:/192.168.1.110:5229/api/employees"
        //"http:/10.66.41.163:5229/api/employees"
        guard let url = URL(string: "http:/10.66.41.163:5229/api/employees") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Employee].self, from: data) {
                    DispatchQueue.main.async {
                        self.employees = decodedResponse
                        self.employees.shuffle()
                    }
                    
                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func getEmployeeOptions() -> [Employee] {
        
        guard employees.count >= 3 else {
            return []
        }
        
        var employeeSet = Set(employees)
        employeeSet.remove(employees[currentEmployeeIndex])
        
        let firstOption = employeeSet.randomElement()!
        employeeSet.remove(firstOption)
        
        let secondOption = employeeSet.randomElement()!
        employeeSet.remove(firstOption)
        
        var options = [employees[currentEmployeeIndex], firstOption, secondOption]
        
        options.shuffle()
        
        return options
    }
    
    func handleSwipe(selectedEmployee: Employee) {
        
        if(selectedEmployee == employees[currentEmployeeIndex]) {
            score += 1
        } else {
            score = 0
        }
        
        currentEmployeeIndex = (currentEmployeeIndex + 1) % employees.count
    }
    
    func getCurrentEmployee() -> Employee {
        
        if employees.isEmpty {
            fatalError()
        }
        
        return employees[currentEmployeeIndex]
    }
    
    func getNextEmployee() -> Employee {
        
        if employees.isEmpty {
            fatalError()
        }
        
        return employees[currentEmployeeIndex % employees.count]
    }
    
    func nextEmployee() {
        currentEmployeeIndex = currentEmployeeIndex % employees.count
    }
}
