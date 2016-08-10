//
//  LabeledLatLngs.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class LabeledLatLngs: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kLabeledLatLngsLabelKey: String = "label"
	internal let kLabeledLatLngsLatKey: String = "lat"
	internal let kLabeledLatLngsLngKey: String = "lng"


    // MARK: Properties
	public var label: String?
	public var lat: Float?
	public var lng: Float?


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
		label = json[kLabeledLatLngsLabelKey].string
		lat = json[kLabeledLatLngsLatKey].float
		lng = json[kLabeledLatLngsLngKey].float

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if label != nil {
			dictionary.updateValue(label!, forKey: kLabeledLatLngsLabelKey)
		}
		if lat != nil {
			dictionary.updateValue(lat!, forKey: kLabeledLatLngsLatKey)
		}
		if lng != nil {
			dictionary.updateValue(lng!, forKey: kLabeledLatLngsLngKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.label = aDecoder.decodeObjectForKey(kLabeledLatLngsLabelKey) as? String
		self.lat = aDecoder.decodeObjectForKey(kLabeledLatLngsLatKey) as? Float
		self.lng = aDecoder.decodeObjectForKey(kLabeledLatLngsLngKey) as? Float

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(label, forKey: kLabeledLatLngsLabelKey)
		aCoder.encodeObject(lat, forKey: kLabeledLatLngsLatKey)
		aCoder.encodeObject(lng, forKey: kLabeledLatLngsLngKey)

    }

}
