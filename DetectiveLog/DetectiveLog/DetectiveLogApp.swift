//
//  DetectiveLogApp.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/19.
//

import SwiftUI

@available(iOS 16.0, *)
@main
@available(iOS 16.0, *)
struct DetectiveLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            CategoryView()
            LogView()
//            LogMemoWriteView()
//            DetailLogMenuSheet()
        }
    }
}
