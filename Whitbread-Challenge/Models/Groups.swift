//
//  Groups.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Groups: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kGroupsTypeKey: String = "type"
	internal let kGroupsItemsKey: String = "items"
	internal let kGroupsCountKey: String = "count"
	internal let kGroupsNameKey: String = "name"


    // MARK: Properties
	public var type: String?
//	public var items: []?
	public var count: Int?
	public var name: String?


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
		type = json[kGroupsTypeKey].string
		if let tempValue = json[kGroupsItemsKey].array {
//			items = tempValue
		} else {
//			items = nil
		}
		count = json[kGroupsCountKey].int
		name = json[kGroupsNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if type != nil {
			dictionary.updateValue(type!, forKey: kGroupsTypeKey)
		}
		if count != nil {
			dictionary.updateValue(count!, forKey: kGroupsCountKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kGroupsNameKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.type = aDecoder.decodeObjectForKey(kGroupsTypeKey) as? String
		self.count = aDecoder.decodeObjectForKey(kGroupsCountKey) as? Int
		self.name = aDecoder.decodeObjectForKey(kGroupsNameKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(type, forKey: kGroupsTypeKey)
//		aCoder.encodeObject(items, forKey: kGroupsItemsKey)
		aCoder.encodeObject(count, forKey: kGroupsCountKey)
		aCoder.encodeObject(name, forKey: kGroupsNameKey)

    }

}
