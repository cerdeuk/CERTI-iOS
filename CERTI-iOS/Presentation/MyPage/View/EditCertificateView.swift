//
//  EditCertificateView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct EditCertificateView: View {
    public enum EditTarget {
        case expected
        case completed
    }
    
    //MARK: - Property Wrappers
    
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var showDeleteAlert: Bool = false
    @State private var deleteTargetID: UUID? = nil
    
    //MARK: - Properties
    
    let target: EditTarget
    
    //MARK: - Main Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                MyPageHeader(style: .normal, title: "자격증 편집") {
                    nil
                } backButtonAction: {
                    viewModel.myPageViewRoutePop()
                }
                .padding(.bottom, 8)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        switch target {
                        case .expected:
                            expectedList
                        case .completed:
                            completedList
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .background(.white)
            
            if showDeleteAlert {
                CertiDeleteAlertView(
                    onConfirm: {
                        //TODO: - 비동기처리
                        if let id = deleteTargetID {
                            switch target {
                            case .expected:
                                viewModel.deleteExpectedCertificate(id: id)
                            case .completed:
                                viewModel.deleteCompletedCertificate(id: id)
                            }
                        }
                        deleteTargetID = nil
                        showDeleteAlert = false
                    },
                    onCancel: {
                        deleteTargetID = nil
                        showDeleteAlert = false
                    }
                )
                .zIndex(2)
            }
        }
        .sheet(item: $viewModel.editingExpectedItem) { item in
            EditExpectedCertificationModal(
                viewModel: viewModel,
                item: item
            )
            .presentationDetents([.height(663)])
            .presentationCornerRadius(40)
            .presentationDragIndicator(.visible)
        }
        .sheet(item: $viewModel.editingCompletedItem) { item in
            EditCompletedCertificationModal(
                viewModel: viewModel,
                item: item
            )
            .presentationDetents([.height(482)])
            .presentationCornerRadius(40)
            .presentationDragIndicator(.visible)
        }
    }
}


// MARK: - SubViews

private extension EditCertificateView {
    var expectedList: some View {
        ForEach(viewModel.expectedList) { item in
            MyCertificationItem(
                type: .expected(
                    location: item.city,
                    time: item.formattedTime
                ),
                title: item.certificationName,
                category: item.agencyName,
                description: item.description,
                actionConfig: .editable(onEdit: {
                    viewModel.editingExpectedItem = item
                }, onDelete: {
                    deleteTargetID = item.id
                    showDeleteAlert = true
                })
            )
        }
    }
    
    var completedList: some View {
        ForEach(viewModel.completedList) { item in
            MyCertificationItem(
                type: .completed(
                    date: item.formattedDate,
                    score: item.grade
                ),
                title: item.name,
                category: item.categoryText,
                description: item.description,
                
                actionConfig: .editable(onEdit: {
                    viewModel.editingCompletedItem = item
                }, onDelete: {
                    deleteTargetID = item.id
                    showDeleteAlert = true
                })
            )
        }
    }
}

#Preview {
    let vm = MyPageViewModel()
    return EditCertificateView(viewModel: vm, target: .completed)
}
