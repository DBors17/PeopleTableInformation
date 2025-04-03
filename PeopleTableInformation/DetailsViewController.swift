//
//  DetailsViewController.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import UIKit

class DetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = championData.name
        positionLabel.text = championData.position
        ultimateLabel.text = championData.ultimate
        roleLabel.text = championData.role
        imageLabel.text = championData.image
        urlLabel.text = championData.url
    
        self.title = "Details"
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var ultimateLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    var championData : Champion!
}
