//
//  SignUpView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Alamofire
import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismissAction

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack {
                    Text("이메일")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 20)

                HStack(alignment: .center, spacing: 24) {
                    TextField("email", text: $email)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(16)
                .frame(width: 343, height: 56, alignment: .leading)
                .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.82),
                                lineWidth: 1)
                )
                .padding(.bottom, 24)

                HStack {
                    Text("비밀번호")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 20)

                HStack(alignment: .center, spacing: 24) {
                    TextField("password", text: $password)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(16)
                .frame(width: 343, height: 56, alignment: .leading)
                .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.82),
                                lineWidth: 1)
                )
                .padding(.bottom, 24)

                HStack(spacing: 10) {
                    HStack(alignment: .center, spacing: 8) {
                        Text("취소")
                            .font(
                                .system(size: 20, weight: .bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                    .cornerRadius(12)
                    .onTapGesture {
                        dismissAction.callAsFunction()
                    }

                    HStack(alignment: .center, spacing: 8) {
                        Text("회원 가입")
                            .font(
                                .system(size: 20, weight: .bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                    .background(Color(red: 0.37, green: 0.47, blue: 0.68))
                    .cornerRadius(12)
                    .onTapGesture {
                        let parameters: Parameters = [
                            "email": email,
                            "password": password,
                        ]

                        AF.request(
                            Global.baseUrl + "/auth/join",
                            method: .post,
                            parameters: parameters,
                            encoding: JSONEncoding.default
                        ).responseDecodable(of: SignUpResponseDTO.self) { response in
                            switch response.result {
                            case let .success(response):
                                dismissAction.callAsFunction()
                            case let .failure(error):
                                print(error)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    SignUpView()
}
