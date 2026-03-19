//
//  BeRealView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraViewController

    let viewController = CameraViewController()

    func makeUIViewController(context: Context) -> CameraViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // Update CameraViewController
    }

    func toggleCamera() {
        viewController.togglePiP()
    }

    func capture(_ completion: @escaping (UIImage, UIImage) -> Void) {
        viewController.capture(completion)
    }
}

struct BeRealView: View {

    @State var countDown: Int = 89
    @State var cameraView = CameraView()
    @State var captured: Bool = false

    @State var frontCapturedImage: UIImage?
    @State var backCaptureImage: UIImage?

    @State var isThereSmile: Bool = false
    @State var isThereFace: Bool = false
    @State var isRightEyeClosed: Bool = false
    @State var isLeftEyeClosed: Bool = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text("BeReal.").font(.title.bold())
                Text("\(Int(countDown / 60)):\(countDown % 60 < 10 ? "0" : "")\(Int(countDown % 60))")
                    .font(.title.bold())
            }
            .padding(.top)
            if captured, let front = frontCapturedImage, let back = backCaptureImage {
                ZStack {
                    DualPictureView(primaryImage: back, secondaryImage: front)
                    if isThereFace {
                        if isThereSmile {
                            Text("+1 pour le sourire")
                                .font(.title.bold())
                                .foregroundColor(.white)
                        } else {
                            if isRightEyeClosed && isLeftEyeClosed {
                                Text("t'y vois quelque chose là ?")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                            }
                            if isRightEyeClosed || isLeftEyeClosed {
                                Text("merci pour le clin d'oeil 😉")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    } else {
                        Text("et oh, il y a quelqu'un ?")
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }
                }
            } else {
                cameraView
                    .cornerRadius(20)
            }
            HStack(spacing: 30) {
                if captured {
                    Button(action: {
                        // send
                    }) {
                        HStack {
                            Text("Envoyer")
                                .textCase(.uppercase)
                            Image(systemName: "arrowtriangle.right.fill")
                        }
                        .font(.title.bold())
                        .foregroundColor(.primary)
                    }
                } else {
                    Image(systemName: "bolt.slash.fill")
                        .font(.title.bold())
                    Button {
                        cameraView.capture { front, back in
                            frontCapturedImage = front
                            backCaptureImage = back
                            captured = true
                            (isThereFace, isThereSmile, isLeftEyeClosed, isRightEyeClosed) = front.isThereFaceAndSmile()
                        }
                    } label: {
                        Circle()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .padding(8)
                            .frame(width: 88, height: 88)
                            .background(
                                Circle()
                                    .foregroundColor(.primary)
                                    .frame(width: 80, height: 80)
                            )
                    }

                    Button {
                        cameraView.toggleCamera()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.vertical, 20)
        }
        .onReceive(timer) { _ in
            if countDown > 0 {
                countDown -= 1
            }
        }
    }
}

struct BeRealView_Previews: PreviewProvider {
    static var previews: some View {
        BeRealView()
    }
}


extension UIImage {

    func isThereFaceAndSmile() -> (Bool, Bool, Bool, Bool) {
        let ciImage = CIImage(cgImage: self.cgImage!)

        let options: [String: Any] = [
            CIDetectorAccuracy: CIDetectorAccuracyHigh,
            CIDetectorSmile: true,
            CIDetectorEyeBlink: true
        ]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)!

        let faces = faceDetector.features(in: ciImage, options: options)

        if let face = faces.first as? CIFaceFeature {
            return (true, face.hasSmile, face.leftEyeClosed, face.rightEyeClosed)
        }
        return (false, false, false, false)
    }


}
