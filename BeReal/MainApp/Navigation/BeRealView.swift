//
//  BeRealView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct BeRealView: View {

    private enum UploadState {
        case idle
        case uploading
    }

    @Environment(\.presentationMode) private var presentationMode
    let onSend: (UIImage, UIImage) -> Void

    @State var countDown: Int = 89
    @StateObject private var cameraStore = CameraControllerStore()
    @State var captured: Bool = false
    @State private var uploadState: UploadState = .idle
    @State private var showDiscardAlert: Bool = false
    @State private var showSendConfirmation: Bool = false

    @State var frontCapturedImage: UIImage?
    @State var backCaptureImage: UIImage?

    @State private var faceInsights: FaceInsights = .empty

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    // MARK: - Init
    init(onSend: @escaping (UIImage, UIImage) -> Void = { _, _ in }) {
        self.onSend = onSend
    }

    // MARK: Countdown Header
    @ViewBuilder
    private func CountdownHeader(headerHeight: CGFloat) -> some View {
        ZStack {
            VStack(spacing: 4) {
                Text("BeReal.").font(.title.bold())
                Text("\(Int(countDown / 60)):\(countDown % 60 < 10 ? "0" : "")\(Int(countDown % 60))")
                    .font(.title3.bold())
            }

            HStack {
                Button(action: handleDismissTap) {
                    Image(systemName: "chevron.down")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color.black))
                        .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                }
                .frame(width: 72, alignment: .leading)

                Spacer()

                Color.clear
                    .frame(width: 72, alignment: .trailing)
            }
        }
        .frame(height: headerHeight, alignment: .top)
        .padding(.horizontal)
    }

    // MARK: Captured Buttons Section
    @ViewBuilder
    private func PreviewButtonsSection() -> some View {
        HStack(spacing: 30) {
            Button(action: resetCapture) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Reprendre")
                }
                .font(.headline.bold())
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Capsule().fill(Color.white.opacity(0.12)))
            }
            .disabled(uploadState == .uploading)

            Button(action: sendPost) {
                HStack {
                    if uploadState == .uploading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    Text(uploadState == .uploading ? "Publication..." : "Envoyer")
                        .textCase(.uppercase)
                    if uploadState == .idle {
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                }
                .font(.headline.bold())
                .foregroundColor(Color.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Capsule().fill(Color.white))
            }
            .disabled(uploadState == .uploading)
        }
    }

    // MARK: Capture Buttons Section
    @ViewBuilder
    private func CaptureButtonsSection() -> some View {
        HStack(spacing: 30) {
            Image(systemName: "bolt.slash.fill")
                .font(.title.bold())
            Button {
                cameraStore.capture { front, back in
                    frontCapturedImage = front
                    backCaptureImage = back
                    captured = true
                    faceInsights = front.detectFaceInsights()
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
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.20), lineWidth: 1)
                            .frame(width: 88, height: 88)
                    )
            }

            Button {
                cameraStore.toggleCamera()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.title.bold())
                    .foregroundColor(.primary)
            }
        }
    }

    // MARK: Preview Message
    @ViewBuilder
    private func PreviewMessage() -> some View {
        VStack(spacing: 6) {
            Text("Prêt à partager ?")
                .font(.title3.bold())
            Text("Ton post sera partagé avec tes amis et les personnes qui te suivent.")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.7))
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .padding(.top, 2)
    }

    // MARK: Upload Message
    private func UploadMessage() -> some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
            VStack(spacing: 12) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                Text("Publication du BeReal...")
                    .font(.headline.bold())
            }
            .padding(24)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.75)))
        }
    }


    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let topInset = geometry.safeAreaInsets.top
            let bottomInset = geometry.safeAreaInsets.bottom
            let safeAreaHeight = max(geometry.size.height - topInset - bottomInset, 0)
            let headerHeight: CGFloat = 84
            let previewHeight = min(geometry.size.width * 1.4, max(safeAreaHeight - 220, 260))

            VStack(spacing: 16) {
                CountdownHeader(headerHeight: headerHeight)

                ZStack {
                    Group {
                        if captured, let front = frontCapturedImage, let back = backCaptureImage {
                            DualPictureView(primaryImage: back, secondaryImage: front, fillsContainer: true)
                                .frame(maxWidth: .infinity, alignment: .top)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        } else {
                            CameraView(controller: cameraStore.controller)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .frame(height: previewHeight, alignment: .top)
                    .clipped()


                    if captured, let feedbackMessage = faceInsights.feedbackMessage {
                        Text(feedbackMessage)
                            .font(.title2.bold())
                            .foregroundColor(.white.opacity(0.9))
                    }
                }

                if captured {
                    PreviewMessage()
                }

                HStack(spacing: 30) {
                    if captured {
                        PreviewButtonsSection()
                    } else {
                        CaptureButtonsSection()
                    }
                }
                .padding(.top, captured ? 8 : 20)
                .padding(.bottom, captured ? 10 : 20)
                .padding(.horizontal)
            }
            .padding(.top, 4)
            .padding(.bottom, max(bottomInset, 10))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background(Color("Black").ignoresSafeArea())
        .alert(isPresented: $showDiscardAlert) {
            Alert(title: Text("Quitter la camera ?"),
                  message: Text("La capture en cours sera perdue."),
                  primaryButton: .destructive(Text("Quitter")) {
                      closeView()
                  },
                  secondaryButton: .cancel(Text("Continuer la capture")))
        }
        .overlay {
            if uploadState == .uploading {
                UploadMessage()
            }
        }
        .onReceive(timer) { _ in
            if countDown > 0 {
                countDown -= 1
            }
        }
    }

    // MARK: - Methods

    private func handleDismissTap() {
        if captured {
            resetCapture()
        } else {
            closeView()
        }
    }

    private func resetCapture() {
        guard uploadState == .idle else {
            return
        }

        frontCapturedImage = nil
        backCaptureImage = nil
        captured = false
        faceInsights = .empty
    }

    private func requestSendConfirmation() {
        guard uploadState == .idle else {
            return
        }

        showSendConfirmation = true
    }

    private func sendPost() {
        guard uploadState == .idle,
              let frontImage = frontCapturedImage,
              let backImage = backCaptureImage else {
            return
        }

        uploadState = .uploading

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            onSend(frontImage, backImage)
            closeView()
        }
    }

    private func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Previews
#Preview {
    BeRealView()
}
