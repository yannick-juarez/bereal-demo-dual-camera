//
//  LoadingMainView.swift
//  BeReal
//
//  Created by Yannick Juarez on 22/10/2022.
//

import SwiftUI

struct LoadingMainView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("BeReal.")
                .fontWeight(.bold)
                .font(.largeTitle)
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }
    }
}

struct LoadingMainView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMainView()
            .preferredColorScheme(.dark)
    }
}
