//
//  Profile+Samples.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/03/2026.
//


extension Profile {

    class Samples {
        
        static let yaya: Profile = Profile(imageName: "yaya", username: "yannickjuarez")
        static let marty: Profile = Profile(imageName: "marty1", username: "lmart1n")
        static let antoine: Profile = Profile(imageName: "antoine", username: "antoinedupuich")
        static let manu: Profile = Profile(imageName: "devola-face", username: "emmanuel.nmr")

        static let friends: [Profile] = [
            yaya,
            marty,
            antoine,
            manu
        ]
    }
}
