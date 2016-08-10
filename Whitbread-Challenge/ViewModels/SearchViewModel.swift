//
//  SearchViewModel.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class SearchViewModel {

    var previousResults: [VenueViewModel] = [VenueViewModel]()
    
    func executeSearch(query: String, nearLocation: CLLocation, completion: (venues: [VenueViewModel]?, error: NSError?) -> Void) {
        FoursquareProvider.request(.SearchVenues(query: query, nearLocation: nearLocation), completion: { (result) in
            switch result {
            case let .Success(response):
                let json = JSON(data: response.data)
                switch response.statusCode {
                case 200 ... 299:
                    let searchResult = Search(json: json)
                    let venues = self.getOnlyVenueViewModels(searchResult)
                    self.previousResults = venues
                    completion(venues: venues, error: nil)
                    break
                default:
                    // Do generic
                    // completion(venues: nil, error: nil)
                    break
                }
            case let .Failure(error):
                guard let error = error as? NSError else {
                    break
                }
                completion(venues: nil, error: error)
            }
        })
    }
    
    /**
     Converts a Search Result Object to an array of Venues View
     
     - parameter searchResult: query to search
     
     - returns: An array of VenueViewModel
     */
    private func getOnlyVenueViewModels(searchResult: Search) -> [VenueViewModel] {
        var venueViewModels = [VenueViewModel]()
        
        if let venues = searchResult.response?.venues {
            for venue in venues {
                venueViewModels.append(VenueViewModel(venue: venue))
            }
        } else {
            return []
        }
        return venueViewModels
    }
    
}