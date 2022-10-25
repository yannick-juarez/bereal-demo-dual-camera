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

    func SecondaryView() -> some View {
        Image(invertImages ? post.primaryImageName : post.secondaryImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 150)
            .cornerRadius(20)
            .onTapGesture {
                withAnimation {
                    invertImages.toggle()
                }
            }
    }

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
            ZStack(alignment: .topLeading) {
                Image(invertImages ? post.secondaryImageName : post.primaryImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                if #available(iOS 15.0, *) {
                    SecondaryView()
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.black)
                        }
                        .padding(12)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 21)
                            .foregroundColor(.black)
                            .frame(width: 123, height: 153)
                        SecondaryView()
                    }.padding(14)
                }
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(primaryImageName: "post2", secondaryImageName: "marie", profile: Profile(imageName: "yaya", username: "yannickjuarez"), timeLabel: "2 min Late"))
    }
}
