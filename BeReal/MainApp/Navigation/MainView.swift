//
//  MainView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct MainView: View {

    @State var showExplorer: Bool = false
    @State var showMenu: Bool = true
    @State var showFriends: Bool = false
    @State var posts: [Post] = [
        Post(primaryImageName: "post2", secondaryImageName: "marie", profile: Profile(imageName: "marie", username: "mariecrossard"), timeLabel: "3 h Late"),
        Post(primaryImageName: "post1", secondaryImageName: "post1", profile: Profile(imageName: "yaya", username: "yannickjuarez"), timeLabel: "2 min Late"),
        Post(primaryImageName: "marty1", secondaryImageName: "marty", profile: Profile(imageName: "marty", username: "lmart1n"), timeLabel: "Hier 21:45:03"),
    ]

    func HeaderView() -> some View {
        HStack {
            Image(systemName: "person.2.fill")
                .onTapGesture {
                    withAnimation {
                        showFriends = true
                    }
                }
            Spacer()
            Text("BeReal.").font(.title.bold())
            Spacer()
            AvatarView(imageName: "yaya")
        }
    }

    func PostsView() -> some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack {
                        if showExplorer {
                            ForEach(posts.reversed(), id: \.self) { post in
                                PostView(post: post)
                            }
                            .transition(.move(edge: .trailing))
                        } else {
                            VStack(spacing: 20) {
                                MyPostView()
                                ForEach(posts, id: \.self) { post in
                                    PostView(post: post)
                                }
                            }
                            .transition(.move(edge: .leading))
                        }
                        Spacer()
                        HStack {
                            Spacer()
                        }
                    }
                    .padding(.top, 76)
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { offset in
                        print(offset)
                        withAnimation(.linear(duration: 0.15)) {
                            showMenu = offset < 150
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
                VStack {
                    HeaderView()
                    if showMenu {
                        HStack(spacing: 20) {
                            Button {
                                withAnimation {
                                    showExplorer = false
                                }
                            } label: {
                                Text("Mes amis")
                                    .font(.body.bold())
                                    .foregroundColor(showExplorer ? .gray : .primary)
                            }
                            Button {
                                withAnimation {
                                    showExplorer = true
                                }
                            } label: {
                                Text("Discovery")
                                    .font(.body.bold())
                                    .foregroundColor(showExplorer ? .primary : .gray)
                            }
                        }
                        .transition(.move(edge: .top))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
        }
    }

    var body: some View {
        VStack {
            if showFriends {
                FriendsView(showFriends: $showFriends)
                .transition(.move(edge: .leading))
            } else {
                NavigationView(content: {
                    PostsView()
                })
                .ignoresSafeArea(.all)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
