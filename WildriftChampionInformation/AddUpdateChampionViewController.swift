//
//  AddUpdateChampionViewController.swift
//  PeopleTableInformation
//
//  Created by Dorin on 15.05.2025.
//

import UIKit
import CoreData

class AddUpdateChampionViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var ultimateTF: UITextField!
    @IBOutlet weak var roleTF: UITextField!
    @IBOutlet weak var imageTF: UITextField!
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var galleryTF: UITextField! // ex: img1,img2,img3
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    
    
    @IBAction func toggleFavoriteButtonTapped(_ sender: UIButton) {
        guard let champion = cManagedObject else { return }

        if isFavorite(champion) {
            removeFromFavorites(champion)
        } else {
            addToFavorites(champion)
        }

        updateFavoriteButtonUI()
    }
    
    @IBAction func addSaveButton(_ sender: Any) {
        if cManagedObject == nil {
            createChampion()
        } else {
            updateChampion()
        }
        navigationController?.popViewController(animated: true)
    }

    
    @IBAction func deleteChampion(_ sender: Any) {
        guard let championToDelete = cManagedObject else { return }

        context.delete(championToDelete)

        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to delete champion: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cEntity: NSEntityDescription!
    var cManagedObject: CDChampion!

    func createChampion() {
        cEntity = NSEntityDescription.entity(forEntityName: "CDChampion", in: context)
        cManagedObject = CDChampion(entity: cEntity, insertInto: context)

        populateChampionFields()

        do {
            try context.save()
        } catch {
            print("Failed to save new champion: \(error.localizedDescription)")
        }
    }

    func updateChampion() {
        populateChampionFields()

        do {
            try context.save()
        } catch {
            print("Failed to update champion: \(error.localizedDescription)")
        }
    }
    
    
    
    func addToFavorites(_ champion: CDChampion) {
        let favorite = CDFavorite(context: context)
        favorite.champion = champion

        do {
            try context.save()
        } catch {
            print("Failed to add to favorites: \(error)")
        }
    }

    func removeFromFavorites(_ champion: CDChampion) {
        let fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "champion == %@", champion)

        do {
            let favorites = try context.fetch(fetchRequest)
            for fav in favorites {
                context.delete(fav)
            }
            try context.save()
        } catch {
            print("Failed to remove from favorites: \(error)")
        }
    }
    
    func isFavorite(_ champion: CDChampion) -> Bool {
        let fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "champion == %@", champion)

        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }
    
    func updateFavoriteButtonUI() {
        guard let champion = cManagedObject else { return }

        if isFavorite(champion) {
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
    }



    private func populateChampionFields() {
        cManagedObject.name = nameTF.text
        cManagedObject.position = positionTF.text
        cManagedObject.ultimate = ultimateTF.text
        cManagedObject.role = roleTF.text
        cManagedObject.image = imageTF.text
        cManagedObject.url = urlTF.text
        cManagedObject.gallery = galleryTF.text // string separat prin virgulă
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add/Update Champion"

        if let champion = cManagedObject {
            nameTF.text = champion.name
            positionTF.text = champion.position
            ultimateTF.text = champion.ultimate
            roleTF.text = champion.role
            imageTF.text = champion.image
            urlTF.text = champion.url
            galleryTF.text = champion.gallery
            
            updateFavoriteButtonUI()
        }
    }
}
