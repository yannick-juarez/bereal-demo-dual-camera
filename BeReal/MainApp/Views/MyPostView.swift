//
//  MyPostView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct MyPostView: View {
    let post: SessionBeReal?

    private static let postTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    var body: some View {
        VStack {
            if let post {
                DualPictureView(primaryImage: post.backImage, secondaryImage: post.frontImage)
                    .frame(width: 300, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("Ton BeReal")
                    .font(.callout.bold())
                HStack {
                    Text("\(post.locationLabel) • Aujourd'hui \(Self.postTimeFormatter.string(from: post.createdAt))")
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            } else {
                Image("snap1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 150)
                    .cornerRadius(12)
                Text("Ajouter une légende...")
                    .font(.callout.bold())
                HStack {
                    Text("Paris • Hier 21:56:38")
                    Image(systemName: "ellipsis")
                        .font(.title3)
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            }
        }
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView(post: nil)
    }
}
