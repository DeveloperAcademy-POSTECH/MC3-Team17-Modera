//
//  LogMemoWriteView.swift
//  DetectiveLog
//
//  Created by 한지석 on 2023/07/29.
//

import SwiftUI

struct LogWriteSheet: View {
    
    let writeType: WriteType
    @State var existingText: String = ""
    @Environment(\.dismiss) var dismiss
    @Binding var text: String
    @Binding var isPresented: Bool //  수정 화면을 같이 내려주기 위함
    @Binding var isFinishButtonClicked: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    text = existingText
                    isPresented.toggle()
                } label: {
                    Text("취소")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 20)
                Spacer()
                Button {
                    isPresented.toggle()
                    isFinishButtonClicked.toggle()
                } label: {
                    Text("완료")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 20)
            }
            .padding(.top, 14)
            .padding(.bottom, 20)
            
            HStack(alignment: .top, spacing: 0) {
                switch writeType {
                case .memo:
                    Text(dateToTime(date: Date()))
                        .font(.custom("AppleSDGothicNeo", size: 16))
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .foregroundColor(Color(red: 178 / 255,
                                               green: 178 / 255,
                                               blue: 178 / 255))
                case .opinion:
                    Image("pencilWithColor")
                        .padding(.top, 11)
                        .padding(.leading, 20)

                }
                
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(red: 205 / 255,
                                  green: 205 / 255,
                                  blue: 205 / 255),
                            lineWidth: 0.5)
                    .frame(height: 160)
                    .padding(.leading, 12)
                    .padding(.trailing, 20)
                    .overlay {
                        switch writeType {
                        case .memo:
                            TextEditor(text: $text)
                                .font(.custom("AppleSDGothicNeo", size: 14))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 2)
                        case .opinion:
                            TextEditor(text: $text)
                                .font(.custom("AppleSDGothicNeo", size: 14))
                                .foregroundColor(Color(red: 34 / 255, green: 83 / 255, blue: 160 / 255))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 2)
                        }
                    }
            }
            Spacer()
        }
        .onAppear {
            existingText = text
        }
    }
    
    func dateToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

enum WriteType {
    case memo
    case opinion
}
