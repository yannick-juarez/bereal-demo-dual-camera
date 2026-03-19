import Foundation

struct Profile: Hashable {
    let imageName: String
    let username: String
}

struct Post: Identifiable, Hashable {
    let id: UUID = UUID()
    let primaryImageName: String
    let secondaryImageName: String
    let profile: Profile
    let timeLabel: String
}
