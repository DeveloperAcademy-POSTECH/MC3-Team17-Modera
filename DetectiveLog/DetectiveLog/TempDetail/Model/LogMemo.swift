//
//  LogList.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/24.
//

import Foundation
import CloudKit

struct LogMemo: Identifiable, Hashable {
    
    let id: UUID
    var recordId: CKRecord.ID?
    let referenceId: CKRecord.Reference?
    var memo: String
    let logMemoDate: Date
    var createdAt: Date

    static func fetchLogMemoRecord(log: Log) async -> [LogMemo] {
        let cloudKitManager = CloudKitManager.shared
        return await cloudKitManager.fetchLogMemoRecord(log: log)
    }

}

enum MemoStatus {
    case new
    case exist
}
