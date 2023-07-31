//
//  LogOpinion.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/25.
//

import Foundation
import CloudKit

struct LogOpinion: Identifiable {
    
    let id: UUID
    let recordId: CKRecord.ID?
    let referenceId: CKRecord.Reference?
    var opinion: String
    let createdAt: Date
    
    static func fetchLogOpinion(log: Log) async -> [LogOpinion]  {
        let cloudKitManager = CloudKitManager.shared
        return await cloudKitManager.fetchLogOpinionRecord(log: log)
    }
    
}
