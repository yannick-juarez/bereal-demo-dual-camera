//
//  ContactCell.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

// TODO: Move JA to samples, use profile to fill the cell
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
                    .font(.callout.bold())
                VStack(alignment: .leading) {
                    Text("applejohn")
                    HStack(spacing: 4) {
                        Image(systemName: "person.circle")
                        Text("John")
                    }
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 20) {
                Button {
                    //
                } label: {
                    Text("ajouter")
                        .font(.system(size: 12, weight: .heavy))
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
        .padding(.vertical, 4)
    }
}

#Preview {
    ContactCell()
}
