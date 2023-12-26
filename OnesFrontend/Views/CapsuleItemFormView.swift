//
//  CapsuleItemFormView.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import SwiftUI

struct CapsuleItemFormView: View {
    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)

    // dummy data
    var imageNames: [String] = [
        "dummyphoto", "dummyphoto2",
        "dummyphoto", "dummyphoto2",
        "dummyphoto", "dummyphoto2",
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("사진")
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...5, id: \.self) { idx in
                                    PhotoComponent(name: imageNames[idx])
                                }

                                Button(action: {
                                    print("add action")
                                }, label: {
                                    Image(systemName: "plus")
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("편지")
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(0...19, id: \.self) { _ in
                                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 50, height: 50)
                                        .padding()
                                }
                            }
                        }
                    }
                }

                Group {
                    VStack(spacing: 0) {}
                }
            }
        }
        .padding(20)
    }
}

#Preview {
    CapsuleItemFormView()
}
