//
//  ContentView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")

                NavigationLink {
                    CapsuleItemFormView()
                } label: {
                    // 나중에 메인 화면에서 추가 버튼으로 옮겨 줄 것
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
