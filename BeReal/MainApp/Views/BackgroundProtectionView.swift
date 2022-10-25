//
//  BackgroundProtectionView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct BackgroundProtectionView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            LinearGradient(colors: [Color(UIColor.systemBackground),
                                    Color(UIColor.systemBackground.withAlphaComponent(0))],
                           startPoint: .bottom, endPoint: .top)
            .frame(height: 200)
        }
        .ignoresSafeArea()
    }
}

struct BackgroundProtectionView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundProtectionView()
    }
}
