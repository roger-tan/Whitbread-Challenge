//
//  HereNow.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class HereNow: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kHereNowGroupsKey: String = "groups"
	internal let kHereNowCountKey: String = "count"
	internal let kHereNowSummaryKey: String = "summary"


    // MARK: Properties
	public var groups: [Groups]?
	public var count: Int?
	public var summary: String?


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
		groups = []
		if let items = json[kHereNowGroupsKey].array {
			for item in items {
				groups?.append(Groups(json: item))
			}
		} else {
			groups = nil
		}
		count = json[kHereNowCountKey].int
		summary = json[kHereNowSummaryKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if groups?.count > 0 {
			var temp: [AnyObject] = []
			for item in groups! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kHereNowGroupsKey)
		}
		if count != nil {
			dictionary.updateValue(count!, forKey: kHereNowCountKey)
		}
		if summary != nil {
			dictionary.updateValue(summary!, forKey: kHereNowSummaryKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.groups = aDecoder.decodeObjectForKey(kHereNowGroupsKey) as? [Groups]
		self.count = aDecoder.decodeObjectForKey(kHereNowCountKey) as? Int
		self.summary = aDecoder.decodeObjectForKey(kHereNowSummaryKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(groups, forKey: kHereNowGroupsKey)
		aCoder.encodeObject(count, forKey: kHereNowCountKey)
		aCoder.encodeObject(summary, forKey: kHereNowSummaryKey)

    }

}
