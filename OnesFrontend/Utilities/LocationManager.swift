//
//  LocationManager.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Alamofire
import Combine
import CoreLocation
import Foundation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
}

func getLatLng(target: String, completion: @escaping (Double, Double) -> Void) {
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
                completion(x, y)
            }
        case let .failure(error):
            print(error)
        }
    }
}

func searchLocation(target: String, completion: @escaping ([NaverLocalSearchResponseDTO.Item]) -> Void) {
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
            completion(response.items)
        case let .failure(error):
            print(error)
        }
    }
}
