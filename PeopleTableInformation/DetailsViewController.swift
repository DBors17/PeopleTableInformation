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
    
    // MARK: - Data
    var championData : Champion!
    
    let femaleChampions = ["Ashe", "Ahri","Ambessa", "Akali", "Fiora", "Irelia" , "Seraphine" ,"Riven", "Sivir" , "Vi" , "Zyra"]
    let maleChampions = ["Brand", "Braum", "Garen", "Heimerdinger" , "Milio", "Viktor", "Wukong" , "Xin Zhao"]
    
    let lightPink = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = championData.name
        positionLabel.text = "Position: "+championData.position
        ultimateLabel.text = "Ultimate: "+championData.ultimate
        roleLabel.text = "Role: "+championData.role
        imageLabel.text = "Image: "+championData.image
        urlLabel.text = "Click to see web page!"
        
        if femaleChampions.contains(championData.name){
            view.backgroundColor = lightPink
        }else if maleChampions.contains(championData.name){
            view.backgroundColor = lightBlue
        }else{
            view.backgroundColor = UIColor.systemGray6
        }
    
        self.title = "Details"
        
        urlLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(openWebPage))
        urlLabel.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Actions
    @objc func openWebPage(){
        let urlString = championData.url
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController{
        webVC.urlString = urlString
        navigationController?.pushViewController(webVC, animated: true)
    }
  }
}
