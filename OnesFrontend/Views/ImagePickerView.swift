//
//  PopupImagePicker.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import Foundation
import Photos
import PhotosUI
import SwiftUI

struct ImagePickerView: View {
    @Environment(\.dismiss) var dismissAction
    @StateObject var imagePickerModel: ImagePickerViewModel = .init()

    @Environment(\.self) var env
    @State private var requestPermission: Bool = false

    // MARK: Callbacks

    var onSelect: ([PHAsset]) -> ()

    var body: some View {
        let manager = PHImageManager.default()
        VStack(spacing: 0) {
            HStack {
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        withAnimation {
                            dismissAction()
                        }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }

                    Spacer()

                    Text("앨범")

                    Spacer()

                    Button {
                        withAnimation {
                            let imageAssets = imagePickerModel.selectedImages.compactMap { imageAsset -> PHAsset? in
                                imageAsset.asset
                            }
                            onSelect(imageAssets)
                            dismissAction()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .foregroundColor(Color(0x191919))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 18)
            .contentShape(
                Rectangle()
            )

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 3), count: 3), spacing: 3) {
                    ForEach($imagePickerModel.fetchedImages) { $imageAsset in

                        // MARK: Grid Content

                        GridContent(imageAsset: imageAsset)
                            .onAppear {
                                if imageAsset.thumbnail == nil {
                                    // MARK: Fetching Thumbnail Image

                                    let options = PHImageRequestOptions()
                                    options.isNetworkAccessAllowed = true
                                    manager.requestImage(
                                        for: imageAsset.asset,
                                        targetSize: CGSize(width: 360, height: 360),
                                        contentMode: .aspectFill,
                                        options: options
                                    ) { image, _ in
                                        imageAsset.thumbnail = image
                                    }
                                }
                            }
                            .contentShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .onAppear {
            // 사진 선택 허용이 처음인지 아닌지
            let albumStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch albumStatus {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    if status == .limited {
                        DispatchQueue.main.async {
                            self.imagePickerModel.fetchImages()
                        }
                    } else if status == .authorized {
                        DispatchQueue.main.async {
                            self.imagePickerModel.fetchImages()
                        }
                    } else {
                        DispatchQueue.main.async {
                            dismissAction.callAsFunction()
                        }
                    }
                }
            case .restricted, .denied:
                requestPermission = true
            case .authorized, .limited:
                print("[Debug] 사진 권한 획득")
            @unknown default:
                fatalError()
            }
        }
        .alert("'Haru'이(가) 사용자의 사진에 접근하려고 합니다.", isPresented: $requestPermission) {
            Button("허용") {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            Button("허용 안 함") {
                DispatchQueue.main.async {
                    dismissAction.callAsFunction()
                }
            }
        } message: {
            Text("하루에서 사진을 추가하기 위해 앨범에 접근합니다. 프로필 사진 첨부, 게시글 사진 첨부 기능 사용을 위해 사진 라이브러리 접근권한 동의가 필요합니다. 설정에서 이를 변경할 수 있습니다.")
        }
    }

    // MARK: Grid Image Content

    @ViewBuilder
    func GridContent(imageAsset: ImageAsset) -> some View {
        let size = (UIScreen.main.bounds.size.width - 6) / 3
        let isSelected = imagePickerModel.selectedImages.contains { asset in
            asset.id == imageAsset.id
        }
        ZStack {
            if isSelected {
                Color.black.opacity(0.4)
                    .padding(2)
                    .zIndex(3)
            }

            if let thumbnail = imageAsset.thumbnail {
                Image(uiImage: thumbnail)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .border(
                        width: isSelected ? 3 : 0,
                        edges: [.top, .bottom, .leading, .trailing],
                        color: Color(0x1AFFF)
                    )
            } else {
                ProgressView()
                    .frame(width: size, height: size, alignment: .center)
            }

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.black.opacity(0.1))

                Circle()
                    .fill(.white.opacity(0.25))

                Circle()
                    .stroke(.white, lineWidth: 1)

                if imagePickerModel.selectedImages.firstIndex(where: { asset in
                    asset.id == imageAsset.id
                }) != nil {
                    Circle()
                        .fill(Color(0x1DAFFF))
                }
            }
            .frame(width: 20, height: 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .offset(x: -12, y: 12)
        }
        .clipped()
        .frame(width: size, height: size)
        .onTapGesture {
            // MARK: adding / Removing Asset

            withAnimation(.easeInOut) {
                if let index = imagePickerModel.selectedImages.firstIndex(where: { asset in
                    asset.id == imageAsset.id
                }) {
                    // MARK: Remove And Update Selected Index

                    imagePickerModel.selectedImages.remove(at: index)
                    imagePickerModel.selectedImages.enumerated().forEach { item in
                        imagePickerModel.selectedImages[item.offset].assetIndex = item.offset
                    }
                } else if imagePickerModel.selectedImages.count < 10 {
                    // MARK: Add New

                    var newAsset = imageAsset

                    newAsset.assetIndex = 0
                    imagePickerModel.selectedImages = [newAsset]
                }
            }
        }
    }
}
