//
//  MapView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Alamofire
import NMapsMap
import SwiftUI

struct Overlay: View {
    @Binding var showSheet: Bool
    @Binding var addresses: [NaverLocalSearchResponseDTO.Item]
    var completion: (NaverLocalSearchResponseDTO.Item) -> Void

    var body: some View {
        List($addresses) { $address in
            Text(address.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: ""))
                .onTapGesture {
                    showSheet = false
                    completion(address)
                }
        }
    }
}

struct MapView: View {
    @State var coord: (Double, Double) = (0, 0)

    @State var target: String = ""

    @State var addresses: [NaverLocalSearchResponseDTO.Item] = []
    @State var showSheet: Bool = false

    @StateObject var locationManager = LocationManager()

    init() {
        coord = (
            locationManager.lastLocation?.coordinate.longitude ?? 0,
            locationManager.lastLocation?.coordinate.latitude ?? 0
        )
    }

    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }

    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            UIMapView(coord: coord)
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    let coord = NMGLatLng(lat: userLatitude, lng: userLongitude)
                    let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
                    cameraUpdate.animationDuration = 1
                    Global.default.mapView.mapView.moveCamera(cameraUpdate)
                }

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TextField(text: $target) {
                        Text("장소를 입력해주세요.")
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .scaleEffect(1.5)
                        .padding()
                        .onTapGesture {
                            print("tap")
                            searchLocation(target: target) { result in
                                self.addresses = result
                                showSheet = true
                            }
                        }
                }
                .padding(.leading, 10)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.82),
                                lineWidth: 1)
                )
                .frame(height: 50)
            }
            .padding(20)
        }
        .sheet(isPresented: $showSheet, content: {
            Overlay(showSheet: $showSheet, addresses: $addresses, completion: { item in
                getLatLng(target: item.roadAddress) { x, y in
                    coord = (x, y)
                }
            })
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        })
        .onChange(of: locationManager.lastLocation) { _, _ in
            coord = (
                locationManager.lastLocation?.coordinate.longitude ?? 0,
                locationManager.lastLocation?.coordinate.latitude ?? 0
            )
        }
    }
}

struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 13
        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        Global.default.mapView = uiView
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)

        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: self.coord.1, lng: self.coord.0)
        marker.mapView = uiView.mapView
    }
}

#Preview {
    MapView()
}
