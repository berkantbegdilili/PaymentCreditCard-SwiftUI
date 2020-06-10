//
//  NetworkResponseModel.swift
//  CreditCard
//
//  Created by Berkant Beğdilili on 9.06.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation

struct CardNetworkResponseModel : Codable {
    let number:Number?
    let scheme:String?
    let type:String?
    let brand:String?
    let prepaid:Bool?
    let country:Country?
    let bank:Bank?
}


struct Number : Codable{
    let length:Int?
    let luhn:Bool?
}

struct Country : Codable{
    let numeric:String?
    let alpha2:String?
    let name:String?
    let emoji:String?
    let currency:String?
    let latitude:Int?
    let longitude:Int?
}

struct Bank : Codable{
    let name:String?
    let url:String?
    let phone:String?
    let city:String?
}
