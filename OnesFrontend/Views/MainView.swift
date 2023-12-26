//
//  MainView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct MainView: View {
    @State var isSelected: Bool = true

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                Spacer(minLength: 20)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("잠김")
                            .frame(width: 175)
                            .foregroundColor(self.isSelected ? Color(0x1DAFFF) : Color(0xACACAC))
                            .onTapGesture {
                                withAnimation {
                                    self.isSelected = true
                                }
                            }

                        Text("열림")
                            .frame(width: 175)
                            .foregroundColor(self.isSelected ? Color(0xACACAC) : Color(0x1DAFFF))
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
                            .fill(.clear)
                            .frame(width: 175 * 2, height: 4)

                        Rectangle()
                            .fill(RadialGradient(
                                colors: [
                                    Color(0xAAD7FF),
                                    Color(0xD2D7FF)
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 90
                            ))
                            .frame(width: 175, height: 4)
                            .offset(x: self.isSelected ? 0 : 175)
                    }
                }
                .background(Color.white)

                Spacer(minLength: 5)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        ForEach(1 ... 10, id: \.self) { idx in
                            CapsuleMainItem(title: "Test \(idx)")
                                .padding(.horizontal, 1)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)

            Image("add-button")
                .padding(15)
                .onTapGesture {
                    // TODO: NAVIGATE TO ADD VIEW
                }
        }
    }
}

#Preview {
    MainView()
}
