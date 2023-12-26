//
//  MainView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct MainView: View {
    private let column = [GridItem(.flexible(), spacing: 20),
                          GridItem(.flexible(), spacing: 20)]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: column, spacing: 5) {
                        ForEach(1 ... 10, id: \.self) { _ in
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .padding(20)

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
