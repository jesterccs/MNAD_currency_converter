//
//  CustomTabView.swift
//  MNADStarter
//
//  Created by Visal Rajapakse on 2023-06-30.
//

import SwiftUI

//@MainActor class Prospect: ObservableObject {
//    @Published var selectedCurrency: Currencies
//    
//    init() {
//        selectedCurrency = .usd
//    }
//}

struct CustomTabView: View {
    
//    @StateObject var prospect = Prospect()
    
    @AppStorage("deafultPickerValue")  var  pickerValue :String = "USD"
    
    var body: some View {
        TabView{
            HomeView(defaulPickerValue: $pickerValue).tabItem {
                Label("Home", systemImage: "house")
            }
            
            SettingsView(defaulPickerValue: $pickerValue).tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }/*.environmentObject(prospect)*/
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
