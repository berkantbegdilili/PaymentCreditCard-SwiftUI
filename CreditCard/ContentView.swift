//
//  ContentView.swift
//  CreditCard
//
//  Created by Berkant Beğdilili on 9.06.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cardData = CardModel()
    @ObservedObject private var keyboard = KeyboardResponder()

    var body: some View {
        VStack(spacing: 75){
            
            CardView(cardNumber: self.$cardData.cardNumber,
                     validMonth: self.$cardData.validMonth,
                     validYear: self.$cardData.validYear,
                     fullName: self.$cardData.fullName,
                     cvvCode: self.$cardData.cvvCode,
                     isBack: self.$cardData.isBack,
                     degreesAmount: self.$cardData.degreesAmount,
                     is6Number: self.$cardData.is6Number,
                     scheme: self.$cardData.scheme)
            
        
            Form{
                
                Section(header: Text("CARD NUMBER")){
                
                    BBTextField(text: self.$cardData.cardNumber,
                                characterLimit: self.cardData.cardNumberLimit,
                                keyboardType: .numberPad,
                                placeHolder: "XXXX XXXX XXXX XXXX",
                                isCardNumber: true)
                        .padding()
                    
                }.onTapGesture {
                    if self.cardData.isBack {
                        withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)){
                            self.cardData.isBack.toggle()
                            self.cardData.degreesAmount -= 180
                        }
                    }
                }
                
                Section(header: Text("VALID THRU")){
                    
                    HStack{
                        
                        Spacer()
                        
                        BBTextField(text: self.$cardData.validMonth,
                                    characterLimit: self.cardData.validMonthLimit,
                                    keyboardType: .numberPad,
                                    placeHolder: "XX",
                                    isCardNumber: false)
                            .padding()
                        
                        BBTextField(text: self.$cardData.validYear,
                                    characterLimit: self.cardData.validYearLimit,
                                    keyboardType: .numberPad,
                                    placeHolder: "XXXX",
                                    isCardNumber: false)
                            .padding()
                            
            
                    }
                    
                }.onTapGesture {
                    if self.cardData.isBack {
                        withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)){
                            self.cardData.isBack.toggle()
                            self.cardData.degreesAmount -= 180
                        }
                    }
                }
                
                Section(header: Text("FULL NAME")){
                    
                    BBTextField(text: self.$cardData.fullName,
                                characterLimit: nil,
                                keyboardType: .default,
                                placeHolder: "",
                                isCardNumber: false)
                        .padding()
                        
                }.onTapGesture {
                    if self.cardData.isBack {
                        withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)){
                            self.cardData.isBack.toggle()
                            self.cardData.degreesAmount -= 180
                        }
                    }
                }
                
                Section(header: Text("CVV CODE")){
                    
                    BBTextField(text: self.$cardData.cvvCode,
                                characterLimit: self.cardData.cvvCodeLimit,
                                keyboardType: .numberPad,
                                placeHolder: "",
                                isCardNumber: false)
                        .padding()
                
                        
                }.onTapGesture {
                    if !self.cardData.isBack {
                        withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)){
                            self.cardData.isBack.toggle()
                            self.cardData.degreesAmount -= 180
                        }
                    }
                }
                
            }
            
        }.padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

