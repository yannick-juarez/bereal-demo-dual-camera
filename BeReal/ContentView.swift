//
//  ContentView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

private enum ActiveAlert: Identifiable {
    case timeToBeReal

    var id: Int {
        switch self {
        case .timeToBeReal:
            return 0
        }
    }
}

struct ContentView: View {

    @StateObject private var appSession = AppSession()
    @State private var loading: Bool = true
    @State private var showDebug: Bool = false
    @State private var showCamera: Bool = false
    @State private var activeAlert: ActiveAlert?

    var body: some View {
        VStack {
            if loading {
                LoadingMainView()
            } else {
                MainView {
                    showCamera = true
                }
                .environmentObject(appSession)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                withAnimation {
                    loading = false
                }
            }
        }
        .onShake {
            showDebug = true
        }
        .fullScreenCover(isPresented: $showCamera) {
            BeRealView { frontImage, backImage in
                appSession.publish(frontImage: frontImage, backImage: backImage)
            }
                .background(Color("Black"))
        }
        .alert(item: $activeAlert) { alert in
            switch alert {
            case .timeToBeReal:
                return Alert(title: Text("Time to BeReal."),
                             message: Text("Le debug simule le moment BeReal. Tu peux ouvrir la camera immediatement."),
                             primaryButton: .default(Text("Ouvrir la camera")) {
                                 showCamera = true
                             },
                             secondaryButton: .cancel())
            }
        }
        .sheet(isPresented: $showDebug) {
            NavigationView {
                List {
                    Section(header: Text("events")) {
                        Button {
                            showDebug = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                activeAlert = .timeToBeReal
                            }
                        } label: {
                            Text("simulate time to be real")
                        }
                    }
                    Section(header: Text("navigation")) {
                        Button {
                            showDebug = false
                            showCamera = true
                        } label: {
                            Text("show camera")
                        }
                    }
                }
                .navigationTitle("debug")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
