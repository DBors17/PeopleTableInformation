//
//  ViewController.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import UIKit

class ViewController: UIViewController{
    
    @IBAction func moreInfoAction(_ sender: Any){
    }
    
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var personLabel: UILabel!
    
    func update(){
        personLabel.text = personData.name
        
        //populate outlets with data
        personImageView.image = UIImage(named: personData.image)
    }
    
    //MARK: -model vars
    var personData : Person!
    
    var personIndex = 0
    
    var peopleData : People!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get model data
        peopleData = People(name : "people.xml")
        
        //personData = personData.getPerson(index: personIndex)
        
        personLabel.text = personData.name
        
        //populate outlets with data
        personImageView.image = UIImage(named: personData.image)
        
        self.title = "Person"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "seque1"{
            let destController = segue.destination as! DetailsViewController
            
            destController.personData = self.personData
        }
    }
    
    
}
