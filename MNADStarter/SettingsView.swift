//
//  SettingsView.swift
//  MNADStarter
//
//  Created by Visal Rajapakse on 2023-06-30.
//

import SwiftUI

enum Currencies: String, CaseIterable {
    case usd = "USD"
    case gbp = "GBP"
    case aud = "AUD"
    case cad = "CAD"
    case eur = "EUR"
}


struct SettingsView: View {
    
//    @State private var selectedCurrency: Currencies = .usd
    @EnvironmentObject var prospect: Prospect
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text("Currency").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Picker("", selection: $prospect.selectedCurrency) {
                ForEach(Currencies.allCases, id: \.self) { key in
                    Text(key.rawValue)/*.tag(key.rawValue)*/
                }
            }.pickerStyle(.wheel)
                .onChange (of: prospect.selectedCurrency)  { newValue in
                    prospect.selectedCurrency = newValue
                }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    prospect.selectedCurrency = .usd
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
        SettingsView().environmentObject(Prospect())
    }
}
