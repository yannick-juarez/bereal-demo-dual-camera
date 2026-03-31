//
//  FriendsView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI
import Focuser

struct FriendsView: View {

    @Binding var showFriends: Bool
    @State var insertionEdge: Edge = .trailing
    @State var removalEdge: Edge = .trailing
    @State var segmentedSelection: Int = 0
    @State var isSentSheetPresented: Bool = false

    // MARK: Contacts Section
    @ViewBuilder
    private func ContactsSection() -> some View {
        VStack(spacing: 20) {
            ShareMyProfileView()
            VStack(alignment: .leading, spacing: 8) {
                Text("ajouter tes contacts")
                    .textCase(.uppercase)
                    .font(.system(size: 14).bold())
                    .foregroundColor(.secondary)
                LazyVStack {
                    ForEach(0..<10) { index in
                        ContactCell()
                    }
                }
                Spacer()
            }
        }
        .padding()
        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
    }

    // MARK: Invites Section
    @ViewBuilder
    private func InvitesSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ShareMyProfileView()
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("invitations d'amis (0)")
                        .textCase(.uppercase)
                        .font(.system(size: 14).bold())
                        .foregroundColor(.secondary)
                    Spacer()
                    Button {
                        isSentSheetPresented = true
                    } label: {
                        HStack(spacing: 2) {
                            Text("Envoyées")
                                .font(.system(size: 14).bold())
                                .textCase(.uppercase)
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.secondary)
                    }

                }
                HStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 8) {
                            Text("Aucune invitation en attente")
                                .font(.body.bold())
                            Text("Tu n'as aucune invitation en attente")
                                .font(.callout)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.secondary)
                            .opacity(0.25)
                    )
                }
            }
        }
        .padding()
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
    }

    // MARK: Friends Section
    @ViewBuilder
    private func FriendsSection() -> some View {
        VStack(spacing: 20) {
            ShareMyProfileView()
            VStack(alignment: .leading, spacing: 8) {
                Text("mes amis (10)")
                    .textCase(.uppercase)
                    .font(.system(size: 14).bold())
                    .foregroundColor(.secondary)
                LazyVStack {
                    ForEach(0..<10) { index in
                        FriendCell()
                    }
                }
                Spacer()
            }
        }
        .padding()
        .transition(.asymmetric(insertion: .move(edge: insertionEdge),
                                removal: .move(edge: removalEdge)))
    }

    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text("BeReal.").font(.title.bold())
                        .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.title3.bold())
                        .onTapGesture {
                            withAnimation {
                                showFriends = false
                            }
                        }
                }

                SearchField(text: .constant(""))

                ZStack {
                    ScrollView {
                        if segmentedSelection == 0 {
                            ContactsSection()
                        } else if segmentedSelection == 1 {
                            FriendsSection()
                        } else if segmentedSelection == 2 {
                            InvitesSection()
                        }
                    }
                    BackgroundProtectionView()
                    VStack {
                        Spacer()
                        SegmentedControlView(selection: $segmentedSelection,
                                             labels: ["Suggestions", "Amis", "Demandes"]) { next in
                            insertionEdge = segmentedSelection > 1 ? .leading : .trailing
                            removalEdge = next > 1 ? .leading : .trailing
                        }
                    }
                }
            }
            // TODO: Complete or remove
            .sheet(isPresented: $isSentSheetPresented) {
                //
            }
        }
    }
}

#Preview {
    FriendsView(showFriends: .constant(true))
        .preferredColorScheme(.dark)
}
