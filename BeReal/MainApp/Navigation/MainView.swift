//
//  MainView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject private var appSession: AppSession

    let onOpenCamera: () -> Void
    private let currentUser: Profile = .Samples.yaya

    @State var showExplorer: Bool = false
    @State var showMenu: Bool = true
    @State var showFriends: Bool = false
    @State var showProfile: Bool = false

    private let posts: [Post] = .samples

    // MARK:  Header View
    @ViewBuilder
    private func HeaderView() -> some View {
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
            AvatarView(imageName: currentUser.imageName)
                .onTapGesture {
                    showProfile = true
                }
            NavigationLink(destination: ProfileView(showProfile: $showProfile), isActive: $showProfile) {
                EmptyView()
            }
            .hidden()
        }
    }

    // MARK: Header Menu
    @ViewBuilder
    private func HeaderMenu() -> some View {
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

    // MARK: Camera Button
    @ViewBuilder
    private func CameraButton() -> some View {
        Button(action: onOpenCamera) {
            Image(systemName: "camera.fill")
                .font(.headline.bold())
                .foregroundColor(.black)
                .padding(12)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.92))
                )
                .overlay(
                    Capsule()
                        .stroke(Color.black.opacity(0.12), lineWidth: 1)
                )
                .shadow(color: Color.white.opacity(0.22), radius: 20, y: 10)
        }
    }


    // MARK: Posts View
    @ViewBuilder
    private func PostsView() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        if showExplorer {
                            ForEach(posts.reversed(), id: \.self) { post in
                                PostView(post: post)
                            }
                            .transition(.move(edge: .trailing))
                        } else {
                            VStack(spacing: 20) {
                                MyPostView(post: appSession.myPost)
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
                    .padding(.bottom, 110)
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { offset in
                        withAnimation(.linear(duration: 0.15)) {
                            showMenu = offset < 150
                        }
                    }
                }
                .coordinateSpace(name: "scroll")

                VStack {
                    HeaderView()

                    if showMenu {
                        HeaderMenu()
                    }
                    Spacer()
                }
                .padding(.horizontal)

                CameraButton()
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Body
    var body: some View {
        VStack {
            if showFriends {
                FriendsView(showFriends: $showFriends)
                .transition(.move(edge: .leading))
            } else {
                NavigationView {
                    PostsView()
                }
                .navigationBarHidden(true)
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

#Preview {
    MainView(onOpenCamera: {})
        .environmentObject(AppSession())
        .preferredColorScheme(.dark)
}
