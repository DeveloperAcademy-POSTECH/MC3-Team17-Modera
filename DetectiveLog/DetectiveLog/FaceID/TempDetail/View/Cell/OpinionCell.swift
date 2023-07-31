//
//  OpinionCell.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/25.
//

import SwiftUI

struct OpinionCell: View {
    
    let logOpinion: LogOpinion
    
    var body: some View {
        HStack(alignment: .top,
               spacing: 0) {
            Image("pencilOpacity")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.gray)
                .padding(.leading, 28)

            Text(logOpinion.opinion.isEmpty ? "개인 사견을 적어주세요." : logOpinion.opinion)
                .font(.custom("AppleSDGothicNeo-Medium", size: 14))
                .foregroundColor(Color(red: 193 / 255, green: 205 / 255, blue: 225 / 255))
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom, 22)
            Spacer()
        }
//               .background(.green)
    }
    
}

//struct OpinionCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OpinionCell()
//    }
//}
//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//
//        ZStack(alignment: alignment) {
//            placeholder().opacity(shouldShow ? 1 : 0)
//            self
//        }
//    }
//}
