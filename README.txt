## WildriftChampionInformation

Aplicație iOS dedicată afișării informațiilor despre campionii din jocul League of Legends: Wild Rift, construită cu ajutorul UIKit, Core Data și preluare de date dintr-un fișier XML.

# Descriere generală

WildriftChampionInformation este o aplicație iOS care afișează o listă de campioni, cu detalii specifice precum:

- Nume
- Poziție în joc
- Rol
- Abilitate Ultimate
- Imagine reprezentativă
- Galerie cu imagini suplimentare
- Link către pagina oficială

Aplicația folosește un fișier XML local (champions.xml) pentru a popula datele inițiale despre campioni, dar permite și gestionarea completă a campionilor personalizați și a celor favoriți cu ajutorul Core Data.

# Funcționalități

Căutare campioni: utilizatorul poate căuta campioni după nume/positie din listă.
Galerie de imagini: fiecare campion are o secțiune scrollabilă (orizontal) cu imagini adiționale.
UI customizat în funcție de genul personajului (roz deschis pentru personaje feminine, albastru deschis pentru cele masculine).
Buton More Info care face segue către o pagină detaliată cu informații suplimentare despre campion.
Adăugare campion: utilizatorul poate crea un campion nou folosind butonul +, care deschide o pagină nouă cu formular (CreateChampionViewController).
Editare/Ștergere campion: campionii adăugați pot fi modificați sau eliminați complet din baza locală.
Favorit campion: fiecare campion poate fi marcat ca favorit apăsând pe butonul cu steluță (*).
Vizualizare favorite: apăsarea butonului steluță deschide un ecran separat (FavoritesViewController) cu toți campionii marcați ca favoriți.

# Funcționalități implementate de mine (contribuție personală)

- Search (Căutare campioni)
Am implementat un UISearchBar care filtrează campionii afișați în tabel, permițând utilizatorului să găsească rapid un campion după nume.

- Galerie de imagini (scroll)
Am adăugat o galerie scrollabilă folosind UIScrollView și UIStackView pentru fiecare campion, unde se încarcă dinamic imaginile specificate în XML. Constrângerile au fost setate manual pentru a permite scroll-ul orizontal.

- Core Data (CRUD complet)
Am integrat Core Data cu două entități:
> CDChampion: pentru campionii personalizați (creați de utilizator).
> CDFavorite: pentru a salva campionii marcați ca favoriți (conține relație către CDChampion).

- Am implementat următoarele operațiuni:

Create: adăugare campion nou.
Read: afișare campioni salvați și favoriți.
Update: modificare date campion.
Delete: ștergere campion sau eliminare din favorite.
Interfață cu butoane funcționale:
> Buton + pentru creare campion nou.
> Buton * pentru vizualizarea campionilor favoriți.
> Implementare ecran custom pentru favorite (FavoriteCell.swift + FavoritesViewController.swift).

# Structură aplicație

- XMLWildriftParser.swift: Clasa responsabilă cu parsarea fișierului XML și transformarea în obiecte Swift (Champion).
- Champion.swift: Modelul de date pentru un campion din XML.
- Wildrift.swift: Wrapper pentru încărcarea și accesarea datelor din XML.
- ViewController.swift: Controllerul principal care afișează datele despre campion și galeria de imagini.
- DetailsViewController.swift: Pagina de detalii accesibilă prin segue.
- WebViewController.swift: Pagina web pentru fiecare campion.
- AddUpdateChampionViewController.swift: Ecran pentru creare și actualizare campioni.
- WildriftTableViewController.swift: Lista principală a campionilor.
- FavoritesViewController.swift: Pagina unde sunt afișați campionii favoriți.
- FavoriteCell.swift: Celulă personalizată pentru afișarea campionilor favoriți.
- CDChampion.swift: Model Core Data pentru campionii salvați local.
- CDFavorite.swift: Model Core Data pentru campionii marcați ca favoriți.
- champions.xml: Fișierul XML care conține toți campionii și informațiile acestora, inclusiv galeria de imagini.

# Tehnologii folosite

- Swift
- UIKit
- Core Data
- XMLParser
- Interface Builder (Storyboard)
- UIScrollView + UIStackView
- UISearchBar
- UITableView, UINavigationController

# Organizare UI

- Folosește UITableView pentru listarea campionilor și a celor favoriți.
- Navigarea se face cu UINavigationController.
- Detaliile fiecărui campion se încarcă într-un UIViewController separat.
- Crearea și editarea campionilor se face într-un ecran dedicat.
- Favoritele sunt afișate într-un UITableViewController separat.

# Capturi ecran

Folder: Photos

# Dezvoltat de

Bors Dorin
Mai 2025