//
//  Specials.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Specials: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSpecialsCountKey: String = "count"
	internal let kSpecialsItemsKey: String = "items"


    // MARK: Properties
	public var count: Int?
	public var items: [Items]?


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
		count = json[kSpecialsCountKey].int
		items = []
		if let items = json[kSpecialsItemsKey].array {
			for item in items {
				items?.append(Items(json: item))
			}
		} else {
			items = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if count != nil {
			dictionary.updateValue(count!, forKey: kSpecialsCountKey)
		}
		if items?.count > 0 {
			var temp: [AnyObject] = []
			for item in items! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kSpecialsItemsKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.count = aDecoder.decodeObjectForKey(kSpecialsCountKey) as? Int
		self.items = aDecoder.decodeObjectForKey(kSpecialsItemsKey) as? [Items]

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(count, forKey: kSpecialsCountKey)
		aCoder.encodeObject(items, forKey: kSpecialsItemsKey)

    }

}
