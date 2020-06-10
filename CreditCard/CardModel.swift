//
//  CardModel.swift
//  CreditCard
//
//  Created by Berkant Beğdilili on 9.06.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine

final class CardModel: ObservableObject {
    
    @Published var isBack:Bool = false{
        willSet{
            objectWillChange.send()
        }
    }
    
    @Published var is6Number:Bool = false{
        willSet{
            objectWillChange.send()
        }
    }
    
    @Published var degreesAmount:Double = 0
    
    @Published var fullName:String = ""
    
    @Published var scheme:String = ""{
        willSet{
            objectWillChange.send()
        }
    }
    
    
    
    let validMonthLimit:Int = 2
    
    @Published var validMonth:String = "" {
        didSet{
            if validMonth.count > validMonthLimit && oldValue.count <= validMonthLimit {
                validMonth = oldValue
            }
        }
    }
    
    let validYearLimit:Int = 4
    
    @Published var validYear:String = "" {
        didSet{
            if validYear.count > validYearLimit && oldValue.count <= validYearLimit {
                validYear = oldValue
            }
        }
    }
    
    let cardNumberLimit:Int = 19
    
    @Published var cardNumber:String = "" {
        didSet{
            if cardNumber.count > cardNumberLimit && oldValue.count <= cardNumberLimit {
                cardNumber = oldValue
            }
            
            if cardNumber.count == 8 {
                let cardNo = cardNumber.replacingOccurrences(of: " ", with: "")
                
                DispatchQueue.main.async {
                    
                    AF.request("https://lookup.binlist.net/\(cardNo)",
                               method: .post).responseJSON { response in
                                
                                if let data = response.data {
                                    
                                    do {
                                        let jsonParse = try JSONDecoder().decode(CardNetworkResponseModel.self, from: data)
                                        
                                        self.scheme = jsonParse.scheme!.replacingOccurrences(of: " ", with: "")
                                        
                                    } catch  {
                                        print(error.localizedDescription)
                                    }
                                    
                                }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    self.is6Number = true
                }
            }else if cardNumber.count < 8{
                is6Number = false
            }
        }
    }
    
    let cvvCodeLimit:Int = 3
    
    @Published var cvvCode:String = ""{
        didSet{
            if cvvCode.count > cvvCodeLimit && oldValue.count <= cvvCodeLimit {
                cvvCode = oldValue
            }
        }
    }
 

}


