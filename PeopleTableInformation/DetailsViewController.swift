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
    var championData : Champion!
    
    let femaleChampions = ["Ashe", "Ahri","Ambessa", "Akali", "Fiora", "Irelia" , "Seraphine" ,"Riven", "Sivir" , "Vi" , "Zyra"]
    let maleChampions = ["Brand", "Braum", "Garen", "Heimerdinger" , "Milio", "Viktor", "Wukong" , "Xin Zhao"]
    
    let lightPink = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = championData.name
        positionLabel.text = " Position: "+championData.position
        ultimateLabel.text = " Ultimate: "+championData.ultimate
        roleLabel.text = " Role: "+championData.role
        imageLabel.text = " Image: "+championData.image
        urlLabel.text = "Click to see web page!"
        
        nameLabel.layer.shadowOpacity = 0.1
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        ultimateLabel.layer.borderWidth = 1
        ultimateLabel.layer.cornerRadius = 5
        ultimateLabel.clipsToBounds = true
        
        positionLabel.layer.borderWidth = 1
        positionLabel.layer.cornerRadius = 5
        positionLabel.clipsToBounds = true
        
        roleLabel.layer.borderWidth = 1
        roleLabel.layer.cornerRadius = 5
        roleLabel.clipsToBounds = true
        
        imageLabel.layer.borderWidth = 1
        imageLabel.layer.cornerRadius = 5
        imageLabel.clipsToBounds = true
        
        urlLabel.layer.cornerRadius = 5
        urlLabel.clipsToBounds = true
        
        positionLabel.layer.shadowColor = nil
        ultimateLabel.layer.shadowColor = nil
        roleLabel.layer.shadowColor = nil
        imageLabel.layer.shadowColor = nil
        
        if femaleChampions.contains(championData.name){
            view.backgroundColor = lightPink
            
            nameLabel.textColor = UIColor.red
            
            positionLabel.layer.borderColor = UIColor.red.cgColor
            ultimateLabel.layer.borderColor = UIColor.red.cgColor
            roleLabel.layer.borderColor = UIColor.red.cgColor
            imageLabel.layer.borderColor = UIColor.red.cgColor
        
        }else if maleChampions.contains(championData.name){
            view.backgroundColor = lightBlue
            
            nameLabel.textColor = UIColor.blue
            
            positionLabel.layer.borderColor = UIColor.blue.cgColor
            ultimateLabel.layer.borderColor = UIColor.blue.cgColor
            roleLabel.layer.borderColor = UIColor.blue.cgColor
            imageLabel.layer.borderColor = UIColor.blue.cgColor
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
