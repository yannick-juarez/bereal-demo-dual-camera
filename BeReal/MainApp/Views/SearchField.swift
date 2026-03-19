//
//  SearchField.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI
import Focuser

struct SearchField: View {

    enum FocusStates: FocusStateCompliant {
        static var last: FocusStates = .searching
        var next: FocusStates? { nil }

        case searching
    }

    @Binding var text: String
    @FocusStateLegacy var focusState: FocusStates?

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Ajouter ou rechercher des amis", text: $text)
                    .focusedLegacy($focusState, equals: .searching)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
            )
            if let value = focusState, value == .searching {
                Button {
                    withAnimation {
                        focusState = nil
                    }
                } label: {
                    Text("Annuler")
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(text: .constant(""))
    }
}
