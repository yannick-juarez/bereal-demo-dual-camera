//
//  Post+Helpers.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/03/2026.
//

extension Post {

    func with(cta: CTA) -> Post {
        var copy = self
        copy.cta = cta
        return copy
    }

    func with(caption: String) -> Post {
        var copy = self
        copy.caption = caption
        return copy
    }
}
