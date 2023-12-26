//
//  Constants.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Foundation

struct Constants {
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.iso8601
    static let dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601

    // 서버에서 받기
    static let baseURL = "https://api.23haru.com/v1/"
}
