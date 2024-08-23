import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = EmployeeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.employees.count >= 3 {
                    GameView(viewModel: viewModel)
                } else {
                    NoContentView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("SWIPE"))
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear() {
            viewModel.fetchEmployees()
        }
    }
}

#Preview {
    MainView()
}
