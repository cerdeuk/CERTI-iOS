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
    
    //MARK: - Properties
    
    let target: EditTarget
    
    //MARK: - Main Body
    
    var body: some View {
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
        .sheet(item: $viewModel.editingExpectedItem) { item in
            EditExpectedCertificationModal(
                viewModel: viewModel,
                item: item
            )
            .presentationDetents([.height(663)])
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
                    viewModel.deleteExpectedCertificate(id: item.id)
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
                    print("취득 완료 수정: \(item.id)")
                    // TODO: 수정 화면 이동 로직
                }, onDelete: {
                    viewModel.deleteCompletedCertificate(id: item.id)
                })
            )
        }
    }
}

#Preview {
    let vm = MyPageViewModel()
    return EditCertificateView(viewModel: vm, target: .expected)
}
