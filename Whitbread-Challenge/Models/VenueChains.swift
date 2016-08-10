//
//  VenueChains.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class VenueChains: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kVenueChainsInternalIdentifierKey: String = "id"


    // MARK: Properties
	public var internalIdentifier: String?


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
		internalIdentifier = json[kVenueChainsInternalIdentifierKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kVenueChainsInternalIdentifierKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.internalIdentifier = aDecoder.decodeObjectForKey(kVenueChainsInternalIdentifierKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(internalIdentifier, forKey: kVenueChainsInternalIdentifierKey)

    }

}
