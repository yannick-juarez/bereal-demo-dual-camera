import Foundation

enum FeedMockService {
    static let friendsPosts: [Post] = [
        Post(primaryImageName: "post2", secondaryImageName: "marie", profile: Profile(imageName: "marie", username: "mariecrossard"), timeLabel: "3 h Late"),
        Post(primaryImageName: "post1", secondaryImageName: "post1", profile: Profile(imageName: "yaya", username: "yannickjuarez"), timeLabel: "2 min Late"),
        Post(primaryImageName: "marty1", secondaryImageName: "marty", profile: Profile(imageName: "marty", username: "lmart1n"), timeLabel: "Hier 21:45:03")
    ]
}
