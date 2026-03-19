import SwiftUI
import UIKit

struct SessionBeReal {
    let frontImage: UIImage
    let backImage: UIImage
    let createdAt: Date
    let locationLabel: String
}

final class AppSession: ObservableObject {
    @Published private(set) var myPost: SessionBeReal?

    func publish(frontImage: UIImage, backImage: UIImage) {
        myPost = SessionBeReal(frontImage: frontImage,
                               backImage: backImage,
                               createdAt: Date(),
                               locationLabel: "Paris")
    }

    func clearMyPost() {
        myPost = nil
    }
}
