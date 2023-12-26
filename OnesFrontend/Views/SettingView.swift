//
//  SettingView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismissAction

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                SettingRow(iconName: "setting-account", content: "로그인") {}

                SettingRow(iconName: "setting-privacy", content: "회원 가입") {
                    SignUpView()
                }

                SettingRow(iconName: "setting-privacy", content: "로그아웃") {}
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
    }
}

struct SettingRow<Destination: View>: View {
    let iconName: String
    let content: String
    @ViewBuilder var destination: () -> Destination

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                self.destination()
            } label: {
                HStack(spacing: 0) {
                    Image(self.iconName)
                        .renderingMode(.template)
                        .foregroundColor(Color(0x646464))
                        .frame(width: 28, height: 28)
                        .padding(.trailing, 10)

                    Text(self.content)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(0x191919))

                    Spacer()

                    Image("setting-detail-button")
                        .frame(width: 28, height: 28)
                }
            }

            Divider()
                .padding(.top, 8)
        }
    }
}

#Preview {
    SettingView()
}
