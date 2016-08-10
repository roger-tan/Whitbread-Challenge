//
//  Location.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Location: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kLocationCityKey: String = "city"
	internal let kLocationLngKey: String = "lng"
	internal let kLocationDistanceKey: String = "distance"
	internal let kLocationAddressKey: String = "address"
	internal let kLocationCountryKey: String = "country"
	internal let kLocationFormattedAddressKey: String = "formattedAddress"
	internal let kLocationLabeledLatLngsKey: String = "labeledLatLngs"
	internal let kLocationCcKey: String = "cc"
	internal let kLocationPostalCodeKey: String = "postalCode"
	internal let kLocationLatKey: String = "lat"
	internal let kLocationCrossStreetKey: String = "crossStreet"
	internal let kLocationStateKey: String = "state"


    // MARK: Properties
	public var city: String?
	public var lng: Float?
	public var distance: Int?
	public var address: String?
	public var country: String?
	public var formattedAddress: [FormattedAddress]?
	public var labeledLatLngs: [LabeledLatLngs]?
	public var cc: String?
	public var postalCode: String?
	public var lat: Float?
	public var crossStreet: String?
	public var state: String?


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
		city = json[kLocationCityKey].string
		lng = json[kLocationLngKey].float
		distance = json[kLocationDistanceKey].int
		address = json[kLocationAddressKey].string
		country = json[kLocationCountryKey].string
		formattedAddress = []
		if let items = json[kLocationFormattedAddressKey].array {
			for item in items {
				formattedAddress?.append(FormattedAddress(json: item))
			}
		} else {
			formattedAddress = nil
		}
		labeledLatLngs = []
		if let items = json[kLocationLabeledLatLngsKey].array {
			for item in items {
				labeledLatLngs?.append(LabeledLatLngs(json: item))
			}
		} else {
			labeledLatLngs = nil
		}
		cc = json[kLocationCcKey].string
		postalCode = json[kLocationPostalCodeKey].string
		lat = json[kLocationLatKey].float
		crossStreet = json[kLocationCrossStreetKey].string
		state = json[kLocationStateKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if city != nil {
			dictionary.updateValue(city!, forKey: kLocationCityKey)
		}
		if lng != nil {
			dictionary.updateValue(lng!, forKey: kLocationLngKey)
		}
		if distance != nil {
			dictionary.updateValue(distance!, forKey: kLocationDistanceKey)
		}
		if address != nil {
			dictionary.updateValue(address!, forKey: kLocationAddressKey)
		}
		if country != nil {
			dictionary.updateValue(country!, forKey: kLocationCountryKey)
		}
		if formattedAddress?.count > 0 {
			var temp: [AnyObject] = []
			for item in formattedAddress! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kLocationFormattedAddressKey)
		}
		if labeledLatLngs?.count > 0 {
			var temp: [AnyObject] = []
			for item in labeledLatLngs! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kLocationLabeledLatLngsKey)
		}
		if cc != nil {
			dictionary.updateValue(cc!, forKey: kLocationCcKey)
		}
		if postalCode != nil {
			dictionary.updateValue(postalCode!, forKey: kLocationPostalCodeKey)
		}
		if lat != nil {
			dictionary.updateValue(lat!, forKey: kLocationLatKey)
		}
		if crossStreet != nil {
			dictionary.updateValue(crossStreet!, forKey: kLocationCrossStreetKey)
		}
		if state != nil {
			dictionary.updateValue(state!, forKey: kLocationStateKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.city = aDecoder.decodeObjectForKey(kLocationCityKey) as? String
		self.lng = aDecoder.decodeObjectForKey(kLocationLngKey) as? Float
		self.distance = aDecoder.decodeObjectForKey(kLocationDistanceKey) as? Int
		self.address = aDecoder.decodeObjectForKey(kLocationAddressKey) as? String
		self.country = aDecoder.decodeObjectForKey(kLocationCountryKey) as? String
		self.formattedAddress = aDecoder.decodeObjectForKey(kLocationFormattedAddressKey) as? [FormattedAddress]
		self.labeledLatLngs = aDecoder.decodeObjectForKey(kLocationLabeledLatLngsKey) as? [LabeledLatLngs]
		self.cc = aDecoder.decodeObjectForKey(kLocationCcKey) as? String
		self.postalCode = aDecoder.decodeObjectForKey(kLocationPostalCodeKey) as? String
		self.lat = aDecoder.decodeObjectForKey(kLocationLatKey) as? Float
		self.crossStreet = aDecoder.decodeObjectForKey(kLocationCrossStreetKey) as? String
		self.state = aDecoder.decodeObjectForKey(kLocationStateKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(city, forKey: kLocationCityKey)
		aCoder.encodeObject(lng, forKey: kLocationLngKey)
		aCoder.encodeObject(distance, forKey: kLocationDistanceKey)
		aCoder.encodeObject(address, forKey: kLocationAddressKey)
		aCoder.encodeObject(country, forKey: kLocationCountryKey)
		aCoder.encodeObject(formattedAddress, forKey: kLocationFormattedAddressKey)
		aCoder.encodeObject(labeledLatLngs, forKey: kLocationLabeledLatLngsKey)
		aCoder.encodeObject(cc, forKey: kLocationCcKey)
		aCoder.encodeObject(postalCode, forKey: kLocationPostalCodeKey)
		aCoder.encodeObject(lat, forKey: kLocationLatKey)
		aCoder.encodeObject(crossStreet, forKey: kLocationCrossStreetKey)
		aCoder.encodeObject(state, forKey: kLocationStateKey)

    }

}
