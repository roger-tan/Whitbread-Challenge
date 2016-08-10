//
//  Notifications.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Notifications: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kNotificationsItemKey: String = "item"
	internal let kNotificationsTypeKey: String = "type"


    // MARK: Properties
	public var item: Item?
	public var type: String?


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
		item = Item(json: json[kNotificationsItemKey])
		type = json[kNotificationsTypeKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if item != nil {
			dictionary.updateValue(item!.dictionaryRepresentation(), forKey: kNotificationsItemKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kNotificationsTypeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.item = aDecoder.decodeObjectForKey(kNotificationsItemKey) as? Item
		self.type = aDecoder.decodeObjectForKey(kNotificationsTypeKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(item, forKey: kNotificationsItemKey)
		aCoder.encodeObject(type, forKey: kNotificationsTypeKey)

    }

}
