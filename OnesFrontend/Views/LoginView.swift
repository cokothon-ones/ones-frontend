//
//  LoginView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Alamofire
import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismissAction

    // MARK: - Propertiers

    @State private var email = ""
    @State private var password = ""

    // MARK: - View

    var body: some View {
        HStack {
            Text("이메일")
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .padding(.horizontal, 16)

        HStack(alignment: .center, spacing: 24) {
            TextField("이메일을 입력해주세요", text: $email)
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
        .padding(.bottom, 10)

        HStack {
            Text("비밀번호")
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .padding(.horizontal, 16)

        HStack(alignment: .center, spacing: 24) {
            SecureField("비밀번호를 입력해주세요", text: $password)
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

        HStack(alignment: .center, spacing: 8) {
            Text("로그인")
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
        .padding(20)
        .onTapGesture {
            let parameters: Parameters = [
                "email": email,
                "password": password,
            ]

            AF.request(
                Global.baseUrl + "/auth/login",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default
            ).responseDecodable(of: LoginResponseDTO.self) { response in
                switch response.result {
                case let .success(response):
                    dismissAction.callAsFunction()
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
