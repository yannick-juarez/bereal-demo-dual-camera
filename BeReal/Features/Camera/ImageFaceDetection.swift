import CoreImage
import UIKit

struct FaceInsights {
    let hasFace: Bool
    let isSmiling: Bool
    let leftEyeClosed: Bool
    let rightEyeClosed: Bool

    static let empty = FaceInsights(hasFace: false,
                                    isSmiling: false,
                                    leftEyeClosed: false,
                                    rightEyeClosed: false)

    var feedbackMessage: String? {
        guard hasFace else {
            return "et oh, il y a quelqu'un ?"
        }

        if isSmiling {
            return "+1 pour le sourire"
        }

        if leftEyeClosed && rightEyeClosed {
            return "t'y vois quelque chose la ?"
        }

        if leftEyeClosed || rightEyeClosed {
            return "merci pour le clin d'oeil"
        }

        return nil
    }
}

extension UIImage {
    func detectFaceInsights() -> FaceInsights {
        guard let cgImage else {
            return .empty
        }

        let ciImage = CIImage(cgImage: cgImage)
        let options: [String: Any] = [
            CIDetectorAccuracy: CIDetectorAccuracyHigh,
            CIDetectorSmile: true,
            CIDetectorEyeBlink: true
        ]

        guard let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options),
              let face = faceDetector.features(in: ciImage, options: options).first as? CIFaceFeature else {
            return .empty
        }

        return FaceInsights(hasFace: true,
                            isSmiling: face.hasSmile,
                            leftEyeClosed: face.leftEyeClosed,
                            rightEyeClosed: face.rightEyeClosed)
    }
}
