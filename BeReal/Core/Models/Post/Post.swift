//
//  Post.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/03/2026.
//

import Foundation

struct Post: Identifiable, Hashable {

    let id: UUID = UUID()
    let primaryImageName: String
    let secondaryImageName: String
    let profile: Profile
    let timeLabel: String
    
    var caption: String? = nil
    var cta: CTA? = nil
}
