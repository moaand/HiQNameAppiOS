struct Employee: Decodable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let imageUrl: String
    
    init(id: Int, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
