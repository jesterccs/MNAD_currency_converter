//
//  SettingsView.swift
//  MNADStarter
//
//  Created by Visal Rajapakse on 2023-06-30.
//

import SwiftUI

enum Currencies: String, CaseIterable, Identifiable {
    case usd = "USD"
    case gbp = "GBP"
    case aud = "AUD"
    case cad = "CAD"
    case eur = "EUR"
    var id: Self { self }
}


struct SettingsView: View {

//    @EnvironmentObject var prospect: Prospect
    @Binding var defaulPickerValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text("Currency").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Picker("", selection: $defaulPickerValue) {
                ForEach(Currencies.allCases) { currency in
                    Text(currency.rawValue).tag(currency.rawValue)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    defaulPickerValue = "USD"
                },label: {
                    Text("Reset Settings").foregroundColor(.red)
                        .frame(width: UIScreen.screenWidth*0.4, height: UIScreen.screenHeight*0.05)
                }).tint(.red).buttonStyle(.bordered).cornerRadius(10)
                Spacer()
            }
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(defaulPickerValue: .constant("USD"))/*.environmentObject(Prospect())*/
    }
}
