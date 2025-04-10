//
//  ViewController.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import UIKit

class ViewController: UIViewController{
    
    @IBAction func moreInfoAction(_ sender: Any){
    }
    
    @IBOutlet weak var championImageView: UIImageView!
    
    @IBOutlet weak var championRoleLabel: UILabel!
    
    @IBOutlet weak var championLabel: UILabel!
    
    @IBOutlet weak var galleryStackView: UIStackView!
    
    @IBOutlet weak var scrollViewGallery: UIScrollView!
    
    func update(){
        championLabel.text = championData.name
        
        //populate outlets with data
        championImageView.image = UIImage(named: championData.image)
    }
    
    //MARK: -model vars
    var championData : Champion!
    
    var championIndex = 0
    
    var wildriftData : Wildrift!
    
    let femaleChampions = ["Ashe", "Ahri","Ambessa", "Akali", "Fiora", "Irelia" , "Seraphine" ,"Riven", "Sivir" , "Vi" , "Zyra"]
    let maleChampions = ["Brand", "Braum", "Garen", "Heimerdinger" , "Milio", "Viktor", "Wukong" , "Xin Zhao"]
    
    let lightPink = UIColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    let lightBlue = UIColor(red: 0.7, green: 0.85, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get model data
        wildriftData = Wildrift(name : "champions.xml")
        
        scrollViewGallery.isPagingEnabled = true
        
        //populate outlets with data
        championLabel.text = championData.name
        championRoleLabel.text = championData.role
        championImageView.image = UIImage(named: championData.image)
        
        if femaleChampions.contains(championData.name){
            view.backgroundColor = lightPink
        }else if maleChampions.contains(championData.name){
            view.backgroundColor = lightBlue
        }else{
            view.backgroundColor = UIColor.systemGray6
        }
        
        self.title = "Champion"
        
        // load images
        loadGalleryImages()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "seque1"{
            let destController = segue.destination as! DetailsViewController
            
            destController.championData = self.championData
        }
    }
    
    func loadGalleryImages(){
        for imageName in championData.gallery{
            if let image = UIImage(named: imageName){
                let imageGalleryView = UIImageView(image: image)
                imageGalleryView.contentMode = .scaleAspectFit
                imageGalleryView.clipsToBounds = true
                imageGalleryView.layer.cornerRadius = 8
                imageGalleryView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageGalleryView.widthAnchor.constraint(equalToConstant: 150),
                    imageGalleryView.heightAnchor.constraint(equalToConstant: 150)
                ])
                galleryStackView.addArrangedSubview(imageGalleryView)
            }
        }
    }
    
    
}
