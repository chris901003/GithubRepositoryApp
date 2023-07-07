//
//  AllRepositoryView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

struct AllRepositoryView: View {
    
    @ObservedObject private var sharedInfo: SharedInfo
    @State private var editMode: EditMode = .inactive
    @State private var newRepoName: String = ""
    @State private var isAdding: Bool = false
    @State private var listSelection = Set<String>()
    @State private var repoDetailSelecte: RepositoryModel? = .mock()
    @State private var sheetViewSize: CGFloat = SheetSizePreference.defaultValue
    
    // Private Variable
    private var vm: AllRepositoryViewModel
    
    init(sharedInfo: SharedInfo) {
        self._sharedInfo = .init(wrappedValue: sharedInfo)
        self.vm = .init(sharedInfo: sharedInfo)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                addNewRepoView
                HStack {
                    Spacer()
                    Group {
                        sortButton
                        editModeChangeButton
                    }
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                }
                List(selection: $listSelection) {
                    ForEach(sharedInfo.allRepo) { repoInfo in
                        repoInfoView(repoInfo: repoInfo)
                            .onTapGesture { repoDetailSelecte = repoInfo }
                    }
                }
                .environment(\.editMode, .constant(editMode == .active ? .active : .inactive))
                .animation(Animation.spring(), value: editMode)
                .listStyle(.plain)
                
                VStack {
                    if editMode == .active { removeRepoButton }
                }
                .animation(.spring(dampingFraction: 0.5), value: editMode)
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    titleView
                }
            }
            .sheet(isPresented: .constant(isShowRepoDetailSheet)) {
                RepositoryDetailView(sharedInfo: sharedInfo, repoInfo: $repoDetailSelecte)
                    .onPreferenceChange(SheetSizePreference.self) { sheetViewSize = $0 }
                    .presentationDetents([.height(sheetViewSize)])
            }
        }
    }
}

extension AllRepositoryView {
    struct SheetSizePreference: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

private extension AllRepositoryView {
    func repoInfoView(repoInfo: RepositoryModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(SF: .person)
                        .resizeFitColor(color: .green)
                        .frame(width: 20, height: 20)
                    Text("使用者: \(repoInfo.userName ?? "匿名")")
                        .font(.headline)
                }
                HStack {
                    Image(SF: .folder)
                        .resizeFitColor(color: .orange)
                        .frame(width: 20, height: 20)
                    Text("倉庫: \(repoInfo.repoName ?? "倉庫")")
                        .font(.headline)
                }
            }
            Spacer()
            Image(SF: repoInfo.isFavoriate ? .fillStar : .emptyStar)
                .resizeFitColor(color: .yellow)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    Task { await vm.changeFavoriateState(repoInfo: repoInfo) }
                }
        }
    }
}

private extension AllRepositoryView {
    var titleView: some View {
        HStack {
            Image(SF: .box)
                .resizeFitColor()
                .frame(width: 45, height: 45)
            Text("所有倉庫")
                .fontSizeWithBold(.title)
        }
    }
    
    var addNewRepoView: some View {
        HStack {
            TextField("Ex: chris901003/SwiftLearning", text: $newRepoName)
                .font(.headline)
                .padding(8)
                .roundRectangleBackground(cornerRadius: 5, color: .secondary, linewidth: 2)
                .padding(.horizontal)
            if isAdding {
                ProgressView()
                    .frame(width: 25, height: 25)
            } else {
                Button {
                    Task {
                        isAdding = true
                        await vm.addNewRepo(newRepoName)
                        newRepoName = ""
                        isAdding = false
                    }
                } label: {
                    Image(SF: .plus)
                        .resizeFitColor(color: .green)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding(.top)
    }
    
    var sortButton: some View {
        Button {
            Task { await vm.sortAllRepo() }
        } label: {
            HStack {
                VStack(spacing: 2) {
                    Image(SF: .triangleUp)
                        .resizeFitColor(color: .blue)
                        .frame(width: 8, height: 8)
                    Image(SF: .triangleDown)
                        .resizeFitColor(color: .blue)
                        .frame(width: 8, height: 8)
                }
                Text("排序")
                    .fontColor(.headline, .blue)
            }
        }
    }
    
    var editModeChangeButton: some View {
        Button(action: changeEditMode) {
            HStack {
                Image(SF: .edit)
                    .resizeFitColor(color: .blue)
                    .frame(width: 20, height: 20)
                Text(editMode == .active ? "結束" : "編輯")
                    .fontColor(.headline, .blue)
            }
        }
    }
    
    var removeRepoButton: some View {
        Button {
            Task {
                await vm.removeSelectedRepo(selection: listSelection)
                listSelection.removeAll()
            }
            editMode = .inactive
        } label: {
            Text("移除所有選項")
                .fontColorBold(.title2, .white)
                .twoWayPadding(types: [.vertical, .horizontal], sizes: [8, 0])
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.blue)
                )
                .padding(.bottom, 8)
        }
        .transition(AnyTransition.scale)
    }
}

private extension AllRepositoryView {
    /// 更換當前模式
    func changeEditMode() {
        editMode = editModeStatus
    }
}

private extension AllRepositoryView {
    /// 更換當前模式
    var editModeStatus: EditMode {
        editMode == .active ? .inactive : .active
    }
    
    /// 是否要開啟詳細資訊表單
    var isShowRepoDetailSheet: Bool {
        repoDetailSelecte == nil ? false : true
    }
}

struct AllRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        AllRepositoryView(sharedInfo: SharedInfo.mockDataInit())
    }
}
