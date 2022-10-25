//
//  ProfileView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct ProfileView: View {

    @Binding var showProfile: Bool
    @State var startAnimation: Bool = false

    var body: some View {
        VStack {
            HStack {
                Button {
                    showProfile = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.body.bold())
                }
                Spacer()
                Text("Profil")
                    .fontWeight(.bold)
                Spacer()
                Button {
                    //
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.body.bold())
                }
            }
            .foregroundColor(.primary)
            .padding()
            if startAnimation {
                VStack {
                    AvatarView(imageName: "yaya", size: 120)
                    VStack(spacing: 8) {
                        VStack {
                            Text("yaya")
                                .font(.title.bold())
                            Text("yannickjuarez")
                                .font(.callout.bold())
                        }
                        VStack {
                            Text("life is a party and i'm the piñata\n🇫🇷🇵🇪")
                            Text("Paris")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    }
                    VStack(spacing: 4) {
                        HStack {
                            Text("Tes Memories")
                                .font(.title3.bold())
                            Spacer()
                            HStack(spacing: 3) {
                                Image(systemName: "lock.fill")
                                Text("Seulement visible pour toi")
                            }
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        }
                        VStack {
                            HStack {
                                Text("14 derniers jours")
                                    .font(.callout.bold())
                                Spacer()
                            }
                            VStack {
                                ForEach(0..<2) { row in
                                    HStack {
                                        ForEach(0..<6) { index in
                                            Text("\(13 + index + (row * 10))")
                                                .font(.body.bold())
                                                .foregroundColor(.white)
                                                .background(RoundedRectangle(cornerRadius: 8)
                                                    .frame(width: 50, height: 65))
                                                .frame(width: 50, height: 65)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                            Text("Voir tous mes Memories")
                                .font(.system(size: 12).bold())
                                .padding(8)
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        .padding(2)
                                        .background(
                                            RoundedRectangle(cornerRadius: 14)
                                                .foregroundColor(.secondary)
                                        )
                                )
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                        )
                        Text("🔗 BeRe.al/yannickjuarez")
                            .fontWeight(.medium)
                            .font(.callout)
                            .padding()
                    }
                    .padding(.horizontal)
                }
                .transition(.scale(scale: 0.4, anchor: .top))
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation {
                startAnimation = true
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfile: .constant(true))
            .preferredColorScheme(.dark)
    }
}
