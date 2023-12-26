//
//  LetterFormView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import SwiftUI

struct LetterFormView: View {
    @Environment(\.dismiss) var dismissAction
    @State var letter: String = ""
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    dismissAction()
                } label: {
                    Image(systemName: "arrow.backward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Spacer()
                
                Text("편지 작성")
                
                Spacer()
                
                Button {
                    dismissAction()
                    // API 호출하기
                } label: {
                    Image(systemName: "checkmark")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .foregroundColor(Color(0x191919))
            
            TextField("편지를 작성해주세요", text: $letter, axis: .vertical)
                .padding()
                .background(.gray.opacity(0.2))
                .foregroundStyle(Color(0x191919))
                .cornerRadius(10)
                .lineLimit(15)
                .frame(alignment: .top)
                .foregroundColor(Color(0x191919))
                .background(Color(0xfdfdfd))
                .padding(.top, 24)
            // 1000자 이상 입력 막기
            //            .onChange(of: postFormVM.content) { value in
            //                if value.count > 1000 {
            //                    postFormVM.content = String(
            //                        value[
            //                            value.startIndex ..< value.index(value.endIndex, offsetBy: -1)
            //                        ]
            //                    )
            //                }
            //            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
