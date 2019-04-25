//
//	Paymentinfo.swift
//
//	Create by Tristate on 22/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PaymentInfo : NSObject{

    //MARK:- Variables
	var addressline1 : String = ""
	var addressline2 : String = ""
	var city : String = ""
	var displayname : String = ""
	var dob : String = ""
	var email : String = ""
	var fullname : String = ""
	var phone : String = ""
	var state : String = ""
	var zipcode : String = ""


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressline1 = dictionary["addressline1"] as? String ?? ""
		addressline2 = dictionary["addressline2"] as? String ?? ""
		city = dictionary["city"] as? String ?? ""
		displayname = dictionary["displayname"] as? String ?? ""
		dob = dictionary["dob"] as? String ?? ""
		email = dictionary["email"] as? String ?? ""
		fullname = dictionary["fullname"] as? String ?? ""
		phone = dictionary["phone"] as? String ?? ""
		state = dictionary["state"] as? String ?? ""
		zipcode = dictionary["zipcode"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		dictionary["addressline1"] = addressline1
        dictionary["addressline2"] = addressline2
		dictionary["city"] = city
        dictionary["displayname"] = displayname
        dictionary["dob"] = dob
        dictionary["email"] = email
		dictionary["fullname"] = fullname
        dictionary["phone"] = phone
		dictionary["state"] = state
		dictionary["zipcode"] = zipcode
		
		return dictionary
	}

 

    

}
