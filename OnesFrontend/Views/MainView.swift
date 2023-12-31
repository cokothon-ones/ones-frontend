//
//  MainView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Alamofire
import SwiftUI

struct CapsuleList: View {
    @Binding var data: Capsules

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 29) {
                ForEach($data.items) { $capsule in
                    CapsuleMainItem(title: capsule.title, date: capsule.date, dDay: capsule.getDDay(), isOpen: capsule.date <= .now, location: capsule.location, capsuleCode: capsule.code, capsuleId: capsule.id)
                        .simultaneousGesture(TapGesture()
                            .onEnded { _ in
                                let headers: HTTPHeaders = [
                                    "Set-Cookie": Global.default.sid,
                                ]

                                let parameters: Parameters = [
                                    "capsuleId": capsule.id,
                                    "latitude": capsule.latitude,
                                    "longitude": capsule.longitude,
                                ]

                                AF.request(
                                    Global.baseUrl + "/member/auth",
                                    method: .patch,
                                    parameters: parameters,
                                    encoding: JSONEncoding.default,
                                    headers: headers
                                ).response { result in
                                    print(result.response)
                                }
                            })
                }
                Spacer(minLength: 70)
            }
        }
    }
}

struct MainView: View {
    @State var isSelected: Bool = true
    @State var showModal: Bool = false
    @State var navigated: Bool = false

    @State var showCapsuleCodeForm: Bool = false

    @State var location: String = ""
    @State var capsuleCode: String = ""
    @State var capsuleId: Int = -1

    @StateObject var global: Global

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                Spacer(minLength: 20)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("잠김")
                            .bold()
                            .frame(width: 175)
                            .foregroundColor(self.isSelected ? Color(0x191919) : Color(0xacacac))
                            .onTapGesture {
                                withAnimation {
                                    self.isSelected = true
                                }
                            }

                        Text("열림")
                            .bold()
                            .frame(width: 175)
                            .foregroundColor(self.isSelected ? Color(0xacacac) : Color(0x191919))
                            .onTapGesture {
                                withAnimation {
                                    self.isSelected = false
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .padding(.top, 10)
                    .padding(.bottom, 10)

                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(red: 0.78, green: 0.78, blue: 0.8))
                            .frame(width: 175 * 2, height: 2)

                        Rectangle()
                            .fill(Color(0x191919))
                            .frame(width: 175, height: 2)
                            .offset(x: self.isSelected ? 0 : 175)
                    }
                }
                .background(Color.white)

                Spacer(minLength: 5)

                HStack(alignment: .center, spacing: 5) {
                    Text("\(isSelected ? "잠긴" : "열린") 캡슐")
                        .foregroundColor(Color(0x191919))

                    Text("\(global.capsules.getCapsules(locked: isSelected).items.count)")
                        .foregroundColor(Color(red: 0.37, green: 0.48, blue: 0.68))

                    Spacer()

                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .onTapGesture {
                            showCapsuleCodeForm = true
                        }
                }
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 24)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)

                CapsuleList(data: Binding.constant(global.capsules.getCapsules(locked: isSelected)))
            }

            HStack(alignment: .center, spacing: 15) {
                Image(systemName: "plus")
                Text("새 캡슐 만들기")
                    .font(.system(size: 16, weight: .bold))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .foregroundColor(.white)
            .background {
                Color.black
                    .cornerRadius(12)
            }
            .padding([.trailing, .bottom], 20)
            .onTapGesture {
                showModal = true
            }

            NavigationLink("", destination: CapsuleItemFormView(location: location, capsuleCode: capsuleCode, capsuleId: capsuleId), isActive: $navigated)

            if showModal {
                ZStack {
                    Color(.black)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.4)
                        .zIndex(10)
                        .onTapGesture {
                            showModal = false
                        }

                    CreateCapsuleView(location: $location, capsuleCode: $capsuleCode, onCancel: { showModal = false }, onConfirm: {
                        showModal = false

                        // TODO: REQUEST CREATE CAPSULE
                        CapsuleRoomService.fetchCapsules(userId: Global.default.user.id) { response in
                            Global.default.capsules = response
                        }
                        navigated = true // IF SUCCESS
                    })
                    .zIndex(11)
                    .padding(.horizontal, 10)
                }
            } else if showCapsuleCodeForm {
                ZStack {
                    Color(.black)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.4)
                        .zIndex(10)
                        .onTapGesture {
                            showCapsuleCodeForm = false
                        }

                    EnterCapsuleView(onCancel: {
                        showCapsuleCodeForm = false
                    }, onConfirm: {
                        CapsuleRoomService.fetchCapsules(userId: Global.default.user.id) { response in
                            Global.default.capsules = response
                        }
                        showCapsuleCodeForm = false
                    })
                    .zIndex(11)
                    .padding(.horizontal, 10)
                }
            }
        }
        .onAppear {
            CapsuleRoomService.fetchCapsules(userId: Global.default.user.id) { response in
                Global.default.capsules = response
            }
        }
    }
}
