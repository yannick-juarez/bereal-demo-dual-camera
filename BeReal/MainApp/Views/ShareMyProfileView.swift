//
//  ShareMyProfileView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct ShareMyProfileView: View {

    private let currentUser: Profile = .Samples.yaya

    var body: some View {
        HStack {
            AvatarView(imageName: currentUser.imageName, size: 35)
            VStack(alignment: .leading) {
                Text("Invite tes amis sur BeReal")
                    .font(.body.bold())
                Text(currentUser.shareURL())
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.primary)
                    .font(.title3)
            }
        }
        .padding()
        .background(
            ZStack {
                Image(currentUser.imageName)
                    .resizable()
                    .blur(radius: 20)
                VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
            }
            .cornerRadius(16)
        )
    }
}

#Preview {
    ShareMyProfileView()
}
