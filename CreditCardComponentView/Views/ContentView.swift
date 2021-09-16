//
//  ContentView.swift
//  CreditCardComponentView
//
//  Created by Yago de Martin Lopez on 29/7/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    
    @State private var date = Date()
    
    @State private var degrees: Double = 0
    @State private var flipped:Bool = false
    
    @State private var name: String = ""
    @State private var expires: String = ""
    @State private var model: CardModel = CardModel(number: "", name: "", expiryDate: "" ,cvv: "")
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    let creditCardLimit = 16 //Credit card limit

    var body: some View {
        
        VStack {
            CreditCard {
                
                
                VStack {
                    Group{
                        if flipped {
                            CreditCardBack(cvv:self.model.cvv)
                        } else {
                            CreditCardFront(model: self.model)
                        }
                    }
                }.rotation3DEffect(
                    .degrees(degrees),
                    axis: (x: 0.0, y: 1.0, z: 0.0))
            }.onTapGesture {
                withAnimation{
                    degrees += 180
                    flipped.toggle()
                }
            }
            
       
            
            TextField("Name" , text: $model.name).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.top,.leading,.trailing])
            
 
            TextField("Credit Card" , text: $model.number).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.leading,.trailing]).onReceive(Just(model.number)) { _ in
                model.number = limitText(textFieldValue: model.number, upper: creditCardLimit)}
            
            TextField("Expiration" , text: $model.expiryDate).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.leading,.trailing])
            
            DatePicker("Fecha", selection: $date, displayedComponents:.date)
                .datePickerStyle(CompactDatePickerStyle())
                            
            
            TextField("CVV" , text: $model.cvv){ (editingChanged)
                in
               
                        withAnimation{
                            degrees += 180
                            flipped.toggle()
                        }   
                
            }onCommit: {}
            .textFieldStyle(RoundedBorderTextFieldStyle()).padding([.leading,.trailing])
            
            
        }
    }
    
    //Function to keep text length in limits
    func limitText(textFieldValue: String, upper: Int) -> String {
        var returnValue = ""
          if textFieldValue.count > upper {
            returnValue = String(textFieldValue.prefix(upper))
            return returnValue
          }
        
        return textFieldValue
      }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
