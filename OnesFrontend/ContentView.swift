//
//  ContentView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        return manager
    }()

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
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    ContentView()
}
