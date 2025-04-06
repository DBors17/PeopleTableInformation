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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = championData.name
        positionLabel.text = championData.position
        ultimateLabel.text = championData.ultimate
        roleLabel.text = championData.role
        imageLabel.text = championData.image
        urlLabel.text = championData.url
    
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
