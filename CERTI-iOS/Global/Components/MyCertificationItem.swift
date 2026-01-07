//
//  MyCertificationItem.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/23/25.
//

import SwiftUI

struct MyCertificationItem: View {
    
    enum CertificationType {
        case completed(date: String, score: String?)
        case expected(location: String, time: String)
        
        var text: String {
            switch self {
            case .completed: return "취득 완료"
            case .expected: return "취득 예정"
            }
        }
        
        var color: Color {
            switch self {
            case .completed: return .mainblue
            case .expected: return .purpleblue
            }
        }
    }
    
    enum EditType {
        case viewOnly                                           // 수정, 삭제 ㄴㄴ
        case editable(onEdit: () -> Void, onDelete: () -> Void) // 수정, 삭제 ㅇㅇ
    }
    
    
    // MARK: - Properties
    
    let type: CertificationType
    let title: String
    let category: String
    let description: String
    let actionConfig: EditType
    
    
    // MARK: - Main Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            topBadge
                .padding(.bottom, 8)
            
            titleSection
                .padding(.bottom, 4)
            
            Text(description)
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale500)
                .frame(height: 18)
                .padding(.bottom, 12)
            
            infoSection
            
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.lightpurple, lineWidth: 1)
        )
    }
}


// MARK: - Subviews

extension MyCertificationItem {
    @ViewBuilder
    private var topBadge: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                
                Text(type.text)
                    .applyCertiFont(.caption_semibold_10)
            }
            .foregroundStyle(.white)
            .padding(6)
            .background(type.color)
            .clipShape(Capsule())
            
            Spacer()
            
            switch actionConfig {
            case .viewOnly:
                EmptyView()
            case .editable(let onEdit, let onDelete):
                HStack(alignment: .center, spacing: 12) {
                    actionButton(title: "수정", action: onEdit)
                    actionButton(title: "삭제", action: onDelete)
                }
            }
        }
    }
    
    @ViewBuilder
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .applyCertiFont(.sub_semibold_20)
            
            Text(category)
                .applyCertiFont(.caption_regular_12)
        }
        .foregroundStyle(.black)
        .frame(height: 26)
    }
    
    @ViewBuilder
    private var infoSection: some View {
        HStack(alignment: .center, spacing: 8) {
            switch type {
            case .expected(let location, let time):
                // [취득 예정] 장소 + 시간
                infoItem(icon: .iconPlacemark16, text: location)
                infoItem(icon: .iconTime16, text: time)
                
            case .completed(let date, let score):
                // [취득 완료] 날짜 + 점수
                infoItem(icon: .iconDate16, text: date)
                infoItem(icon: .iconLevel16, text: score ?? "취득 점수 -")
            }
        }
    }
    
    @ViewBuilder
    private func infoItem(icon: UIImage, text: String) -> some View {
        HStack(spacing: 4) {
            Image(uiImage: icon)
                .foregroundStyle(.grayscale300)
            
            Text(text)
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(text == "취득 점수 -" ? .grayscale200 : .black)
        }
    }
    
    @ViewBuilder
    private func actionButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale600)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(.white)
                .overlay(
                    Capsule()
                        .stroke(.grayscale300, lineWidth: 1)
                )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        
        // case 1: 취득 예정, 버튼 없음
        MyCertificationItem(
            type: .expected(location: "고양시", time: "09:00"),
            title: "정보처리기사",
            category: "국가기술자격",
            description: "소프트웨어 개발 관련 자격증...",
            actionConfig: .viewOnly
        )
        
        // case 2: 취득 예정, 버튼 있음
        MyCertificationItem(
            type: .expected(location: "서울시", time: "14:00"),
            title: "정보보안기사",
            category: "국가기술자격",
            description: "보안 관련 자격증...",
            actionConfig: .editable(onEdit: {
                print("수정")
            }, onDelete: {
                print("삭제")
            })
        )
        
        // case 3: 취득 완료, 버튼 없음, 점수 있음
        MyCertificationItem(
            type: .completed(date: "2023. 11. 23", score: "IM3"),
            title: "OPIC",
            category: "어학",
            description: "영어 말하기 시험...",
            actionConfig: .viewOnly
        )
        
        // case 4: 취득 완료, 버튼 있음, 점수 없음
        MyCertificationItem(
            type: .completed(date: "2023. 11. 23", score: nil),
            title: "OPIC",
            category: "어학",
            description: "영어 말하기 시험...",
            actionConfig: .editable(onEdit: {
                print("수정")
            }, onDelete: {
                print("삭제")
            })
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
