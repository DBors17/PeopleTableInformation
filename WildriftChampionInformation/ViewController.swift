//
//  ViewController.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBAction func moreInfoAction(_ sender: Any) {}
    
    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var championRoleLabel: UILabel!
    @IBOutlet weak var championLabel: UILabel!
    @IBOutlet weak var galleryStackView: UIStackView!
    @IBOutlet weak var scrollViewGallery: UIScrollView!
    
    // MARK: - Model vars
    var championData: CDChampion!
    var championIndex = 0
    var allChampions: [CDChampion] = []
    
    let femaleChampions = ["Ashe", "Ahri", "Ambessa", "Akali", "Fiora", "Irelia", "Seraphine", "Riven", "Sivir", "Vi", "Zyra"]
    let maleChampions = ["Brand", "Braum", "Garen", "Heimerdinger", "Milio", "Viktor", "Wukong", "Xin Zhao"]
    
    let lightPink = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dacă `championData` a fost deja setat de segue, nu îl înlocui.
        if championData == nil {
            fetchChampionsFromCoreData()
            guard !allChampions.isEmpty else {
                print("Nu există campioni în baza de date.")
                return
            }
            championData = allChampions[championIndex]
        }

        scrollViewGallery.isPagingEnabled = true
        updateUI()
        setupConstraints()
        loadGalleryImages()
    }

    
    // MARK: - UI Update
    func updateUI() {
        championLabel.text = championData.name ?? ""
        championRoleLabel.text = championData.role ?? ""
        if let imageName = championData.image {
            championImageView.image = UIImage(named: imageName)
        }

        if let name = championData.name {
            if femaleChampions.contains(name) {
                view.backgroundColor = lightPink
            } else if maleChampions.contains(name) {
                view.backgroundColor = lightBlue
            } else {
                view.backgroundColor = UIColor.systemGray6
            }
        }

        self.title = "Champion"
    }

    func setupConstraints() {
        galleryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            galleryStackView.topAnchor.constraint(equalTo: scrollViewGallery.contentLayoutGuide.topAnchor),
            galleryStackView.bottomAnchor.constraint(equalTo: scrollViewGallery.contentLayoutGuide.bottomAnchor),
            galleryStackView.leadingAnchor.constraint(equalTo: scrollViewGallery.contentLayoutGuide.leadingAnchor),
            galleryStackView.trailingAnchor.constraint(equalTo: scrollViewGallery.contentLayoutGuide.trailingAnchor),
            galleryStackView.heightAnchor.constraint(equalTo: scrollViewGallery.frameLayoutGuide.heightAnchor)
        ])
    }

    // MARK: - Gallery
    func loadGalleryImages() {
        let images = (championData.gallery ?? "").components(separatedBy: ",")
        for imageName in images {
            if let image = UIImage(named: imageName.trimmingCharacters(in: .whitespaces)) {
                let imageGalleryView = UIImageView(image: image)
                imageGalleryView.contentMode = .scaleAspectFit
                imageGalleryView.clipsToBounds = true
                imageGalleryView.layer.cornerRadius = 8
                //imageGalleryView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                   // imageGalleryView.widthAnchor.constraint(equalToConstant: 100),
                   // imageGalleryView.heightAnchor.constraint(equalToConstant: 100)
                ])
                galleryStackView.addArrangedSubview(imageGalleryView)
            }
        }
    }

    // MARK: - Core Data Fetch
    func fetchChampionsFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDChampion> = CDChampion.fetchRequest()

        do {
            allChampions = try context.fetch(fetchRequest)
        } catch {
            print("Error to get data from Core Data: \(error)")
        }
    }
    
    
    func isFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunched")
        }
        return !launchedBefore
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque1" {
            if let destController = segue.destination as? DetailsViewController {
                destController.championData = self.championData
            }
        }
    }
}

