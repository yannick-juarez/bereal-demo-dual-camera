//
//  SegmentedControlView.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/10/2022.
//

import SwiftUI

struct SegmentedControlView: View {

    @Binding var selection: Int
    @State var labels: [String]

    var willChange: (Int) -> Void = { _ in }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(Array(labels.enumerated()), id: \.offset) { index, label in
                Text(label)
                    .foregroundColor(.primary)
                    .font(.system(size: 14).bold())
                    .tag(index)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.secondary)
                            .opacity(index == selection ? 0.25 : 0)
                    )
                    .onTapGesture {
                    willChange(index)
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation {
                                selection = index
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
        )
        .padding(.horizontal)
    }
}

#Preview {
    SegmentedControlView(selection: .constant(0), labels: ["Suggestions", "Amis", "Demandes"])
}
