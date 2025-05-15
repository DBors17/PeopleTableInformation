## WildriftChampionInformation

Aplicație iOS dedicată afișării informațiilor despre campionii din jocul **League of Legends: Wild Rift**, construită cu ajutorul **UIKit** și preluare de date dintr-un fișier XML.

#  Descriere generală

WildriftChampionInformation este o aplicație iOS care afișează o listă de campioni, cu detalii specifice precum:
- Nume
- Poziție în joc
- Rol
- Abilitate Ultimate
- Imagine reprezentativă
- Galerie cu imagini suplimentare
- Link către pagina oficială

Această aplicație folosește un fișier XML local (`champions.xml`) pentru a popula datele despre campioni.

#  Funcționalități

-  **Căutare campioni**: utilizatorul poate căuta campioni după nume din listă.
-  **Galerie de imagini**: fiecare campion are o secțiune scrollabilă (horizontal) cu imagini adiționale.
-  **UI customizat** în funcție de genul personajului (roz deschis pentru personaje feminine, albastru deschis pentru cele masculine).
-  **Buton More Info** care face segue către o pagină detaliată cu informații suplimentare despre campion.

# Funcționalități implementate de mine(contribuție personală)

-  Search (Căutare campioni)
Am implementat un `UISearchBar` care filtrează campionii afișați în tabel, permițând utilizatorului să găsească rapid un campion după nume.

-  Galerie de imagini (scroll)
Am adăugat o galerie scrollabilă folosind `UIScrollView` și `UIStackView` pentru fiecare campion, unde se încarcă dinamic imaginile specificate în XML. Constrângerile au fost setate manual pentru a permite scroll-ul orizontal.

#  Structură aplicație

- `XMLWildriftParser.swift`: Clasa responsabilă cu parsarea fișierului XML și transformarea în obiecte Swift (`Champion`).
- `Champion.swift`: Modelul de date pentru un campion.
- `Wildrift.swift`: Wrapper pentru încărcarea și accesarea datelor din XML.
- `ViewController.swift`: Controllerul principal care afișează datele despre campion și galeria de imagini.
- `DetailsViewController.swift`: Pagina de detalii accesibilă prin segue.
- `WebViewController.swift`: Pagina web pentru fiecare campion.
- `champions.xml`: Fișierul XML care conține toți campionii și informațiile acestora, inclusiv galeria de imagini.

#  Tehnologii folosite

- Swift 
- UIKit
- XMLParser
- Interface Builder (Storyboard)
- AutoLayout (constraint programat și în Storyboard)
- UIScrollView + UIStackView
- UISearchBar

#  Organizare UI

- Folosește `UITableView` pentru listarea campionilor.
- Navigarea se face cu `UINavigationController`.
- Detaliile fiecărui campion se încarcă într-un `UIViewController` separat.

# Capturi ecran

Folder: Photos 

# Dezvoltat de

**Bors Dorin**  
Aprilie 2025  
