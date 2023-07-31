//
//  DetailView.swift
//  DetectiveLog
//
//  Created by OLING on 2023/07/24.
//

import SwiftUI

//시간,메모 더미데이터
struct TempCellModel: Identifiable {
    
    @FocusState private var isFocused: Bool
    
    let id: UUID
    let time: String
    var memo: String
    
}

//사견 더미데이터
struct CommentCellModel: Identifiable {
    
    @State private var text: String = ""
    
    var id: UUID
    var comment : String
}


@available(iOS 16.0, *)
struct TempDetailView: View {
    
    @Namespace var topID
    @Namespace var bottomID
    
    @State var newnote: String = ""
    @State var isShowingModal = false
    @State var text: String = ""
    @FocusState private var isFocused: Bool
    @State var isButtonToggled = false
    @State private var islogMemoTextFieldHidden = false
    @State var scrollToBottom = true

    @ObservedObject var viewModel: DetailViewModel
    
    //시간,메모 더미데이터
    @State var tempCellModel: [TempCellModel] = [
        TempCellModel(id: UUID(),time: "01:05", memo: "조예린 최고 멋쟁이 아니 조예린이 코드를 친다구? 코딩 열심히할게요 시켜만 주세요 알려도 주세요"),
        TempCellModel(id: UUID(),time: "10:30", memo: "방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함.방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함.방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함.방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함."),
        TempCellModel(id: UUID(),time: "12:30", memo: "한지석"),
    ]
    
    //사견 더미데이터
    @State var commentCellModel: [CommentCellModel] = [
        CommentCellModel(id: UUID(), comment: "방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함."),
        CommentCellModel(id: UUID(), comment: "오잉"),
        CommentCellModel(id: UUID(), comment: "방이 어지럽혀져 있고 문이 열려있다. 황금파리가 꼬인 것으로 보아 사망한지 6일 정도 지난 듯함.")
    ]
    
    
    
