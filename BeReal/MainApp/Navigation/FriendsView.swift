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
                                }
                            }
                            .padding()
                            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                        } else if segmentedSelection == 1 {
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
                                }
                            }
                            .padding()
                            .transition(.asymmetric(insertion: .move(edge: insertionEdge),
                                                    removal: .move(edge: removalEdge)))
                        } else if segmentedSelection == 2 {
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
            .sheet(isPresented: $isSentSheetPresented) {
                //
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(showFriends: .constant(true))
            .preferredColorScheme(.dark)
    }
}
