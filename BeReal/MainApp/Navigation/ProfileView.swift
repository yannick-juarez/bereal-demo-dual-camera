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

    private let currentUser: Profile = .Samples.yaya


    // MARK: Profile Header
    @ViewBuilder
    private func ProfileHeader() -> some View {
        VStack(spacing: 8) {
            VStack {
                Text(self.currentUser.imageName)
                    .font(.title.bold())
                Text(self.currentUser.username)
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
    }

    // MARK: Memories Section
    @ViewBuilder
    private func MemoriesSection() -> some View {
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
            Text("🔗 \(currentUser.shareURL())")
                .fontWeight(.medium)
                .font(.callout)
                .padding()
        }
        .padding(.horizontal)
    }

    // MARK: - Body
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
                    AvatarView(imageName: currentUser.imageName, size: 120)
                    ProfileHeader()
                    MemoriesSection()
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

#Preview {
    ProfileView(showProfile: .constant(true))
        .preferredColorScheme(.dark)
}
