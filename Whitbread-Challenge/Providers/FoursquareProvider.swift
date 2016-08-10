//
//  FoursquareProvider.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import Foundation
import Moya

let FoursquareProvider = MoyaProvider<Foursquare>()

public enum Foursquare {
    case SearchVenues(query: String)
}

extension Foursquare: TargetType {
    
    public var baseURL: NSURL { return NSURL(string: "https://api.foursquare.com/v2/")! }
    
    public var path: String {
        switch self {
        case .SearchVenues(query: _):
            return "venues/search"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .SearchVenues(query: let query):
            return [
                "ll": "40.7,-74",
                "oauth_token": "Z4FPVB1H5SJUGPOHZHCUO2ONBGMDOOLPDCWAFODQ15QOXTR0",
                "v": "20160810",
                "query": query
            ]
        }
    }
    
    //TODO: Write the json...
    public var sampleData: NSData {
        switch self {
        case .SearchVenues(query: _):
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