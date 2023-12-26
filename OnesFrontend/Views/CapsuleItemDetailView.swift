//
//  CapsuleItemDetailView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import SwiftUI

struct CapsuleItemDetailView: View {
    @Environment(\.dismiss) var dismissAction
    
    @State var showFullScreen: Bool = false
    
    var location: String = "성북구 정릉동 국민대학교"
    var date: String = "2023년 12월 27일"
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("이미지")
                            .font(
                                .system(size: 20, weight: .bold)
                            )
                            .padding(.bottom, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { _ in
                                    PhotoComponent(mode: .read, name: "dummyphoto2")
                                        .onTapGesture {
                                            showFullScreen = true
                                        }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("편지")
                                .font(
                                    .system(size: 20, weight: .bold)
                                )
                                .padding(.top, 24)
                                .padding(.bottom, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rows, alignment: .center) {
                                    ForEach(0...5, id: \.self) { _ in
                                        LetterComponent(mode: .read)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("이 편지가 열린 날")
                                .font(
                                    .system(size: 20, weight: .semibold)
                                )
                            
                            HStack(spacing: 0) {
                                Image("access_time_filled")
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 10)
                                
                                Text(date)
                                    .font(
                                        .system(size: 20, weight: .semibold)
                                    )
                            }
                            
                            HStack(spacing: 0) {
                                Image("location_on")
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 10)
                                
                                Text(location)
                                    .font(
                                        .system(size: 20, weight: .semibold)
                                    )
                            }
                        }
                    }
                }
            }
        }
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
                        .system(size: 20, weight: .semibold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(width: 295, alignment: .top)
            }
        }
        .padding(20)
        .fullScreenCover(isPresented: $showFullScreen) {
            VStack(alignment: .leading, spacing: 0) {
                Image("arrow_back_ios_new")
                    .renderingMode(.template)
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        showFullScreen = false
                    }
                    .frame(width: 24, height: 24)
                    .padding(20)
                
                TabView {
                    ForEach(["dummyphoto2", "dummyphoto2", "dummyphoto2"], id: \.self) { item in
                        // 3
                        Image(item)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .tabViewStyle(.page)
            }
            .background(Color.black)
        }
    }
}
