//
//  DualPictureView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct DualPictureView: View {

    @State var primaryImage: UIImage
    @State var secondaryImage: UIImage
    var fillsContainer: Bool = false
    @State var invertImages: Bool = false
    @State var offset: CGSize = CGSize.zero

    func SecondaryImage() -> Image {
        invertImages ? Image(uiImage: primaryImage) : Image(uiImage: secondaryImage)
    }

    func SecondaryView() -> some View {
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

    func PrimaryImage() -> UIImage {
        invertImages ? secondaryImage : primaryImage
    }

    @ViewBuilder
    private func pictureContent(in size: CGSize) -> some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: PrimaryImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)

            if #available(iOS 15.0, *) {
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
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundColor(.black)
                        .frame(width: 123, height: 153)
                    SecondaryView()
                }
                .padding(14)
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
        }
        .frame(width: size.width, height: size.height, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

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
}

struct DualPictureView_Previews: PreviewProvider {
    static var previews: some View {
        DualPictureView(primaryImage: UIImage(named: "marie")!, secondaryImage: UIImage(named: "post2")!)
    }
}
