//
//  CustomCell.swift
//  PeopleTableInformation
//
//  Created by Dorin on 06.04.2025.
//

import Foundation
import UIKit

// MARK: - Protocol
protocol CustomCellDelegate: AnyObject {
    func editButtonTapped(on cell: CustomCell)
}

// MARK: - Custom Cell
class CustomCell: UITableViewCell {

    @IBOutlet weak var cellChampionNameLabel: UILabel!
    @IBOutlet weak var cellChampionDetailsLabel: UILabel!
    @IBOutlet weak var cellChampionImage: UIImageView!

    weak var delegate: CustomCellDelegate?

    @IBAction func editButtonPressed(_ sender: UIButton) {
        delegate?.editButtonTapped(on: self)
    }
}
