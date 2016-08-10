//
//  FoursquareProvider.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import Foundation
import Moya
import CoreLocation

let FoursquareProvider = MoyaProvider<Foursquare>()

public enum Foursquare {
    case SearchVenues(query: String, nearLocation: CLLocation)
}

extension Foursquare: TargetType {
    
    public var baseURL: NSURL { return NSURL(string: "https://api.foursquare.com/v2/")! }
    
    public var path: String {
        switch self {
        case .SearchVenues(_, _):
            return "venues/search"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .SearchVenues(let query, let nearLocation):
            return [
                "ll": "\(nearLocation.coordinate.latitude), \(nearLocation.coordinate.longitude)",
                "oauth_token": "Z4FPVB1H5SJUGPOHZHCUO2ONBGMDOOLPDCWAFODQ15QOXTR0", // TODO: Change token to use Info.plist
                "v": "20160810", // Last version
                "query": query
            ]
        }
    }
    
    //TODO: Write the json...
    public var sampleData: NSData {
        switch self {
        case .SearchVenues(_, _):
            return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return .URL
        }
    }
    
}