//
//  Categories.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Categories: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kCategoriesPluralNameKey: String = "pluralName"
	internal let kCategoriesPrimaryKey: String = "primary"
	internal let kCategoriesIconKey: String = "icon"
	internal let kCategoriesInternalIdentifierKey: String = "id"
	internal let kCategoriesShortNameKey: String = "shortName"
	internal let kCategoriesNameKey: String = "name"


    // MARK: Properties
	public var pluralName: String?
	public var primary: Bool = false
	public var icon: Icon?
	public var internalIdentifier: String?
	public var shortName: String?
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
		pluralName = json[kCategoriesPluralNameKey].string
		primary = json[kCategoriesPrimaryKey].boolValue
		icon = Icon(json: json[kCategoriesIconKey])
		internalIdentifier = json[kCategoriesInternalIdentifierKey].string
		shortName = json[kCategoriesShortNameKey].string
		name = json[kCategoriesNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if pluralName != nil {
			dictionary.updateValue(pluralName!, forKey: kCategoriesPluralNameKey)
		}
		dictionary.updateValue(primary, forKey: kCategoriesPrimaryKey)
		if icon != nil {
			dictionary.updateValue(icon!.dictionaryRepresentation(), forKey: kCategoriesIconKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kCategoriesInternalIdentifierKey)
		}
		if shortName != nil {
			dictionary.updateValue(shortName!, forKey: kCategoriesShortNameKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kCategoriesNameKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.pluralName = aDecoder.decodeObjectForKey(kCategoriesPluralNameKey) as? String
		self.primary = aDecoder.decodeBoolForKey(kCategoriesPrimaryKey)
		self.icon = aDecoder.decodeObjectForKey(kCategoriesIconKey) as? Icon
		self.internalIdentifier = aDecoder.decodeObjectForKey(kCategoriesInternalIdentifierKey) as? String
		self.shortName = aDecoder.decodeObjectForKey(kCategoriesShortNameKey) as? String
		self.name = aDecoder.decodeObjectForKey(kCategoriesNameKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(pluralName, forKey: kCategoriesPluralNameKey)
		aCoder.encodeBool(primary, forKey: kCategoriesPrimaryKey)
		aCoder.encodeObject(icon, forKey: kCategoriesIconKey)
		aCoder.encodeObject(internalIdentifier, forKey: kCategoriesInternalIdentifierKey)
		aCoder.encodeObject(shortName, forKey: kCategoriesShortNameKey)
		aCoder.encodeObject(name, forKey: kCategoriesNameKey)

    }

}
