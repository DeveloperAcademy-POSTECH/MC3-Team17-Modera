//
//  DetailLogMenuSheet.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/29.
//

import SwiftUI

@available(iOS 16.0, *)
struct DetailLogMenuSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isEditPresented: Bool = false
    
    @ObservedObject var viewModel: DetailViewModel
    @Binding var logMemo: LogMemo
    @Binding var isPresented: Bool
    @Binding var isEditButtonClicked: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: 33)
                .frame(maxWidth: .infinity)
            List {
                Button {
                    isEditPresented.toggle()
                } label: {
                    HStack {
                        Text("")
                        Text("수정하기")
                        Spacer()
                        Image(systemName: "book")
                            .padding(.trailing, 10)
                    }
                }
                .listRowSeparatorTint(.white)
                
                Button {
                    if let log = viewModel.log {
                        Task {
                            await viewModel.deleteLogMemo(log: log, logMemo: logMemo)
                        }
                    }
                    isPresented.toggle()
                } label: {
                    HStack {
                        Text("")
                        Text("삭제하기")
                        Spacer()
                        Image(systemName: "trash")
                            .padding(.trailing, 10)
                    }
                }
                .listRowSeparatorTint(.white)
                
            }
            .listRowInsets(EdgeInsets())
            .listStyle(.inset)
        }
        .sheet(isPresented: $isEditPresented, content: {
            LogWriteSheet(writeType: .memo,
                          text: $logMemo.memo,
                          isPresented: $isPresented,
                          isFinishButtonClicked: $isEditButtonClicked)
            .presentationDetents([.height(247)])
        })
    }
    
}


