//
//  EnterCapsuleView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Alamofire
import SwiftUI

struct EnterCapsuleView: View {
    @State var code: String = ""

    var onCancel: () -> Void = {}
    var onConfirm: () -> Void = {}

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("캡슐 코드")
                .font(.system(size: 20, weight: .bold))

            TextField(text: $code) {
                Text("코드를 입력하세요.")
                    .font(.system(size: 20, weight: .bold))
            }
            .padding(10)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.92), lineWidth: 1))

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
                    onCancel()
                }

                HStack(alignment: .center, spacing: 8) {
                    Text("저장")
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
                        "code": self.code
                    ]

                    AF.request(
                        Global.baseUrl + "/member",
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding()
                    ).response { _ in
                        onConfirm()
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    EnterCapsuleView()
}
