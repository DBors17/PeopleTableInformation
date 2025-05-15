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
    
    // MARK: - Actions
    @IBAction func addSaveButton(_ sender: Any){
        if cManagedObject == nil {
            createChampion()
        } else {
            updateChampion()
        }
        navigationController?.popViewController(animated: true)
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

        if let champion = cManagedObject {
            nameTF.text = champion.name
            positionTF.text = champion.position
            ultimateTF.text = champion.ultimate
            roleTF.text = champion.role
            imageTF.text = champion.image
            urlTF.text = champion.url
            galleryTF.text = champion.gallery
        }
    }
}
