//
//  DualPictureView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct DualPictureView: View {

    let primaryImage: UIImage
    let secondaryImage: UIImage
    var fillsContainer: Bool = false
    @State var invertImages: Bool = false
    @State var offset: CGSize = CGSize.zero

    // MARK: Secondary Image and View
    @ViewBuilder
    private func SecondaryImage() -> Image {
        invertImages ? Image(uiImage: primaryImage) : Image(uiImage: secondaryImage)
    }

    @ViewBuilder
    private func SecondaryView() -> some View {
        SecondaryImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 150)
            .cornerRadius(20)
            .onTapGesture {
                withAnimation {
                    invertImages.toggle()
                }
            }
    }

    // MARK: Picture content
    @ViewBuilder
    private func pictureContent(in size: CGSize) -> some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: PrimaryImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)

            SecondaryView()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                }
                .padding(12)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                offset = .zero
                            }
                        }
                )
        }
        .frame(width: size.width, height: size.height, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - Body
    var body: some View {
        Group {
            if fillsContainer {
                GeometryReader { geometry in
                    pictureContent(in: geometry.size)
                }
            } else {
                GeometryReader { geometry in
                    pictureContent(in: geometry.size)
                }
                .aspectRatio(1 / 1.4, contentMode: .fit)
            }
        }
    }

    // MARK: - Methods
    private func PrimaryImage() -> UIImage {
        invertImages ? secondaryImage : primaryImage
    }
}

// MARK: - Previews
#Preview {
    if let primary = UIImage(named: Post.Samples.standard.primaryImageName),
       let secondary = UIImage(named: Post.Samples.standard.secondaryImageName) {
        DualPictureView(primaryImage: primary,
                        secondaryImage: secondary)
    } else {
        Text("Preview unavailable: one or more image assets may be missing.")
            .foregroundStyle(.red)
            .padding()
    }
}
