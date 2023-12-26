//
//  CapsuleItemFormView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import Photos

import SwiftUI

struct CapsuleItemFormView: View {
    @Environment(\.dismiss) var dismissAction

    @State var openPhoto: Bool = false
    @State var openLetter: Bool = false
    @State var image: UIImage? = nil
    @State var isProgress: Bool = false

    @State var location: String = ""

    @State var showSheet: Bool = false
    @State var addresses: [NaverLocalSearchResponseDTO.Item] = []
    @State var coord: (Double, Double) = (0, 0) // post시 위도, 경도

    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("이미지")
                            .font(
                                Font.custom("Pretendard", size: 20)
                                    .weight(.bold)
                            )
                            .padding(.bottom, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { _ in
                                    PhotoComponent(name: "dummyphoto2")
                                }

                                Button(action: {
                                    openPhoto = true
                                }, label: {
                                    VStack(alignment: .center, spacing: 24) {
                                        VStack(alignment: .center, spacing: 10) { Image("close")
                                            .frame(width: 24, height: 24)
                                        }
                                        .padding(4)
                                        .frame(width: 48, height: 48, alignment: .center)
                                        .cornerRadius(999)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 999)
                                                .inset(by: -0.5)
                                                .stroke(Color(red: 0.58, green: 0.57, blue: 0.56), lineWidth: 1)
                                        )

                                        Text("이미지 추가")
                                            .font(Font.custom("Pretendard Variable", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                            .frame(width: 223, alignment: .top)
                                    }
                                    .padding(16)
                                    .frame(width: 186, height: 186, alignment: .center)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.58, green: 0.57, blue: 0.56), style: StrokeStyle(lineWidth: 1, dash: [10, 10]))
                                    )
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("편지")
                            .font(
                                Font.custom("Pretendard", size: 20)
                                    .weight(.bold)
                            )
                            .padding(.top, 24)
                            .padding(.bottom, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { _ in
                                    LetterComponent()
                                }

                                Button(action: {
                                    openLetter = true
                                }, label: {
                                    VStack(alignment: .center, spacing: 24) {
                                        VStack(alignment: .center, spacing: 10) { Image("close")
                                            .frame(width: 24, height: 24)
                                        }
                                        .padding(4)
                                        .frame(width: 48, height: 48, alignment: .center)
                                        .cornerRadius(999)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 999)
                                                .inset(by: -0.5)
                                                .stroke(Color(red: 0.58, green: 0.57, blue: 0.56), lineWidth: 1)
                                        )

                                        Text("편지 추가")
                                            .font(Font.custom("Pretendard Variable", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                            .frame(width: 223, alignment: .top)
                                    }
                                    .padding(16)
                                    .frame(width: 168, height: 168, alignment: .center)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.58, green: 0.57, blue: 0.56), style: StrokeStyle(lineWidth: 1, dash: [10, 10]))
                                    )
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 24)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Image("location_on")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 10)

                            Text("장소")
                                .font(
                                    Font.custom("Pretendard Variable", size: 20)
                                        .weight(.semibold)
                                )
                        }
                        .padding(.bottom, 10)

                        HStack(alignment: .center, spacing: 24) {
                            TextField("장소를 입력하세요.", text: $location)
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .onTapGesture {
                                    searchLocation(target: self.location) { response in
                                        self.addresses = response
                                        self.showSheet = true
                                    }
                                }
                        }
                        .padding(16)
                        .frame(width: 343, alignment: .center)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.84, green: 0.84, blue: 0.82), lineWidth: 1)
                        )
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                Overlay(showSheet: $showSheet, addresses: $addresses, completion: { item in
                    getLatLng(target: item.roadAddress) { x, y in
                        coord = (x, y)
                        self.location = item.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    }
                })
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            })
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismissAction.callAsFunction()
                    } label: {
                        Image("arrow_back_ios_new")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("타임 캡슐")
                        .font(
                            Font.custom("Pretendard Variable", size: 20)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .frame(width: 295, alignment: .top)
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
