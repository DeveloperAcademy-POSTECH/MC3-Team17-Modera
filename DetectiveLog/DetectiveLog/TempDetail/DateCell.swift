//
//  DateCell.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/26.
//

import SwiftUI

struct DateCell: View {
    
    let combineLogData: CombineLogData
    
    var body: some View {
        Rectangle()
            .inset(by: 0.35)
            .stroke(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .overlay {
                HStack(spacing: 0) {
                    Text(formatDateToString(date: combineLogData.date))
                        .font(.custom("AppleSDGothicNeo-bold", size: 20))
                        .padding(.leading, 20)
                    Spacer()
                }
            }
            
//            .overlay {
//                Rectangle()
//
//            }
    }
    
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. dd"
        return dateFormatter.string(from: date)
    }
    
}

struct DateCell_Previews: PreviewProvider {
    static var previews: some View {
        DateCell(combineLogData: CombineLogData(id: UUID(), date: Date(), logOpinion: nil))
    }
}
