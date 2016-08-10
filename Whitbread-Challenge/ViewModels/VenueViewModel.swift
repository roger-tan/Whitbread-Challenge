//
//  VenueViewModel.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

class VenueViewModel {
    
    let venue: Venues
    var nameText: String {
        get {
            return venue.name ?? ""
        }
    }
    
    var distanceText: String {
        get {
            if let distance = venue.location?.distance {
                return "\(distance) m"
            }
            return "0m"
        }
    }
    
    var addressText: String {
        get {
            if let address = venue.location?.address {
                return address
            }
            return ""
        }
    }
    
    init(venue: Venues) {
        self.venue = venue
    }
    
}