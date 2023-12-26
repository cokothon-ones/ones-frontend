//
//  CapsuleItemFormView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import Photos

import SwiftUI

struct CapsuleItemFormView: View {
    @State var openPhoto: Bool = false
    @State var openLetter: Bool = false
    @State var image: UIImage? = nil
    @State var isProgress: Bool = false

    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)

    // dummy data
    var imageNames: [String] = [
        "dummyphoto", "dummyphoto2",
        "dummyphoto", "dummyphoto2",
        "dummyphoto", "dummyphoto2",
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("사진")
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { idx in
                                    PhotoComponent(name: imageNames[idx])
                                }

                                Button(action: {
                                    openPhoto = true
                                }, label: {
                                    // for test 나중에 벡엔드와 연동할 때는 모든 데이터 새로 당겨오기
                                    if let image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 150, height: 250)
                                            .cornerRadius(10)
                                            .shadow(radius: 1)
                                            .padding(.vertical, 1)
                                    } else {
                                        Image(systemName: "plus")
                                            .frame(width: 150, height: 250)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .shadow(radius: 1)
                                            .padding(.vertical, 1)
                                    }
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("편지")
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { _ in
                                    LetterComponent()
                                }

                                Button(action: {
                                    openLetter = true
                                }, label: {
                                    Image(systemName: "plus")
                                        .frame(width: 100, height: 100)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .shadow(radius: 1)
                                        .padding(.vertical, 1)
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("장소")
                        Text("성북구 정릉동 국민대학교")
                    }
                }
            }
        }
        .padding(20)
        .fullScreenCover(isPresented: $openPhoto, content: {
            ImagePickerView { assets in
                onSelect(assets: assets)
            }
        })
        .fullScreenCover(isPresented: $openLetter, content: {
            LetterFormView()
        })
    }

    func onSelect(assets: [PHAsset]) {
        // MARK: Do Your Operation With PHAsset

        // I'm Simply Extracting Image
        // .init() Means Exact Size of the Image
        let manager = PHCachingImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true

        options.progressHandler = { progress, _, _, _ in
            if progress == 1.0 {
                isProgress = false
            } else {
                isProgress = true
            }
        }

        DispatchQueue.global(qos: .userInteractive).async {
            assets.forEach { asset in
                manager.requestImage(for: asset, targetSize: .init(), contentMode: .aspectFit, options: options) { image, _ in
                    guard let image else { return }

                    DispatchQueue.main.async {
                        self.image = image
                        isProgress = false
                    }
                }
            }
        }
    }
}

#Preview {
    CapsuleItemFormView()
}
