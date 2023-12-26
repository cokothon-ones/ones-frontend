//
//  CapsuleMainItem.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct CapsuleMainItem: View {
    var title: String
    var date: Date
    var dDay: Int
    var isOpen: Bool = true

    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter
    }()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("\(dDay)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12)
                            )
                    }
                    .padding(4)
                    .frame(width: 48, height: 36, alignment: .center)
                    .cornerRadius(999)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .inset(by: -0.5)
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding(.leading, 10)

                    Spacer()

                    ZStack {
                        Image("capsule")
                            .offset(CGSize(width: isOpen ? 65 : 55, height: 35))

                        if !isOpen {
                            Text("\(formatter.string(from: date))")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.vertical, 13)
                                .padding(.horizontal, 28)
                                .background(Color(red: 0.37, green: 0.48, blue: 0.68))
                                .cornerRadius(66)
                        } else {
                            HStack(spacing: 10) {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 84, height: 59)
                                    .background(Color(red: 0.61, green: 0.61, blue: 0.61))
                                    .cornerRadius(66)
                                    .rotationEffect(Angle(degrees: -15))
                                    .overlay {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 50, height: 57)
                                            .background(Color(red: 0.61, green: 0.61, blue: 0.61))
                                            .offset(CGSize(width: 20, height: 0))
                                            .rotationEffect(Angle(degrees: -15))
                                    }
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 83.00001, height: 59)
                                    .background(Color(red: 0.61, green: 0.61, blue: 0.61))
                                    .cornerRadius(66)
                                    .rotationEffect(Angle(degrees: 5))
                                    .overlay {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 50, height: 59)
                                            .background(Color(red: 0.61, green: 0.61, blue: 0.61))
                                            .offset(CGSize(width: -20, height: 0))
                                            .rotationEffect(Angle(degrees: 5))
                                    }
                            }
                            .overlay {
                                Text("\(formatter.string(from: date))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                            }
                        }
                    }
                }
                .zIndex(1)
                .padding(.bottom, 8)

                HStack(alignment: .center, spacing: 24) {
                    Text("\(title)")
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(width: 292, alignment: .leading)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(2)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.82),
                                lineWidth: 1)
                )
                .padding(.trailing, 25)
                .zIndex(0)
            }
        }
        .padding(.horizontal, 26)
    }
}

#Preview {
    CapsuleMainItem(title: "Test", date: .now, dDay: 0)
}
