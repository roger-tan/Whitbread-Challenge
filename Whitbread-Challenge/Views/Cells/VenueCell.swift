//
//  VenueCell.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    var viewModel: VenueViewModel? {
        didSet {
            self.nameLabel.text = viewModel?.nameText
            self.distanceLabel.text = viewModel?.distanceText
        }
    }

}
