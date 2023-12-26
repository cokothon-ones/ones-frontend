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
            VStack(alignment: .leading, spacing: 0) {
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
                                        .frame(width: 150, height: 250)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .shadow(radius: 1)
                                        .padding(.vertical, 1)
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
                                ForEach(0...5, id: \.self) { _ in
                                    LetterComponent()
                                }

                                Button(action: {
                                    print("add action")
                                }, label: {
                                    Image(systemName: "plus")
                                        .frame(width: 100, height: 100)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .shadow(radius: 1)
                                        .padding(.vertical, 1)
                                })
                            }
                        }
                    }
                }
                .padding(.bottom, 10)

                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("장소")
                        Text("성북구 정릉동 국민대학교")
                    }
                }
            }
        }
        .padding(20)
    }
}

#Preview {
    CapsuleItemFormView()
}
