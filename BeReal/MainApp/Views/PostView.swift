//
//  PostView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct PostView: View {

    @State var post: Post

    // MARK: Post Menu
    @ViewBuilder
    private func OptionsMenu() -> some View {
        ZStack {
            Menu {
                Button {
                    //
                } label: {
                    HStack {
                        Text("Voir le profil")
                        Spacer()
                        Image(systemName: "person.circle")
                    }
                }
                Button {
                    //
                } label: {
                    HStack {
                        Text("Partager le profil")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                Menu {
                    HStack {
                        Text("Contenu indésirable")
                    }
                    HStack {
                        Text("Contenu inapproprié")
                    }
                } label: {
                    HStack {
                        Text("Signaler")
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                    }
                }
                .foregroundColor(.red)
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                AvatarView(imageName: post.profile.imageName)
                VStack(alignment: .leading) {
                    Text(post.profile.username)
                        .font(.callout.bold())
                    Text(post.timeLabel)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                Spacer()
                OptionsMenu()
            }
            .padding(.horizontal, 10)

            ZStack(alignment: .bottom) {
                if let primaryImage = UIImage(named: post.primaryImageName), let secondaryImage = UIImage(named: post.secondaryImageName) {
                    DualPictureView(primaryImage: primaryImage, secondaryImage: secondaryImage)
                } else {}
                if let cta = post.cta {
                    Link(destination: cta.url) {
                        HStack {
                            Text(cta.label)
                                .font(.body.bold())
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.primary.opacity(0.9))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                        .padding(8)
                    }
                }
            }

            if let caption = post.caption {

                Text(caption)
                    .font(.body.bold())
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 4)
            }

            NavigationLink(destination: Text("")) {
                HStack {
                    Text("Ajouter un commentaire…")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            .padding(.top, -2)
        }
    }
}

// MARK: - Previews
#Preview {
    PostView(post: .Samples.standard
        .with(cta: CTA.Samples.explore)
        .with(caption: "What a great day to be outside! #sunnyday")
    )
}
