# BeReal

Mockup iOS de BeReal, commencé en 2022 quand je voulais rejoindre l'équipe une première fois. Mis de côté pour une aventure (cofondation d'Explore et développement pendant 3 ans).

Repris en 2026, j'ai souhaité terminé le travail commencé en 2022 mais en y ajoutant et les nouvelles compétences aquises et les évlolutions d'iOS, Xcode etc... dans le but de me présenter à nouveau.

Ce n'est pas une recréation fidèle à 100% de l'app, mais j'ai essayé reproduire un mock-up de ce qu'était BeReal en 2022, mais avec:
un preview live double caméra construit à partir d'un sample Apple Developer.
une reconnaissance de certaines grimaces pour ajouter un commentaire (sourire, yeux fermés, etc)
un mock-up SwiftUI navigation feed, amis, profil.

## Structure

- `App/` — point d'entrée et état de session partagé
- `Core/` — modèles et données mock
- `Features/Camera/` — bridge UIKit/SwiftUI et logique de capture
- `MainApp/` — écrans et composants UI


## Démo
https://www.youtube.com/shorts/lzcvh5qynCI
[![Voir la démo vidéo](https://img.youtube.com/vi/lzcvh5qynCI/maxresdefault.jpg)](https://www.youtube.com/watch?v=lzcvh5qynCI)
