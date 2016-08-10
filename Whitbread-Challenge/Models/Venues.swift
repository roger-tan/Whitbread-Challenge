//
//  Venues.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Venues: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kVenuesCategoriesKey: String = "categories"
	internal let kVenuesHereNowKey: String = "hereNow"
	internal let kVenuesAllowMenuUrlEditKey: String = "allowMenuUrlEdit"
	internal let kVenuesReferralIdKey: String = "referralId"
	internal let kVenuesVerifiedKey: String = "verified"
	internal let kVenuesLocationKey: String = "location"
	internal let kVenuesHasMenuKey: String = "hasMenu"
	internal let kVenuesContactKey: String = "contact"
	internal let kVenuesNameKey: String = "name"
	internal let kVenuesStatsKey: String = "stats"
	internal let kVenuesDeliveryKey: String = "delivery"
	internal let kVenuesInternalIdentifierKey: String = "id"
	internal let kVenuesSpecialsKey: String = "specials"
	internal let kVenuesHasPerkKey: String = "hasPerk"
	internal let kVenuesMenuKey: String = "menu"
	internal let kVenuesVenueChainsKey: String = "venueChains"
	internal let kVenuesUrlKey: String = "url"


    // MARK: Properties
	public var categories: [Categories]?
	public var hereNow: HereNow?
	public var allowMenuUrlEdit: Bool = false
	public var referralId: String?
	public var verified: Bool = false
	public var location: Location?
	public var hasMenu: Bool = false
	public var contact: Contact?
	public var name: String?
	public var stats: Stats?
	public var delivery: Delivery?
	public var internalIdentifier: String?
	public var specials: Specials?
	public var hasPerk: Bool = false
	public var menu: Menu?
	public var venueChains: [VenueChains]?
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
		categories = []
		if let items = json[kVenuesCategoriesKey].array {
			for item in items {
				categories?.append(Categories(json: item))
			}
		} else {
			categories = nil
		}
		hereNow = HereNow(json: json[kVenuesHereNowKey])
		allowMenuUrlEdit = json[kVenuesAllowMenuUrlEditKey].boolValue
		referralId = json[kVenuesReferralIdKey].string
		verified = json[kVenuesVerifiedKey].boolValue
		location = Location(json: json[kVenuesLocationKey])
		hasMenu = json[kVenuesHasMenuKey].boolValue
		contact = Contact(json: json[kVenuesContactKey])
		name = json[kVenuesNameKey].string
		stats = Stats(json: json[kVenuesStatsKey])
		delivery = Delivery(json: json[kVenuesDeliveryKey])
		internalIdentifier = json[kVenuesInternalIdentifierKey].string
		specials = Specials(json: json[kVenuesSpecialsKey])
		hasPerk = json[kVenuesHasPerkKey].boolValue
		menu = Menu(json: json[kVenuesMenuKey])
		venueChains = []
		if let items = json[kVenuesVenueChainsKey].array {
			for item in items {
				venueChains?.append(VenueChains(json: item))
			}
		} else {
			venueChains = nil
		}
		url = json[kVenuesUrlKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if categories?.count > 0 {
			var temp: [AnyObject] = []
			for item in categories! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kVenuesCategoriesKey)
		}
		if hereNow != nil {
			dictionary.updateValue(hereNow!.dictionaryRepresentation(), forKey: kVenuesHereNowKey)
		}
		dictionary.updateValue(allowMenuUrlEdit, forKey: kVenuesAllowMenuUrlEditKey)
		if referralId != nil {
			dictionary.updateValue(referralId!, forKey: kVenuesReferralIdKey)
		}
		dictionary.updateValue(verified, forKey: kVenuesVerifiedKey)
		if location != nil {
			dictionary.updateValue(location!.dictionaryRepresentation(), forKey: kVenuesLocationKey)
		}
		dictionary.updateValue(hasMenu, forKey: kVenuesHasMenuKey)
		if contact != nil {
			dictionary.updateValue(contact!.dictionaryRepresentation(), forKey: kVenuesContactKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kVenuesNameKey)
		}
		if stats != nil {
			dictionary.updateValue(stats!.dictionaryRepresentation(), forKey: kVenuesStatsKey)
		}
		if delivery != nil {
			dictionary.updateValue(delivery!.dictionaryRepresentation(), forKey: kVenuesDeliveryKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kVenuesInternalIdentifierKey)
		}
		if specials != nil {
			dictionary.updateValue(specials!.dictionaryRepresentation(), forKey: kVenuesSpecialsKey)
		}
		dictionary.updateValue(hasPerk, forKey: kVenuesHasPerkKey)
		if menu != nil {
			dictionary.updateValue(menu!.dictionaryRepresentation(), forKey: kVenuesMenuKey)
		}
		if venueChains?.count > 0 {
			var temp: [AnyObject] = []
			for item in venueChains! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kVenuesVenueChainsKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kVenuesUrlKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.categories = aDecoder.decodeObjectForKey(kVenuesCategoriesKey) as? [Categories]
		self.hereNow = aDecoder.decodeObjectForKey(kVenuesHereNowKey) as? HereNow
		self.allowMenuUrlEdit = aDecoder.decodeBoolForKey(kVenuesAllowMenuUrlEditKey)
		self.referralId = aDecoder.decodeObjectForKey(kVenuesReferralIdKey) as? String
		self.verified = aDecoder.decodeBoolForKey(kVenuesVerifiedKey)
		self.location = aDecoder.decodeObjectForKey(kVenuesLocationKey) as? Location
		self.hasMenu = aDecoder.decodeBoolForKey(kVenuesHasMenuKey)
		self.contact = aDecoder.decodeObjectForKey(kVenuesContactKey) as? Contact
		self.name = aDecoder.decodeObjectForKey(kVenuesNameKey) as? String
		self.stats = aDecoder.decodeObjectForKey(kVenuesStatsKey) as? Stats
		self.delivery = aDecoder.decodeObjectForKey(kVenuesDeliveryKey) as? Delivery
		self.internalIdentifier = aDecoder.decodeObjectForKey(kVenuesInternalIdentifierKey) as? String
		self.specials = aDecoder.decodeObjectForKey(kVenuesSpecialsKey) as? Specials
		self.hasPerk = aDecoder.decodeBoolForKey(kVenuesHasPerkKey)
		self.menu = aDecoder.decodeObjectForKey(kVenuesMenuKey) as? Menu
		self.venueChains = aDecoder.decodeObjectForKey(kVenuesVenueChainsKey) as? [VenueChains]
		self.url = aDecoder.decodeObjectForKey(kVenuesUrlKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(categories, forKey: kVenuesCategoriesKey)
		aCoder.encodeObject(hereNow, forKey: kVenuesHereNowKey)
		aCoder.encodeBool(allowMenuUrlEdit, forKey: kVenuesAllowMenuUrlEditKey)
		aCoder.encodeObject(referralId, forKey: kVenuesReferralIdKey)
		aCoder.encodeBool(verified, forKey: kVenuesVerifiedKey)
		aCoder.encodeObject(location, forKey: kVenuesLocationKey)
		aCoder.encodeBool(hasMenu, forKey: kVenuesHasMenuKey)
		aCoder.encodeObject(contact, forKey: kVenuesContactKey)
		aCoder.encodeObject(name, forKey: kVenuesNameKey)
		aCoder.encodeObject(stats, forKey: kVenuesStatsKey)
		aCoder.encodeObject(delivery, forKey: kVenuesDeliveryKey)
		aCoder.encodeObject(internalIdentifier, forKey: kVenuesInternalIdentifierKey)
		aCoder.encodeObject(specials, forKey: kVenuesSpecialsKey)
		aCoder.encodeBool(hasPerk, forKey: kVenuesHasPerkKey)
		aCoder.encodeObject(menu, forKey: kVenuesMenuKey)
		aCoder.encodeObject(venueChains, forKey: kVenuesVenueChainsKey)
		aCoder.encodeObject(url, forKey: kVenuesUrlKey)

    }

}
