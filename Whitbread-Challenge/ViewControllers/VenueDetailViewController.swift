//
//  VenueDetailViewController.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    var viewModel: VenueViewModel? {
        didSet {
            self.title = viewModel?.nameText
        }
    }
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addressLabel: UILabel!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVenue()
    }
}

// MARK: - Setups
extension VenueDetailViewController {
    
    private func setupVenue() {
        if let viewModel = viewModel {
            self.addressLabel.text = viewModel.addressText
        }
    }
}
