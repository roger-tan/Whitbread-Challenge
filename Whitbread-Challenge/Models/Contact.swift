//
//  Contact.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Contact: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kContactTwitterKey: String = "twitter"
	internal let kContactFacebookUsernameKey: String = "facebookUsername"
	internal let kContactFormattedPhoneKey: String = "formattedPhone"
	internal let kContactFacebookNameKey: String = "facebookName"
	internal let kContactFacebookKey: String = "facebook"
	internal let kContactPhoneKey: String = "phone"


    // MARK: Properties
	public var twitter: String?
	public var facebookUsername: String?
	public var formattedPhone: String?
	public var facebookName: String?
	public var facebook: String?
	public var phone: String?


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
		twitter = json[kContactTwitterKey].string
		facebookUsername = json[kContactFacebookUsernameKey].string
		formattedPhone = json[kContactFormattedPhoneKey].string
		facebookName = json[kContactFacebookNameKey].string
		facebook = json[kContactFacebookKey].string
		phone = json[kContactPhoneKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if twitter != nil {
			dictionary.updateValue(twitter!, forKey: kContactTwitterKey)
		}
		if facebookUsername != nil {
			dictionary.updateValue(facebookUsername!, forKey: kContactFacebookUsernameKey)
		}
		if formattedPhone != nil {
			dictionary.updateValue(formattedPhone!, forKey: kContactFormattedPhoneKey)
		}
		if facebookName != nil {
			dictionary.updateValue(facebookName!, forKey: kContactFacebookNameKey)
		}
		if facebook != nil {
			dictionary.updateValue(facebook!, forKey: kContactFacebookKey)
		}
		if phone != nil {
			dictionary.updateValue(phone!, forKey: kContactPhoneKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.twitter = aDecoder.decodeObjectForKey(kContactTwitterKey) as? String
		self.facebookUsername = aDecoder.decodeObjectForKey(kContactFacebookUsernameKey) as? String
		self.formattedPhone = aDecoder.decodeObjectForKey(kContactFormattedPhoneKey) as? String
		self.facebookName = aDecoder.decodeObjectForKey(kContactFacebookNameKey) as? String
		self.facebook = aDecoder.decodeObjectForKey(kContactFacebookKey) as? String
		self.phone = aDecoder.decodeObjectForKey(kContactPhoneKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(twitter, forKey: kContactTwitterKey)
		aCoder.encodeObject(facebookUsername, forKey: kContactFacebookUsernameKey)
		aCoder.encodeObject(formattedPhone, forKey: kContactFormattedPhoneKey)
		aCoder.encodeObject(facebookName, forKey: kContactFacebookNameKey)
		aCoder.encodeObject(facebook, forKey: kContactFacebookKey)
		aCoder.encodeObject(phone, forKey: kContactPhoneKey)

    }

}
