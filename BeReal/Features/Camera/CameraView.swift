import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraViewController

    let viewController = CameraViewController()

    func makeUIViewController(context: Context) -> CameraViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }

    func toggleCamera() {
        viewController.togglePiP()
    }

    func capture(_ completion: @escaping (UIImage, UIImage) -> Void) {
        viewController.capture(completion)
    }
}
