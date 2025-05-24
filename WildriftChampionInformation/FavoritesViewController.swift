//
//  FavoritesViewController.swift
//  PeopleTableInformation
//
//  Created by Dorin on 24.05.2025.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController {
    
    var favoriteChampions: [CDChampion] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite Champions"
        
        
        fetchFavorites()
    }

    func fetchFavorites() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()

        do {
            let favorites = try context.fetch(request)
            favoriteChampions = favorites.compactMap { $0.champion }
            tableView.reloadData()
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteChampions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ↓ Cast as FavoriteCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("Could not dequeue FavoriteCell")
        }

        let champion = favoriteChampions[indexPath.row]
        cell.nameLabel.text = champion.name
        if let imageName = champion.image {
            cell.championImageView.image = UIImage(named: imageName)
        } else {
            cell.championImageView.image = UIImage(named: "placeholder")
        }

        return cell
    }
}

