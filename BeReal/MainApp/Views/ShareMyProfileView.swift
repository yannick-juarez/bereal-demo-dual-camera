//
//  ShareMyProfileView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct ShareMyProfileView: View {
    var body: some View {
        HStack {
            AvatarView(imageName: "yaya", size: 35)
            VStack(alignment: .leading) {
                Text("Invite tes amis sur BeReal")
                    .font(.body.bold())
                Text("bere.al/yannickjuarez")
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
                Image("yaya")
                    .resizable()
                    .blur(radius: 20)
                VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
            }
                .cornerRadius(16)
        )
    }
}

struct ShareMyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ShareMyProfileView()
    }
}
