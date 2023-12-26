//
//  LetterComponent.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import SwiftUI

struct LetterComponent: View {
    var text: String = "이 편지를 쓰는 순간부터, 내 마음은 그리움으로 가득 차올랐어요. 너와 함께한 그 순간들은 나에게 소중한 기억으로 남아있어요. 우리가 함께한 때의 행복과 따뜻함은 언제나 나를 안정시켜주었고, 지금도 내 마음속에 빛나고 있어요. 기억하시나요? 우리가 함께한 그 해변에서의 휴가를? 파도 소리가 우리 귓가에 들리던 그 순간, 너와 함께였던 시간들은 내 인생에서 가장 아름다운 순간 중 하나였어요. 당신과 함께 했던 모든 순간들이 나에게는 소중한 보물입니다. 가끔은 우리가 함께 했던 그 시간들을 떠올리며 웃음 지으며 지난 날을 추억해요. 당신과 함께했던 모든 순간들은 내 인생을 더욱 풍요롭게 만들었고, 나를 더 강하게 만들었어요. 나의 사랑하는 [이름], 당신을 생각할 때마다 미소가 지어지고, 그때의 행복함을 떠올리며 정말 고맙다고 느껴요. 그때의 우리가 지닌 특별한 추억은 영원히 내 마음속에 간직될 거예요. 언젠가 우리는 다시 만날 거라는 생각에 기대가 돼요. 그때까지, 내 사랑하는 [이름]이 행복하길 바라며, 항상 당신을 생각하고 있을 거예요."

    var body: some View {
        VStack(spacing: 0) {
            Text(text)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
                .padding(10)
                .background(Color(0x4c66ec))
                .cornerRadius(10)
                .shadow(radius: 1)
        }
    }
}

#Preview {
    LetterComponent()
}
