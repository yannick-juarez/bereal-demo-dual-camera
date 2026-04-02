import SwiftUI

final class CameraControllerStore: ObservableObject {

    let controller = CameraViewController()

    func toggleCamera() {
        controller.togglePiP()
    }

    func capture(_ completion: @escaping (UIImage, UIImage) -> Void) {
        controller.capture(completion)
    }
}

struct CameraView: UIViewControllerRepresentable {

    typealias UIViewControllerType = CameraViewController

    let controller: CameraViewController

    func makeUIViewController(context: Context) -> CameraViewController {
        controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }
}