    var body: some View {
        VStack {
//            TexttField("", text: x)
            if let log = viewModel.log {
                Text(log.title)
            }
            logCell
            ZStack {
                logMemoTextField
                logMemoTextFieldButtons
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    Button {
//                        viewModel.combineData()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                    Button {
//                        viewModel.createLogMemo(log: viewModel.log!, memo: "한지석")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
//                    Menu {
//                        menuItems
//                    } label: {
//                        Label("", systemImage: "ellipsis")
//                            .foregroundColor(.black)
//                    }
                }
            }
            
        }
        .onAppear {
            if let log = viewModel.log {
//                viewModel.fetchLogMemo(log: log)
            } else {
                viewModel.createLog()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder
    var logCell: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack(alignment: .leading) {
                    ForEach(viewModel.detailLog) { logData in
                        dateCell(date: formatDateToString(date: logData.date))
                        ScrollView {
                            VStack(alignment: .leading) {
                                memoCell(logMemo: logData.logMemo)
    //                            commentCell
                            }
                        }
                    }

                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 10)

                }

            }
            .padding()
            .onAppear {
                
            }
        }
    }
    
    func dateCell(date: String) -> some View {
        return VStack{
            Rectangle()
                .frame(height: 0.4)
                .frame(width: UIScreen.main.bounds.width)
                .opacity(0.5)
            
            HStack {
                Text(date)
                    .font(.system(size: 17))
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Button(action: {
                    isShowingModal = true
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .font(.system(size:25))
                        .opacity(0.2)
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 7)
            
            Rectangle()
                .frame(height: 0.4)
                .frame(width: UIScreen.main.bounds.width)
                .opacity(0.5)
            
        }
        .padding(.vertical, 5)
        
    }
//    var dateCell: some View {
//
//    }
    
    //메모 더미데이터
    func memoCell(logMemo: [LogMemo]) -> some View {
        return ForEach(logMemo, id: \.self) { memo in
            HStack(alignment: .top) {
                Text(formatDateToString(date: memo.createdAt))
                    .opacity(0.3)
                    .padding(.horizontal, 5)
                    .font(.system(size: 13))

                Text(memo.memo)
                    .lineLimit(1...)
                    .font(.custom(("AppleSDGofhicNeo"), size: 13))
                    .lineSpacing(6)
                    
//                TextField("", text: memo.memo, axis: .vertical)

//                    .onTapGesture {
//                        isFocused = true
//                    }
            }
            .onAppear {
                print("@Log memo - \(memo.memo)")
            }
            .padding(.vertical, 8)
            .padding(.trailing, 20)
            .padding(.horizontal, 10)
        }
     
    }
    
//    var memoCell: some View {
//
//        ForEach($viewModel.logMemo) { logMemo in
//            HStack(alignment: .top) {
//                Text(formatDateToString(date: logMemo.createdAt.wrappedValue))
//                    .opacity(0.3)
//                    .padding(.horizontal, 5)
//                    .font(.system(size: 13))
//
//                TextField("", text: logMemo.memo, axis: .vertical)
//                    .lineLimit(1...)
//                    .font(.custom(("AppleSDGofhicNeo"), size: 13))
//                    .lineSpacing(6)
//                    .onTapGesture {
//                        isFocused = true
//                    }
//            }
//            .padding(.vertical, 8)
//            .padding(.trailing, 20)
//            .padding(.horizontal, 10)
//        }
//
//    }
    
    
    //사견 더미데이터
    var commentCell: some View {
        
        ForEach($commentCellModel) { $model in
            HStack(alignment: .top) {
                Image(systemName: "pencil.line")
                    .frame(width: 3, height: 3)
                    .opacity(0.7)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                
                TextField("", text: $model.comment)
                    .font(.custom(("AppleSDGofhicNeo"), size: 13))
                    .opacity(0.7)
                    .lineSpacing(6)
                    .onTapGesture {
                        islogMemoTextFieldHidden = true
                        
                    }
            }
            .padding(.trailing, 20)
            .padding(.horizontal,10)
            .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    var menuItems: some View {
        Button {
//            isShowingModal = true
        } label: {
            Label {
                Text("고정하기")
            } icon: {
                Image(systemName: "pin")
            }
        }
        
        Button {
//            isShowingModal = true
        } label: {
            Label {
                Text("메모 잠그기")
            } icon: {
                Image(systemName: "lock")
            }
        }
        
        Button {
//            isShowingModal = true
        } label: {
            Label {
                Text("사건 재분류하기")
            } icon: {
                Image(systemName: "lock")
            }
        }
    }
    
    var logMemoTextField: some View {
        TextField("단서를 추가하세요", text: $newnote, axis: .vertical)
            .focused($isFocused)
            .lineLimit(4)
            .font(.custom(("AppleSDGofhicNeo"),
                          size: 15))
            .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 70))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.gray)
            )
            .padding(.horizontal)
            .padding(.vertical, 10)
            .onTapGesture {
            }
            .opacity(islogMemoTextFieldHidden ? 0 : 1)
    }
    
    @ViewBuilder
    var logMemoTextFieldButtons: some View {
        HStack {
            Button {
                isButtonToggled.toggle()
            } label: {
                if isButtonToggled {
                    
                    Image("writebt")
                        .padding(.leading, 23)
                        .scaleEffect(0.9)
                } else {
                    Image("writebtwhite")
                        .padding(.leading, 23)
                        .scaleEffect(0.9)
                }
            }
            
            Spacer()
            
            Button {
                if isButtonToggled {
                    commentCellModel.append(CommentCellModel(id: UUID(), comment: newnote))
                    newnote = ""
                } else {
                    tempCellModel.append(TempCellModel(id: UUID(), time: "12:34", memo: newnote))
                    newnote = ""
                }
    
            } label: {
                if isButtonToggled {
                    Text("사견보내기")
                        .foregroundColor(.black)
                        .font(.custom(("AppleSDGofhicNeo"), size: 16))
                } else {
                    Text("메모보내기")
                        .foregroundColor(.black)
                        .font(.custom(("AppleSDGofhicNeo"), size: 16))
                }
            }
            .padding(.trailing, 35)
        }
        .opacity(islogMemoTextFieldHidden ? 0 : 1)
    }
    
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. dd"
        return dateFormatter.string(from: date)
    }
    
}


struct FlippedUpsideDown: ViewModifier {
   func body(content: Content) -> some View {
    content
           .rotationEffect(.degrees(.pi))
          .scaleEffect(x: -1, y: 1, anchor: .center)
   }
}

// 다른영역 터치하면 키보드 내려가기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func flippedUpsideDown() -> some View{
        withAnimation {
            self.modifier(FlippedUpsideDown())
        }
    }
}

// 날짜 적히는 칸(날짜 데이터 받아와야함...)



//@available(iOS 16.0, *)
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempDetailView()
//    }
//}
