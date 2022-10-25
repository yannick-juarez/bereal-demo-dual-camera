//
//  FriendCell.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct FriendCell: View {

    var body: some View {
        HStack {
            Text("JA")
                .padding()
                .font(.title2.bold())
                .background(
                    Circle()
                        .foregroundColor(.purple)
                )
            VStack(alignment: .leading) {
                Text("John Appleseed")
                    .fontWeight(.bold)
                VStack(alignment: .leading) {
                    Text("applejohn")
                }
                .font(.callout)
                .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 20) {
                Button {
                    //
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.system(size: 14).bold())
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct FriendCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendCell()
    }
}
