//
//  DetailViewModel.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/25.
//

import Foundation
import CloudKit

final class DetailViewModel: ObservableObject {
    
    let cloudKitManager = CloudKitManager.shared
    let faceIdManager = FaceIDManager()
    let logCount: Int
    
    @Published var detailLog: [DetailLog] = []
    @Published var log: Log?
    @Published var detailLogIndex = 0
    @Published var logMemoIndex = 0
    @Published var newMemo = ""
    @Published var editMemo = ""
    var lastIndex: UUID?
    
    init(log: Log?, logCount: Int) {
        self.log = log
        self.logCount = logCount
    }
    
    func fetchLogData(log: Log) async {
        let logMemo = await LogMemo.fetchLogMemoRecord(log: log)
        let logOpinion = await LogOpinion.fetchLogOpinion(log: log)
        arrayToDictionary(logMemo: logMemo, logOpinion: logOpinion)
    }
    
    func updateLogTitle() {
        guard let log = log else { return }
        cloudKitManager.updateLogRecordTitle(log: log, title: log.title)
    }
    
    func createLog() {
        cloudKitManager.createLogRecord(log: Log(id: UUID(),
                                                 recordId: nil,
                                                 category: .inProgress,
                                                 title: "\(logCount)번째 사건일지",
                                                 latestMemo: nil,
                                                 isBookmarked: 0,
                                                 isLocked: 0,
                                                 isPinned: 0,
                                                 createdAt: Date(),
                                                 updatedAt: Date())) { [weak self] recordId in
            self?.cloudKitManager.fetchDetailLogRecord(id: recordId) { [weak self] log in
                DispatchQueue.main.async {
                    self?.log = log
                }
            }
        }
    }
    
    func updateLogMemo(logMemo: LogMemo) {
        print("@Log updateLogMemo - \(logMemo)")
        cloudKitManager.updateLogMemoRecord(logMemo: logMemo)
    }
    
    func updateLogOpinion(logOpinion: LogOpinion) {
        cloudKitManager.updateLogOpinionRecord(logOpinion: logOpinion)
    }
    
    @MainActor
    func createLogMemo(log: Log, memo: String, status: MemoStatus) async {
        guard let referenceId = log.recordId else { return }
        var logMemo = LogMemo(id: UUID(),
                              recordId: nil,
                              referenceId: CKRecord.Reference(recordID: referenceId, action: .none),
                              memo: memo,
                              logMemoDate: Date(),
                              createdAt: Date())
        let newLogMemo = await cloudKitManager.createLogMemoRecord(log: log, logMemo: logMemo)
        logMemo.recordId = newLogMemo
        let today = Calendar.current.startOfDay(for: Date())

        switch status {
        case .new:
            let logOpinion = LogOpinion(id: UUID(), recordId: nil, referenceId: nil, opinion: "", createdAt: Date())
            cloudKitManager.createdLogOpinionRecord(log: log, logOpinion: logOpinion)
            let newDetailLog = DetailLog(id: UUID(),
                                              date: today,
                                              logMemo: [logMemo],
                                              logOpinion: logOpinion)
            detailLog.append(newDetailLog)
            
        case .exist:
            if let index = detailLog.firstIndex(where: { $0.date == today }) {
                detailLog[index].logMemo.append(logMemo)
            }
        }
        
        var latestMemo: [String] = []
        for i in 0..<detailLog.count {
            for j in 0..<detailLog[i].logMemo.count {
                latestMemo.append(detailLog[i].logMemo[j].memo)
            }
        }
        latestMemo.reverse()
        
        print("@Log memo latest - \(latestMemo)")
        cloudKitManager.updateLogRecord(log: log,
                                        latestMemo: latestMemo,
                                        updatedAt: Date())
        
        lastIndex = detailLog.last?.logMemo.last?.id
    }
    
    //MARK: 데이터 패치하지 않고, 배열에서 pop하는 방식을 채택할 예정
    func deleteLogMemo(log: Log, logMemo: LogMemo) async {
        await cloudKitManager.deleteLogMemoRecord(logMemo: logMemo)
        await fetchLogData(log: log)
    }
    
    func arrayToDictionary(logMemo: [LogMemo],
                           logOpinion: [LogOpinion]) {
        let memo = Dictionary(grouping: logMemo) {
            Calendar
                .current
                .startOfDay(for: $0.createdAt) }
        let opinion = Dictionary(grouping: logOpinion) {
            Calendar
                .current
                .startOfDay(for: $0.createdAt) }
                .compactMapValues { $0.first }
        combineData(logMemo: memo, logOpinion: opinion)
    }
        
    func combineData(logMemo: [Date: [LogMemo]], logOpinion: [Date: LogOpinion]? ) {
        let memoTuple = logMemo.sorted(by: { $0.key < $1.key })
        DispatchQueue.main.async {
            for (date, memos) in memoTuple {
                if let opinions = logOpinion?[date] {
                    print("@Log kozi - \(memos)")
                    let memo = memos.sorted(by: { $0.createdAt < $1.createdAt })
                    let data = DetailLog(id: UUID(), date: date, logMemo: memo, logOpinion: opinions)
                    self.detailLog.append(data)
                } else {
                    print("@Log kozi - \(memos)")
                    let memo = memos.sorted(by: { $0.createdAt < $1.createdAt })
                    let data = DetailLog(id: UUID(), date: date, logMemo: memo, logOpinion: LogOpinion(id: UUID(), recordId: nil, referenceId: nil, opinion: "개인 사견을 적어주세요", createdAt: Date()))
                    self.detailLog.append(data)
                }
            }
            self.lastIndex = self.detailLog.last?.logMemo.last?.id
        }
    }
    
    func detailLogIsLocked(_ completion: @escaping ((Bool) -> ())) {
        faceIdManager.authenticate(authCase: .detailAuth(completion: { bool in
            completion(bool)
        }))
    }
    
}


enum LogConvert {
    case logMemo
    case logOpinion
}
