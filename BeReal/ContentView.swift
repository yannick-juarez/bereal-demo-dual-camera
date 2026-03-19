//
//  ContentView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct ContentView: View {

    @State var loading: Bool = true
    @State var showDebug: Bool = false
    @State var showCamera: Bool = false

    var body: some View {
        VStack {
            if loading {
                LoadingMainView()
            } else {
                MainView()
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
            BeRealView()
                .padding(.bottom, 30)
                .background(Color("Black"))
                .ignoresSafeArea(.all)
        }
        .sheet(isPresented: $showDebug) {
            NavigationView {
                List {
                    Section(header: Text("events")) {
                        Button {
                            //
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
