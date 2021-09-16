//
//  CardModel.swift
//  CreditCardComponentView
//
//  Created by Yago de Martin Lopez on 12/8/21.
//

import Foundation
import SwiftUI

public struct CardModel {
    
    let validator = CreditCardValidator()
    
    public var number: String {
        didSet {
            
            
            if (number.count >= 7 || number.count < 4) {
                guard let typeFinded = validator.type(from: "\(number as String?)") else {
                    self.type = nil
                    return
                }
                
               self.type = typeFinded
                
            }
        }
    }
    
    public var name: String
    public var type: CreditCardValidationType?
    
    public var expiryDate: String
    public var cvv: String
    
    public var isAmex: Bool?
    
    public  var brandColors : [String : Any] = [Brands.DEFAULT.rawValue: [ Color(hex: "363434"), Color(hex: "363434")] , Brands.Visa.rawValue: [ Color(hex: "5D8BF2"), Color(hex: "3545AE")], Brands.MasterCard.rawValue: [ Color(hex: "ED495A"), Color(hex: "8B1A2B")],  Brands.UnionPay.rawValue: [ Color(hex: "987c00"), Color(hex: "826a01")], Brands.Amex.rawValue: [ Color(hex: "005B9D"), Color(hex: "132972")] ,Brands.JCB.rawValue: [ Color(hex: "265797"), Color(hex: "3d6eaa")], "Diners Club": [ Color(hex: "5b99d8"), Color(hex: "4186CD")],Brands.Discover.rawValue: [ Color(hex: "e8a258"), Color(hex: "D97B16")]
    ]
  
  public  func modifyCreditCardString(creditCardString : String) -> String {
         let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

         let arrOfCharacters = Array(trimmedString)
         var modifiedCreditCardString = ""

         if(arrOfCharacters.count > 0) {
             for i in 0...arrOfCharacters.count-1 {
                
                if (i < 16-4) {
                    modifiedCreditCardString.append("X")                } else {
                    modifiedCreditCardString.append(arrOfCharacters[i])                }
                
                
                 if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                     modifiedCreditCardString.append(" ")
                 }
             }
         }
         return modifiedCreditCardString
     }
   /* fileprivate func setBrandColors() {
        colors[Brands.NONE.rawValue] = [defaultCardColor, defaultCardColor]
        colors[Brands.Visa.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        colors[Brands.MasterCard.rawValue] = [UIColor.hexStr(hexStr: "#ED495A", alpha: 1), UIColor.hexStr(hexStr: "#8B1A2B", alpha: 1)]
        colors[Brands.UnionPay.rawValue] = [UIColor.hexStr(hexStr: "#987c00", alpha: 1), UIColor.hexStr(hexStr: "#826a01", alpha: 1)]
        colors[Brands.Amex.rawValue] = [UIColor.hexStr(hexStr: "#005B9D", alpha: 1), UIColor.hexStr(hexStr: "#132972", alpha: 1)]
        colors[Brands.JCB.rawValue] = [UIColor.hexStr(hexStr: "#265797", alpha: 1), UIColor.hexStr(hexStr: "#3d6eaa", alpha: 1)]
        colors["Diners Club"] = [UIColor.hexStr(hexStr: "#5b99d8", alpha: 1), UIColor.hexStr(hexStr: "#4186CD", alpha: 1)]
        colors[Brands.Discover.rawValue] = [UIColor.hexStr(hexStr: "#e8a258", alpha: 1), UIColor.hexStr(hexStr: "#D97B16", alpha: 1)]
        colors[Brands.DEFAULT.rawValue] = [UIColor.hexStr(hexStr: "#5D8BF2", alpha: 1), UIColor.hexStr(hexStr: "#3545AE", alpha: 1)]
        
        if cardGradientColors.count > 0 {
            for (_, value) in cardGradientColors.enumerated() {
                colors[value.key] = value.value
            }
        }
    }*/
}


