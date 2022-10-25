//
//  MyPostView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct MyPostView: View {
    var body: some View {
        VStack {
            Image("post1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 150)
                .cornerRadius(12)
            Text("Ajouter une légende…")
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

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
    }
}
