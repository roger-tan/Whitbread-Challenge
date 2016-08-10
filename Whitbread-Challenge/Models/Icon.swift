//
//  Icon.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Icon: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kIconSuffixKey: String = "suffix"
	internal let kIconPrefixKey: String = "prefix"


    // MARK: Properties
	public var suffix: String?
	public var prefix: String?


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
		suffix = json[kIconSuffixKey].string
		prefix = json[kIconPrefixKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if suffix != nil {
			dictionary.updateValue(suffix!, forKey: kIconSuffixKey)
		}
		if prefix != nil {
			dictionary.updateValue(prefix!, forKey: kIconPrefixKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.suffix = aDecoder.decodeObjectForKey(kIconSuffixKey) as? String
		self.prefix = aDecoder.decodeObjectForKey(kIconPrefixKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(suffix, forKey: kIconSuffixKey)
		aCoder.encodeObject(prefix, forKey: kIconPrefixKey)

    }

}
