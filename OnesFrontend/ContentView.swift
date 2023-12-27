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

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // <- HERE
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.7, green: 0.69, blue: 0.68, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.7, green: 0.69, blue: 0.68, alpha: 1)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 0.17, green: 0.12, blue: 0.22, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.17, green: 0.12, blue: 0.22, alpha: 1)]

        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
    }

    @State var selection: Int = 2

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                MainView(global: Global.default)
                    .tabItem {
                        Image("home")
                            .renderingMode(.template)
                        Text("홈")
                            .font(
                                .system(size: 12, weight: .medium)
                            )
                    }
                    .tag(0)

                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("지도")
                            .font(
                                .system(size: 12, weight: .medium)
                            )
                    }
                    .tag(1)

                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("설정")
                            .font(
                                .system(size: 12, weight: .medium)
                            )
                    }
                    .tag(2)
            }
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
}

#Preview {
    ContentView()
}
