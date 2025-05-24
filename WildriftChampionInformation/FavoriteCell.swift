//
//  FavoriteCell.swift
//  PeopleTableInformation
//
//  Created by Dorin on 24.05.2025.
//

import Foundation
import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var championImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        championImageView.image = nil
    }
}

