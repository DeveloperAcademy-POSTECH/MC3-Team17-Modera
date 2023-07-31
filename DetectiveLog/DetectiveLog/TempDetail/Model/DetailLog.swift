//
//  CombineLogData.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/26.
//

import Foundation

struct DetailLog: Identifiable, Equatable {
    
    static func == (lhs: DetailLog, rhs: DetailLog) -> Bool {
        return true
    }
    
    let id: UUID
    let date: Date
    var logMemo: [LogMemo] = []
    var logOpinion: LogOpinion
}
