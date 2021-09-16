//
//  CreditCard.swift
//  CreditCardComponentView
//
//  Created by Yago de Martin Lopez on 9/8/21.
//

import SwiftUI

let defaultPrimaryBackgroundColor = Color(hex: "363434")
let defaultSecundaryBackgroundColor = Color.black




struct CreditCard <Content>: View where Content: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
        }

}

struct CreditCardFront: View {
    
    let model: CardModel
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                Image("chip").resizable().frame(width: 45, height: 30, alignment: .center)
              //  Image(systemName: "checkmark.circle.fill").foregroundColor(.white)
                Spacer()
                
                if (self.model.type != nil) {
                    Image(self.model.type!.name).resizable().frame(width: 45, height: 45, alignment: .center).border(Color.white, width: 2)
                }
               
                //Text("VISA")
                  //  .foregroundColor(.white).font(.system(size: 24)).fontWeight(.bold)
                
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            Spacer()
            
            Text(model.modifyCreditCardString(creditCardString: model.number)).foregroundColor(.white).font(.system(size: 27))
            Spacer()
            
            HStack{
                VStack (alignment: .leading){
                    Text("CARD HOLDER").font(.caption).fontWeight(.bold).foregroundColor(.gray)
                    
                    Text(model.name).font(.caption).fontWeight(.bold).foregroundColor(.white)
                }
                Spacer()
                
                VStack (alignment: .leading){
                    Text("EXPIRES").font(.caption).fontWeight(.bold).foregroundColor(.gray)
                    
                    Text(model.expiryDate).font(.caption).fontWeight(.bold).foregroundColor(.white)
                }
            }
            
        }.frame(width: 300, height: 200, alignment: .center)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: getColors()), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(10)
    }
    
    func getColors() -> [Color] {

        guard let brandType = self.model.type else {
            return [defaultPrimaryBackgroundColor, defaultSecundaryBackgroundColor]
        }
        
        if let selectedColors =  self.model.brandColors[brandType.name]  {
            
            return selectedColors as! [Color]
        }
        
        return [defaultPrimaryBackgroundColor, defaultSecundaryBackgroundColor]
    }
}

struct CreditCardBack: View {
    let cvv: String
    var body: some View {
        VStack {
            Rectangle().frame( maxWidth: .infinity,  maxHeight: 20).padding([.top])
            Spacer()
            
            HStack{
                Text(cvv).foregroundColor(.black).rotation3DEffect(
                    .degrees(180),axis: (x: 0.0, y: 1.0, z: 0.0)).padding(5).frame(width: 100, height: 20, alignment: .center).background(Color(.white))
                Spacer()
            }.padding()
            
        }.frame(width: 300, height: 200, alignment: .center).background(LinearGradient(gradient: Gradient(colors: [defaultSecundaryBackgroundColor, defaultPrimaryBackgroundColor]), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(10)
    }
}


struct CreditCard_Previews: PreviewProvider {
    static var previews: some View {
        CreditCard<CreditCardFront>(content:{ CreditCardFront(model: CardModel(number: "4223232323232", name: "Yago de Martin", expiryDate: "02/02", cvv: "122")			            )})
    }
}

extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}


public enum Brands : String {
    case NONE, Visa, UnionPay, MasterCard, Amex, JCB, DEFAULT, Discover
}
