//
//  Search.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Search: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSearchResponseKey: String = "response"
	internal let kSearchNotificationsKey: String = "notifications"
	internal let kSearchMetaKey: String = "meta"


    // MARK: Properties
	public var response: Response?
	public var notifications: [Notifications]?
	public var meta: Meta?


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
		response = Response(json: json[kSearchResponseKey])
		notifications = []
		if let items = json[kSearchNotificationsKey].array {
			for item in items {
				notifications?.append(Notifications(json: item))
			}
		} else {
			notifications = nil
		}
		meta = Meta(json: json[kSearchMetaKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if response != nil {
			dictionary.updateValue(response!.dictionaryRepresentation(), forKey: kSearchResponseKey)
		}
		if notifications?.count > 0 {
			var temp: [AnyObject] = []
			for item in notifications! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kSearchNotificationsKey)
		}
		if meta != nil {
			dictionary.updateValue(meta!.dictionaryRepresentation(), forKey: kSearchMetaKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.response = aDecoder.decodeObjectForKey(kSearchResponseKey) as? Response
		self.notifications = aDecoder.decodeObjectForKey(kSearchNotificationsKey) as? [Notifications]
		self.meta = aDecoder.decodeObjectForKey(kSearchMetaKey) as? Meta

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(response, forKey: kSearchResponseKey)
		aCoder.encodeObject(notifications, forKey: kSearchNotificationsKey)
		aCoder.encodeObject(meta, forKey: kSearchMetaKey)

    }

}
