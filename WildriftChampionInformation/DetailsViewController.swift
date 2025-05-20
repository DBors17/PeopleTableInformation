//
//  DetailsViewController.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var ultimateLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    // MARK: - Data and style elements
    var championData: CDChampion!
    
    let femaleChampions = ["Ashe", "Ahri", "Ambessa", "Akali", "Fiora", "Irelia", "Seraphine", "Riven", "Sivir", "Vi", "Zyra"]
    let maleChampions = ["Brand", "Braum", "Garen", "Heimerdinger", "Milio", "Viktor", "Wukong", "Xin Zhao"]
    
    let lightPink = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = championData.name ?? ""
        positionLabel.text = " Position: " + (championData.position ?? "")
        ultimateLabel.text = " Ultimate: " + (championData.ultimate ?? "")
        roleLabel.text = " Role: " + (championData.role ?? "")
        imageLabel.text = " Image: " + (championData.image ?? "")
        urlLabel.text = "Click to see web page!"
        
        nameLabel.layer.shadowOpacity = 0.1
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        [positionLabel, ultimateLabel, roleLabel, imageLabel].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = 5
            $0?.clipsToBounds = true
            $0?.layer.shadowColor = nil
        }
        
        urlLabel.layer.cornerRadius = 5
        urlLabel.clipsToBounds = true
        
        
        if let name = championData.name {
            if femaleChampions.contains(name) {
                view.backgroundColor = lightPink
                nameLabel.textColor = UIColor.red
                setBorderColor(.red)
            } else if maleChampions.contains(name) {
                view.backgroundColor = lightBlue
                nameLabel.textColor = UIColor.blue
                setBorderColor(.blue)
            } else {
                view.backgroundColor = UIColor.systemGray6
            }
        }
        
        self.title = "Details"
        
        urlLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWebPage))
        urlLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Helpers
    
    private func setBorderColor(_ color: UIColor) {
        positionLabel.layer.borderColor = color.cgColor
        ultimateLabel.layer.borderColor = color.cgColor
        roleLabel.layer.borderColor = color.cgColor
        imageLabel.layer.borderColor = color.cgColor
    }
    
    // MARK: - Actions
    
    @objc func openWebPage() {
        guard let urlString = championData.url else {
            print("URL invalid")
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webVC.urlString = urlString
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

