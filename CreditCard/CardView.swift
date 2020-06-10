//
//  CardView.swift
//  CreditCard
//
//  Created by Berkant Beğdilili on 9.06.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import SwiftUI

struct CardView: View {

    @Binding var cardNumber:String
    @Binding var validMonth:String
    @Binding var validYear:String
    @Binding var fullName:String
    @Binding var cvvCode:String
    @Binding var isBack:Bool
    @Binding var degreesAmount:Double
    @Binding var is6Number:Bool
    @Binding var scheme:String
    
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading){
                if isBack{
                    
                    Color.black.frame(height: 35)
                    
                    Spacer()
                    
                    ZStack(alignment: .leading){
                        Color.black
                        
                        Text(cvvCode)
                            .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                    }.frame(width:200,height: 25)
                    .padding(.leading, 100)
                    .padding(.bottom, 100)
                    
                }else{
                    
                    Image("apple2")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width:50 , height: 50)
                        .padding(.leading, 275)
                        .padding(.top, 65)
                    
                    Image("cip")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width:70 , height: 70)
                        
                    Spacer()
                    
                    Text(cardNumber)
                        .foregroundColor(.black)
                        .font(.title)
                        .bold()
                        
                    
                    Text("\(validMonth)/\(validYear)")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.leading, 170)
                    
                    HStack{
                        Text(fullName)
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.leading, 50)
                                .padding(.bottom, 75)
                        Spacer()
                        
                        if is6Number {
                            Image(scheme)
                                .resizable()
                                .frame(width: 85 , height: 85)
                                .offset(y:-50)
                                
                        }
                    }
                    
                    
                        
                }
                
            }.padding(.all)
        }
        .frame(height: 250)
        .background( self.is6Number && !self.scheme.isEmpty ?
                                LinearGradient(gradient: Gradient(colors: [
                                             Color(hex:"#"),
                                             Color(hex:"#93A5CF")]),
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing)
                                :
                                LinearGradient(gradient: Gradient(colors: [
                                Color(hex:"#"),
                                Color(hex:"#FF9A9E")]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
        .clipShape(Rectangle())
        .cornerRadius(15)
        .shadow(color: .black, radius:30, x: 25, y: 25)
        .rotation3DEffect(.degrees(degreesAmount), axis: (x:0, y:1 , z:0))
        .onTapGesture {
            withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)){
                self.isBack.toggle()
                self.degreesAmount -= 180
            }
        }.padding()
        
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
