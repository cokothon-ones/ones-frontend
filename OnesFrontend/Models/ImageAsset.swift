//
//  ImageAsset.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import Foundation
import PhotosUI

struct ImageAsset: Identifiable {
    var id: String = UUID().uuidString
    var asset: PHAsset
    var thumbnail: UIImage?

    // MARK: Selected Image Index

    var assetIndex: Int = -1
}
