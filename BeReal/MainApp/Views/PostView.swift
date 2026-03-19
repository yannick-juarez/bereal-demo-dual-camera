//
//  PostView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct Profile: Hashable {
    var imageName: String
    var username: String
}

struct Post: Identifiable, Hashable {

    var id: UUID = UUID()

    var primaryImageName: String
    var secondaryImageName: String

    var profile: Profile
    var timeLabel: String
}

struct PostView: View {

    @State var post: Post
    @State var invertImages: Bool = false
    @State var positionInverted: Bool = false

    var body: some View {
        VStack(spacing: 6) {
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
            .padding(.horizontal, 10)
            DualPictureView(primaryImage: UIImage(named: post.primaryImageName)!,
                            secondaryImage: UIImage(named: post.secondaryImageName)!)
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(primaryImageName: "post2", secondaryImageName: "marie", profile: Profile(imageName: "yaya", username: "yannickjuarez"), timeLabel: "2 min Late"))
    }
}
