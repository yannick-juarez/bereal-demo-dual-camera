//
//  ContactCell.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct ContactCell: View {

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
                    HStack(spacing: 4) {
                        Image(systemName: "person.circle")
                        Text("John")
                    }
                }
                .font(.callout)
                .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 20) {
                Button {
                    //
                } label: {
                    Text("ajouter")
                        .font(.system(size: 14, weight: .heavy))
                        .textCase(.uppercase)
                        .foregroundColor(.primary)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.secondary)
                                .opacity(0.25)
                        )
                }
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

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell()
    }
}
