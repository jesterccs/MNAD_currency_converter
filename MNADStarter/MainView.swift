//
//  MainView.swift
//  MNADStarter
//
//  Created by Chamika Sakalasuriya on 2023-10-19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView().tabItem { Text("Home") }
            SettingsView().tabItem { Text("Settings") }
        }
    }
}

#Preview {
    MainView()
}
