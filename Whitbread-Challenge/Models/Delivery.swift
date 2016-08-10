//
//  Delivery.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Delivery: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDeliveryInternalIdentifierKey: String = "id"
	internal let kDeliveryProviderKey: String = "provider"
	internal let kDeliveryUrlKey: String = "url"


    // MARK: Properties
	public var internalIdentifier: String?
	public var provider: Provider?
	public var url: String?


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
		internalIdentifier = json[kDeliveryInternalIdentifierKey].string
		provider = Provider(json: json[kDeliveryProviderKey])
		url = json[kDeliveryUrlKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kDeliveryInternalIdentifierKey)
		}
		if provider != nil {
			dictionary.updateValue(provider!.dictionaryRepresentation(), forKey: kDeliveryProviderKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kDeliveryUrlKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.internalIdentifier = aDecoder.decodeObjectForKey(kDeliveryInternalIdentifierKey) as? String
		self.provider = aDecoder.decodeObjectForKey(kDeliveryProviderKey) as? Provider
		self.url = aDecoder.decodeObjectForKey(kDeliveryUrlKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(internalIdentifier, forKey: kDeliveryInternalIdentifierKey)
		aCoder.encodeObject(provider, forKey: kDeliveryProviderKey)
		aCoder.encodeObject(url, forKey: kDeliveryUrlKey)

    }

}
