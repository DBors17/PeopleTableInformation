//
//  DetailsViewController.swift
//  PeopleTableInformation
//
//  Created by Dorin on 29.03.2025.
//

import UIKit

class DetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = personData.name
        phoneLabel.text = personData.phone
        emailLabel.text = personData.email
        imageLabel.text = personData.image
        urlLabel.text = personData.url
    
        self.title = "Details"
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var personData : Person!
}
