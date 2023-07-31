//
//  MemoCell.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/26.
//

import SwiftUI


struct MemoCell: View {
    
    let logMemo: LogMemo
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(dateToTime(date: logMemo.createdAt))
                .font(.custom("AppleSDGothicNeo-Regular", size: 14))
                .frame(width: 39)
                .opacity(0.3)
                .padding(.bottom, 22)
                .padding(.leading, 28)
            
            Text(logMemo.memo)
                .font(.custom("AppleSDGothicNeo-Regular", size: 14))
                .padding(.leading, 20)
                .padding(.trailing, 50)
                .padding(.bottom, 22)
            
            Spacer()
        }

    }
    
    func dateToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
