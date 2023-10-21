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
    
//    @EnvironmentObject var prospect: Prospect
    
    @State private var textFieldValue1 = "" // SAMPLE
    @State private var textFieldValue2 = ""
    @State private var selectedCurrency: String = "USD"
    @State private var toggle = false
    @State private var convertedLKRValue: String = ""
    @State private var convertedForeignValue: String = ""
    @Binding var defaulPickerValue: String
    
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
                    if toggle == false {
                        convert(newValue: newValue)
                    }
                    
                }.border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                // Picker
                Picker("", selection: $selectedCurrency) {
                    ForEach(Currencies.allCases, id: \.self) { currency in
                        Text(currency.rawValue.uppercased()).tag(currency.rawValue)
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
                    if toggle == true {
                        reverseConvert(newValue: newValue)
                    }
                   
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
            .onAppear{
                selectedCurrency = defaulPickerValue
            }
    }
    
    
    
    
    
    
    // MARK: USE THESE FUNCTIONS WITHIN A SWIFTUI `onChange()` VIEW MODIFIER
    private func convert(newValue: String) {
        guard let newValue = Double(newValue), let rate  = rates[selectedCurrency] else {
            return
        }
        
        let convertedValue = newValue * rate
        textFieldValue2 = String(convertedValue)
        
    }
    
    private func reverseConvert(newValue: String) {
        guard let newValue = Double(newValue), let rate =
                rates[selectedCurrency] else {
            return
        }
        
        let convertedValue = newValue / rate
        textFieldValue1 = String(convertedValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(defaulPickerValue: .constant("USD"))/*.environmentObject(Prospect())*/
    }  
}
