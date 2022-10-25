//
//  AvatarView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct AvatarView: View {

    @State var imageName: String
    @State var size: CGFloat = 30

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: size, height: size)
            .cornerRadius(size * 0.5)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(imageName: "yaya")
    }
}
