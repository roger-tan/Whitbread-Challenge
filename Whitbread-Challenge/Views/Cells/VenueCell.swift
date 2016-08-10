//
//  VenueCell.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {

    var viewModel: VenueViewModel? {
        didSet {
            self.textLabel?.text = viewModel?.nameText
        }
    }

}
