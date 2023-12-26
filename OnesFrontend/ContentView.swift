//
//  ContentView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }

            CapsuleItemFormView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Setting")
                }
        }
    }
}

#Preview {
    ContentView()
}
