//
//  ContentView.swift
//  MNADStarter
//
//  Created by Visal Rajapakse on 2023-06-30.
//

import SwiftUI


extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}



struct HomeView: View {
    
    // Dictionary to get the rate agains the LKR for a given currency
    let rates = [
        "USD": 308.81,
        "GBP": 390.31,
        "AUD": 204.40,
        "CAD": 323.82,
        "EUR": 334.92
    ]
    
    @EnvironmentObject var prospect: Prospect
    
    @State private var textFieldValue1 = "" // SAMPLE
    @State private var textFieldValue2 = ""
//    @State private var selectedCurrency: Currencies = .usd
    @State private var toggle = false
    @State private var convertedLKRValue: String = ""
    @State private var convertedForeignValue: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Title
            Text("Currency Converter").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            //
            HStack {
                TextField(text: $textFieldValue1, label: {
                    Text(convertedForeignValue).foregroundColor(Color.black)
                })
                .disabled(toggle)
                .frame(width: UIScreen.screenWidth*0.7)
                .onChange(of: textFieldValue1) { newValue in
                    convert(newValue: newValue)
                }.border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                // Picker
                Picker("", selection: $prospect.selectedCurrency) {
                    ForEach(Currencies.allCases, id: \.self) { key in
                        Text(key.rawValue)/*.tag(key.rawValue)*/
                    }
                }
            }
            
            //
            HStack {
                TextField(text: $textFieldValue2, label: {
                    Text(convertedLKRValue)
                        .foregroundColor(Color.black)
                })
                .foregroundColor(Color.black)
                .disabled(!toggle)
                .onChange(of: textFieldValue2) { newValue in
                    reverseConvert(newValue: newValue)
                }
                .border(.gray, width: 1)
                Text("LKR")
            }
            
            //
            HStack {
                Toggle("Switch calculation", isOn:$toggle)
            }
            
            
            Spacer()
            
            //
            HStack {
                Spacer()
                Button(action: {
                    textFieldValue1 = ""
                    textFieldValue2 = ""
                },label: {
                    Text("Reset Settings").foregroundColor(.red)
                        .frame(width: UIScreen.screenWidth*0.4, height: UIScreen.screenHeight*0.05)
                }).tint(.red).buttonStyle(.bordered).cornerRadius(10)
                Spacer()
            }
        }.padding()
    }
    
    
    
    
    
    
    // MARK: USE THESE FUNCTIONS WITHIN A SWIFTUI `onChange()` VIEW MODIFIER
    private func convert(newValue: String) {
        var value: Double
        if (toggle == false) {
            switch $prospect.selectedCurrency.wrappedValue {
            case Currencies.usd:
                value = (Double(newValue) ?? 0.0)*(rates["USD"] ?? 0.0)
                convertedLKRValue = String(format: "%.2f", value)
            case Currencies.gbp:
                value = (Double(newValue) ?? 0.0)*(rates["GBP"] ?? 0.0)
                convertedLKRValue = String(format: "%.2f", value)
            case Currencies.aud:
                value = (Double(newValue) ?? 0.0)*(rates["AUD"] ?? 0.0)
                convertedLKRValue = String(format: "%.2f", value)
            case Currencies.cad:
                value = (Double(newValue) ?? 0.0)*(rates["CAD"] ?? 0.0)
                convertedLKRValue = String(format: "%.2f", value)
            case Currencies.eur:
                value = (Double(newValue) ?? 0.0)*(rates["EUR"] ?? 0.0)
                convertedLKRValue = String(format: "%.2f", value)
            }
        }
    }
    
    private func reverseConvert(newValue: String) {
        var value: Double
        if (toggle == true){
            switch $prospect.selectedCurrency.wrappedValue {
            case Currencies.usd:
                value = (Double(newValue) ?? 0.0) / (rates["USD"] ?? 0.0)
                convertedForeignValue = String(format: "%.2f", value)
            case .gbp:
                value = (Double(newValue) ?? 0.0) / (rates["GBP"] ?? 0.0)
                convertedForeignValue = String(format: "%.2f", value)
            case .aud:
                value = (Double(newValue) ?? 0.0) / (rates["AUD"] ?? 0.0)
                convertedForeignValue = String(format: "%.2f", value)
            case .cad:
                value = (Double(newValue) ?? 0.0) / (rates["CAD"] ?? 0.0)
                convertedForeignValue = String(format: "%.2f", value)
            case .eur:
                value = (Double(newValue) ?? 0.0) / (rates["EUR"] ?? 0.0)
                convertedForeignValue = String(format: "%.2f", value)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Prospect())
    }  
}
