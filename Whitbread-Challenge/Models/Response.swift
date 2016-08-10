//
//  Response.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Response: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kResponseConfidentKey: String = "confident"
	internal let kResponseVenuesKey: String = "venues"


    // MARK: Properties
	public var confident: Bool = false
	public var venues: [Venues]?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		confident = json[kResponseConfidentKey].boolValue
		venues = []
		if let items = json[kResponseVenuesKey].array {
			for item in items {
				venues?.append(Venues(json: item))
			}
		} else {
			venues = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		dictionary.updateValue(confident, forKey: kResponseConfidentKey)
		if venues?.count > 0 {
			var temp: [AnyObject] = []
			for item in venues! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kResponseVenuesKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.confident = aDecoder.decodeBoolForKey(kResponseConfidentKey)
		self.venues = aDecoder.decodeObjectForKey(kResponseVenuesKey) as? [Venues]

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeBool(confident, forKey: kResponseConfidentKey)
		aCoder.encodeObject(venues, forKey: kResponseVenuesKey)

    }

}
