//
//  CreateCapsuleView.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selection: Date
    var displayedComponents: [DatePicker.Components]
    var pastCutoffDate: Date?
    @Binding var isWarning: Bool

    @State private var isDateClicked: Bool = false
    @State private var isTimeClicked: Bool = false

    init(
        selection: Binding<Date>,
        displayedComponents: [DatePicker.Components] = [.date, .hourAndMinute],
        pastCutoffDate: Date? = nil,
        isWarning: Binding<Bool> = .constant(false)
    ) {
        _selection = selection
        self.displayedComponents = displayedComponents
        self.pastCutoffDate = pastCutoffDate
        _isWarning = isWarning
    }

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter
    }()

    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        return formatter
    }()

    var body: some View {
        HStack(spacing: 8) {
            if displayedComponents.contains(.date) {
                VStack(alignment: .center, spacing: 20) {
                    Text("\(formatter.string(from: selection))")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.vertical, 13)
                        .padding(.horizontal, 28)
                        .background(Color(red: 0.37, green: 0.48, blue: 0.68))
                        .cornerRadius(66)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(.white)
                .cornerRadius(12)
                .onTapGesture { _ in
                    if !isDateClicked {
                        isDateClicked = true
                    }
                }
                .popover(isPresented: $isDateClicked, arrowDirection: .unknown) {
                    if let pastCutoffDate {
                        DatePicker(
                            "",
                            selection: $selection,
                            in: pastCutoffDate...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    } else {
                        DatePicker(
                            "",
                            selection: $selection,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                    }
                }
            }
        }
    }
}

struct CreateCapsuleView: View {
    @State var location: String = ""
    @State var capsuleTitle: String = ""
    @State var now: Date = .now

    @State var addresses: [NaverLocalSearchResponseDTO.Item] = []
    @State var showSheet: Bool = false
    @State var coord: (Double, Double) = (0, 0)

    var onCancel: () -> Void = {}
    var onConfirm: () -> Void = {}

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomDatePicker(selection: $now, displayedComponents: [.date])
                .padding(.bottom, 24)

            HStack {
                Text("타임 캡슐 이름")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 8)

            HStack(alignment: .center, spacing: 24) {
                TextField("캡슐에 이름을 붙여주세요", text: $capsuleTitle)
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

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("location_on")
                        .frame(width: 24, height: 24)

                    Text("장소")
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.bottom, 10)

                HStack(alignment: .center, spacing: 24) {
                    TextField("장소를 입력하세요.", text: $location)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .onTapGesture {
                            searchLocation(target: self.location) { response in
                                self.addresses = response
                                self.showSheet = true
                            }
                        }
                }
                .padding(16)
                .frame(width: 343, alignment: .center)
                .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.82), lineWidth: 1)
                )
                .padding(.bottom, 28)

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
                        onConfirm()
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(.white)
        .cornerRadius(12)
        .sheet(isPresented: $showSheet, content: {
            Overlay(showSheet: $showSheet, addresses: $addresses, completion: { item in
                getLatLng(target: item.roadAddress) { x, y in
                    coord = (x, y)
                    self.location = item.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                }
            })
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    CreateCapsuleView()
}
