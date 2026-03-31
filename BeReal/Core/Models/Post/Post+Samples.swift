//
//  Post+Samples.swift
//  BeReal
//
//  Created by Yannick Juarez on 25/03/2026.
//

extension Post {

    class Samples {
        static let standard: Post = Post(primaryImageName: "lunabee",
                                         secondaryImageName: "face1",
                                         profile: .Samples.yaya,
                                         timeLabel: "2 min Late")
    }
}


extension [Post] {
    static let samples: [Post] = [
        Post(primaryImageName: "velux",
             secondaryImageName: "face5",
             profile: .Samples.yaya,
             timeLabel: "Today 12:01:34",
             caption: "iOS Engineer - Open to work"),
        Post(primaryImageName: "explore",
             secondaryImageName: "explore-face",
             profile: .Samples.antoine,
             timeLabel: "Sponsorisé",
             caption: "Co-fondation app Explore (2023)",
             cta: .Samples.explore),
        Post(primaryImageName: "13bca",
             secondaryImageName: "13bca2",
             profile: .Samples.yaya,
             timeLabel: "Yesterday 12:01:34",
             caption: "Réserviste @ 13e BCA"),
        Post(primaryImageName: "zenly4",
             secondaryImageName: "snap1",
             profile: .Samples.yaya,
             timeLabel: "Yesterday 21:02:43",
             caption: "iOS Engineer @ Zenly (2022)"),
        Post(primaryImageName: "zenly1",
             secondaryImageName: "face1",
             profile: .Samples.yaya,
             timeLabel: "iOS Engineer @ Zenly - 2022-2023"),
        Post(primaryImageName: "marty-amo",
             secondaryImageName: "marty1",
             profile: .Samples.marty,
             timeLabel: "iOS Engineer @ Zenly - 2022-2023"),
        Post(primaryImageName: "zenly5",
             secondaryImageName: "face4",
             profile: .Samples.yaya,
             timeLabel: "iOS Engineer @ Zenly - 2022-2023"),
        Post(primaryImageName: "devola-office",
             secondaryImageName: "devola-face",
             profile: .Samples.manu,
             timeLabel: "CTO - Chambéry 2020-2022",
             caption: "CTO @ Devola - 2020-2022"),
        Post(primaryImageName: "lunabee",
             secondaryImageName: "face2",
             profile: .Samples.yaya,
             timeLabel: "Staff junior iOS - Chambéry 2019/2020",
             caption: "Second experience @ Lunabee Studio"),
        Post(primaryImageName: "synbird",
             secondaryImageName: "face3",
             profile: .Samples.yaya,
             timeLabel: "Staff junior iOS - Chambéry 2018/2019",
             caption: "First experience @ Synbird"),
        Post(primaryImageName: "42-dance",
             secondaryImageName: "42-macs",
             profile: .Samples.yaya,
             timeLabel: "42 - Paris 17 - Promo 2016",
             caption: "École 42, Paris - Promo 2016"),
        Post(primaryImageName: "xavier",
             secondaryImageName: "42-staff",
             profile: .Samples.yaya,
             timeLabel: "42 - Paris 17 - Promo 2016"),
    ]
}
