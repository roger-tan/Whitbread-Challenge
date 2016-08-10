//
//  Meta.swift
//
//  Created by Roger TAN on 8/10/16
//  Copyright (c) Roger TAN. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Meta: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMetaCodeKey: String = "code"
	internal let kMetaRequestIdKey: String = "requestId"
	internal let kMetaErrorTypeKey: String = "errorType"
	internal let kMetaErrorDetailKey: String = "errorDetail"


    // MARK: Properties
	public var code: Int?
	public var requestId: String?
	public var errorType: String?
	public var errorDetail: String?


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
		code = json[kMetaCodeKey].int
		requestId = json[kMetaRequestIdKey].string
		errorType = json[kMetaErrorTypeKey].string
		errorDetail = json[kMetaErrorDetailKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kMetaCodeKey)
		}
		if requestId != nil {
			dictionary.updateValue(requestId!, forKey: kMetaRequestIdKey)
		}
		if errorType != nil {
			dictionary.updateValue(errorType!, forKey: kMetaErrorTypeKey)
		}
		if errorDetail != nil {
			dictionary.updateValue(errorDetail!, forKey: kMetaErrorDetailKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.code = aDecoder.decodeObjectForKey(kMetaCodeKey) as? Int
		self.requestId = aDecoder.decodeObjectForKey(kMetaRequestIdKey) as? String
		self.errorType = aDecoder.decodeObjectForKey(kMetaErrorTypeKey) as? String
		self.errorDetail = aDecoder.decodeObjectForKey(kMetaErrorDetailKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(code, forKey: kMetaCodeKey)
		aCoder.encodeObject(requestId, forKey: kMetaRequestIdKey)
		aCoder.encodeObject(errorType, forKey: kMetaErrorTypeKey)
		aCoder.encodeObject(errorDetail, forKey: kMetaErrorDetailKey)

    }

}
