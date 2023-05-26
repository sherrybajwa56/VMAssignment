
struct Employee: Codable, Identifiable {
    var id: String
    var createdAt: String
    var firstName: String
    var lastName: String
    var avatar: String
    var email: String
    var jobtitle: String
    var favouriteColor: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case firstName
        case lastName
        case avatar
        case email
        case jobtitle
        case favouriteColor
    }
    var fullname: String {
        firstName + " " + lastName
    }
}

let testEmployee = Employee(id: "1",
                            createdAt: "2022-01-24T17:02:23.729Z",
                            firstName: "sherry",
                            lastName: "bajwa",
                            avatar: "https://randomuser.me/api/portraits/women/21.jpg",
                            email: "sherrybajwa56@gmail.com",
                            jobtitle: "Software Engineer",
                            favouriteColor: "blue")

