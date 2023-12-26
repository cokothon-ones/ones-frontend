//
//  ContentView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import NMapsMap
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

            Text("Setting")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Setting")
                }
        }
    }
}

struct MapView: View {
    var body: some View {
        ZStack {
            UIMapView()
        }
    }
}

struct UIMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17

        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

#Preview {
    ContentView()
}
