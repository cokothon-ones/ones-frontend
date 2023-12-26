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
                            searchLocation()
                        }
                }
                .padding(.leading, 10)
                .background {
                    Color(.white)
                }
                .frame(height: 50)
                .cornerRadius(15)
            }
            .padding(20)
        }
        .sheet(isPresented: $showSheet, content: {
            Overlay(showSheet: $showSheet, addresses: $addresses, completion: { item in
                getLatLng(target: item.roadAddress)
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

    func getLatLng(target: String) {
        let headers: HTTPHeaders = [
            "X-NCP-APIGW-API-KEY-ID": "a4zoszni76",
            "X-NCP-APIGW-API-KEY": "GGtlCdUvKFhTI9iBiMrrj9x0Tb8VLCbpjw04dl0d"
        ]

        AF.request(
            "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(target)",
            method: .get,
            headers: headers
        ).responseDecodable(of: NaverGeoCodeResponseDTO.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(response):
                if let item = response.addresses.first,
                   let x = Double(item.x),
                   let y = Double(item.y)
                {
                    coord = (x, y)
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func searchLocation() {
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "j2WnsPrVKWUAnOqiJUZw",
            "X-Naver-Client-Secret": "BdqfsZo2Qj"
        ]

        AF.request(
            "https://openapi.naver.com/v1/search/local.json?query=\(target)&display=10&start=1&sort=random",
            method: .get,
            headers: headers
        ).responseDecodable(of: NaverLocalSearchResponseDTO.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(response):
                // 국민대학교
                // 숙명여대
                // 솔샘로 44
                self.addresses = response.items
                showSheet = true
            case let .failure(error):
                print(error)
            }
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
