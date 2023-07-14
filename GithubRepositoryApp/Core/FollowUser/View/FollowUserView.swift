//
//  FollowUserView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/11.
//

import SwiftUI

struct FollowUserView: View {
    
    @ObservedObject var sharedInfo: SharedInfo
    @State var newFollowUserName: String = ""
    @State var editMode: EditMode = .inactive
    @State var listSelection: Set<Int> = Set<Int>()
    @State var isShowHelper: Bool = false
    @State var sheet: FollowUserDetail.Sheet? = nil
    
    private let vm: FollowUserViewModel
    
    init(sharedInfo: SharedInfo) {
        self._sharedInfo = .init(wrappedValue: sharedInfo)
        self.vm = .init(sharedInfo: sharedInfo)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                addNewFollowUserView
                List($sharedInfo.allFollowUser, editActions: .all, selection: $listSelection) { $followUser in
                    followUserInfo(followUser: followUser)
                }
                .environment(\.editMode, $editMode)
                .animation(.linear, value: editMode)
                .listStyle(.plain)
            }
            .safeAreaInset(edge: .bottom) {
                removeSelectedUserButton
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    titleView
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    helperButton
                }
            }
            .overlay {
                helperSection
            }
            .sheet(item: $sheet) { $0 }
        }
    }
}

// MARK: Function View
private extension FollowUserView {
    func userInfoGridRowView(imageName: String, imageColor: Color, message: String) -> some View {
        GridRow {
            Image(imageName)
                .resizeFitColor(color: imageColor)
                .frame(width: 25, height: 25)
            Text(message)
                .font(.headline)
                .gridColumnAlignment(.leading)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
    
    func followUserInfo(followUser: UserFollowModel) -> some View {
        HStack {
            CacheAsyncImageView(url: followUser.photoLink)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing)
            
            Grid {
                userInfoGridRowView(imageName: "id", imageColor: .green, message: "帳號: \(followUser.user)")
                userInfoGridRowView(imageName: "name", imageColor: .blue, message: "名稱: \(followUser.name)")
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedUser(target: followUser)
        }
    }
}

private extension FollowUserView {
    /// 獲取點擊對象的詳細資料，並且開啟sheet
    func selectedUser(target: UserFollowModel) {
        Task {
            do {
                let followUserDetail = try await vm.fetchUserInfo(userInfo: target)
                sheet = .normal(followUserDetail)
            } catch {
                sheet = .noInternet
            }
        }
    }
}

// MARK: Computing View
private extension FollowUserView {
    var titleView: some View {
        HStack {
            Image(SF: .personTabItem)
                .resizeFitColor()
                .frame(width: 45, height: 45)
            Text("追蹤使用者")
                .fontSizeWithBold(.title)
        }
    }
    
    var helperButton: some View {
        Button {
            withAnimation { isShowHelper = true }
        } label: {
            Image(SF: .questionMark)
                .resizeFitColor()
                .frame(width: 20, height: 20)
        }
    }
    
    var addNewFollowUserView: some View {
        HStack(spacing: 16) {
            TextField("Ex: chris901003", text: $newFollowUserName)
                .autocorrectionDisabled(true)
                .twoWayPadding(types: [.horizontal, .vertical], sizes: [16, 8])
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.secondary, lineWidth: 2)
                )
            Button {
                Task {
                    await vm.addNewFollowUser(userName: newFollowUserName)
                    newFollowUserName = ""
                }
            } label: {
                Image(SF: .paperPlane)
                    .resizeFitColor(color: .blue)
                    .frame(width: 20, height: 20)
            }
            Button {
                editMode = changeEditMode
            } label: {
                Text(editMode == .active ? "結束" : "編輯")
                    .font(.headline)
                    .twoWayPadding(types: [.horizontal, .vertical], sizes: [15, 6])
                    .background(.ultraThinMaterial)
                    .cornerRadius(5)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    var helperSection: some View {
        ZStack {
            if isShowHelper {
                Color.white.opacity(0.01).tapDismissView(isShow: $isShowHelper)
                VStack {
                    HStack {
                        Image(SF: .questionMark)
                            .resizeFitColor(color: .pink)
                            .frame(width: 30, height: 30)
                        Text("幫助")
                            .fontSizeWithBold(.title3)
                    }
                    .foregroundColor(Color.pink)
                    Text("在此輸入的資料為下圖片匡選的位置")
                        .fontSizeWithBold(.callout)
                    Image("follow-user-help")
                        .resizeFitColor()
                        .padding(.horizontal, 36)
                    Text("若輸入錯誤將無法查詢到該使用者")
                        .fontColorBold(.callout, .secondary)
                }
                .overlay {
                    VStack {
                        Button {
                            withAnimation { isShowHelper = false }
                        } label: {
                            Image(SF: .xmark)
                                .resizeFitColor()
                                .frame(width: 20, height: 20)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .padding()
                .transition(.scale)
            }
        }
    }
    
    var removeSelectedUserButton: some View {
        Button {
            Task {
                vm.removeSelectedUser(selected: listSelection)
                withAnimation { editMode = .inactive }
            }
        } label: {
            Text("刪除所選使用者")
                .fontColorBold(.title2, .white)
                .frame(maxWidth: .infinity, maxHeight: 55)
                .background(RoundedRectangle(cornerRadius: 10))
                .twoWayPadding(types: [.horizontal, .bottom], sizes: [32, 10])
        }
        .opacity(editMode == .inactive ? 0 : 1)
        .animation(.linear, value: editMode)
    }
}

private extension FollowUserView {
    var changeEditMode: EditMode {
        editMode == .inactive ? .active : .inactive
    }
}
