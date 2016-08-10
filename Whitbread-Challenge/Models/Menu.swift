//
//  Menu.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Menu: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMenuAnchorKey: String = "anchor"
	internal let kMenuLabelKey: String = "label"
	internal let kMenuTypeKey: String = "type"
	internal let kMenuMobileUrlKey: String = "mobileUrl"
	internal let kMenuUrlKey: String = "url"


    // MARK: Properties
	public var anchor: String?
	public var label: String?
	public var type: String?
	public var mobileUrl: String?
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
		anchor = json[kMenuAnchorKey].string
		label = json[kMenuLabelKey].string
		type = json[kMenuTypeKey].string
		mobileUrl = json[kMenuMobileUrlKey].string
		url = json[kMenuUrlKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if anchor != nil {
			dictionary.updateValue(anchor!, forKey: kMenuAnchorKey)
		}
		if label != nil {
			dictionary.updateValue(label!, forKey: kMenuLabelKey)
		}
		if type != nil {
			dictionary.updateValue(type!, forKey: kMenuTypeKey)
		}
		if mobileUrl != nil {
			dictionary.updateValue(mobileUrl!, forKey: kMenuMobileUrlKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kMenuUrlKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.anchor = aDecoder.decodeObjectForKey(kMenuAnchorKey) as? String
		self.label = aDecoder.decodeObjectForKey(kMenuLabelKey) as? String
		self.type = aDecoder.decodeObjectForKey(kMenuTypeKey) as? String
		self.mobileUrl = aDecoder.decodeObjectForKey(kMenuMobileUrlKey) as? String
		self.url = aDecoder.decodeObjectForKey(kMenuUrlKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(anchor, forKey: kMenuAnchorKey)
		aCoder.encodeObject(label, forKey: kMenuLabelKey)
		aCoder.encodeObject(type, forKey: kMenuTypeKey)
		aCoder.encodeObject(mobileUrl, forKey: kMenuMobileUrlKey)
		aCoder.encodeObject(url, forKey: kMenuUrlKey)

    }

}
