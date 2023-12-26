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
    @State var target: String = ""

    @State var addresses: [NaverLocalSearchResponseDTO.Item] = []
    @State var showSheet: Bool = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            UIMapView()
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TextField(text: $target) {
                        Text("주소를 입력해주세요.")
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .scaleEffect(1.5)
                        .padding()
                        .onTapGesture {
                            requestGeo()
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
                print(item)
            })
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        })
    }

    func requestGeo() {
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
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 13

        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.611035490773, lng: 126.99457310622)
        marker.mapView = view.mapView
        marker.iconImage = NMFOverlayImage(name: "orem")
        marker.iconTintColor = UIColor.red
        marker.width = 25
        marker.height = 40

        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

#Preview {
    MapView()
}
