//
//  ImagePickerViewModel.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import Foundation
import PhotosUI

final class ImagePickerViewModel: ObservableObject {
    // MARK: Properties

    @Published var fetchedImages: [ImageAsset] = []
    @Published var selectedImages: [ImageAsset] = []

    init() {
        fetchImages()
    }

    // MARK: Fetching Images

    func fetchImages() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        PHAsset.fetchAssets(with: .image, options: options).enumerateObjects { asset, _, _ in
            if self.fetchedImages.count > 200 {
                return
            }

            let imageAsset: ImageAsset = .init(asset: asset)
            self.fetchedImages.append(imageAsset)
        }
    }
}
