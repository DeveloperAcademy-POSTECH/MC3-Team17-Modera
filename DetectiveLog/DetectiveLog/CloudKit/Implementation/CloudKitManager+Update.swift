//
//  CloudKitManager+Update.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/25.
//

import Foundation
import CloudKit

extension CloudKitManager {
    /// func updateLogRecord: LogMemo를 작성할 경우 Log에 일부 업데이트를 해주는 메소드입니다.
    /// - Parameter: log: Log, latestMemo: [string], updatedAt: Date
    func updateLogRecord(log: Log, latestMemo: [String], updatedAt: Date) {
        guard let recordId = log.recordId else { return }
        container.fetch(withRecordID: recordId) { record, error in
            guard let record = record else {
                if let error = error {
                    print("@Log updateLogRecord - \(error)")
                }
                return
            }
            record["latestMemo"] = latestMemo
            record["updatedAt"] = updatedAt
            self.container.save(record) { record, error in
                if let error = error {
                    print("@Log updateLogRecord - \(error)")
                    print("@Log updateLogRecord 완료!")
                }
            }
        }
    }
    
    /// func updateLogRecordCategory: 메인 뷰에서 Log의 카테고리를 이동할 때 사용합니다.
    /// - Parameter: [Log], LogCategory
    func updateLogRecordCategory(log: Log, category: LogCategory) {
        guard let recordId = log.recordId else { return }
        container.fetch(withRecordID: recordId) { record, error in
            guard let record = record else {
                if let error = error {
                    print("@Log changeLogRecordCategoryError - \(error.localizedDescription)")
                }
                return
            }
            record["category"] = category.rawValue
            self.container.save(record) { record, error in
                if let error = error {
                    print("@Log changeLogRecordCategoryErrorSave - \(error.localizedDescription)")
                } else {
                    print("@Log changeLogRecordCategory 완료!")
                }
            }
        }
    }
    
    func updateLogRecordIsPinned(log: Log, isPinned: Int) {
        guard let recordId = log.recordId else { return }
        container.fetch(withRecordID: recordId) { record, error in
            guard let record = record else {
                if let error = error {
                    print("@Log changeLogRecordIsPinned - \(error.localizedDescription)")
                }
                return
            }
            record["isPinned"] = isPinned
            self.container.save(record) { record, error in
                if let error = error {
                    print("@Log changeLogRecordIsPinnedSave - \(error.localizedDescription)")
                } else {
                    print("@Log changeLogRecordIsPinned 완료!")
                }
            }
        }
    }
    
    func updateLogMemoRecord(logMemo: LogMemo) {
        let recordId = logMemo.id
        container.fetch(withRecordID: recordId) { record, error in
            guard let record = record else {
                if let error = error {
                    print("@Log updateLogMemoRecord - \(error.localizedDescription)")
                }
                return
            }
            record["logMemo"] = logMemo.memo
            self.container.save(record) { record, error in
                if let error = error {
                    print("@Log updateLogMemoRecord - \(error.localizedDescription)")
                } else {
                    print("@Log updateLogMemoRecord 완료!")
                }
            }
        }
    }
    
    func updateLogOpinionRecord(logOpinion: LogOpinion) {
        let recordId = logOpinion.id
        container.fetch(withRecordID: recordId) { record, error in
            guard let record = record else {
                if let error = error {
                    print("@Log updateLogOpinionRecord error - \(error.localizedDescription)")
                }
                return
            }
            record["opinion"] = logOpinion.opinion
            self.container.save(record) { record, error in
                if let error = error {
                    print("@Log updateLogOpinionRecord error - \(error.localizedDescription)")
                }
                print("@Log updateLogOpinionRecord 완료!")
            }
        }
    }
    
}
