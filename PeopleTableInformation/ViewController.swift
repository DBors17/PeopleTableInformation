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
    
    @IBOutlet weak var championLabel: UILabel!
    
    func update(){
        championLabel.text = championData.name
        
        //populate outlets with data
        championImageView.image = UIImage(named: championData.image)
    }
    
    //MARK: -model vars
    var championData : Champion!
    
    var championIndex = 0
    
    var wildriftData : Wildrift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get model data
        wildriftData = Wildrift(name : "champions.xml")
        
        //personData = personData.getPerson(index: personIndex)
        
        championLabel.text = championData.name
        
        //populate outlets with data
        championImageView.image = UIImage(named: championData.image)
        
        self.title = "Champion"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "seque1"{
            let destController = segue.destination as! DetailsViewController
            
            destController.championData = self.championData
        }
    }
    
    
}
