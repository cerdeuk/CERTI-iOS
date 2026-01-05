//
//  DropDownMenu.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 11/17/25.
//
import SwiftUI

struct DropdownMenu: View {
    @State private var isOpen = false
    
    @Binding var selectedPlace: String?
    
    let options: [String]
    let menuPlaceholder: String
    
    var body: some View {
        Button {
            withAnimation {
                isOpen.toggle()
            }
        } label: {
            HStack {
                Text(selectedPlace ?? menuPlaceholder)
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundColor(selectedPlace == nil ? .grayscale300 : .grayscale600)
                    .padding(.leading, 12)
                    .padding(.vertical, 11)
                
                Spacer()
                
                Image(.iconArrowdown24)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                    .padding(.vertical, 11)
            }
            .frame(width: 161, height: 40)
            .background(RoundedRectangle(cornerRadius: 4).stroke(.grayscale200))
        }
        .overlay(
            Group {
                if isOpen {
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(options, id: \.self) { item in
                            Button {
                                selectedPlace = item
                                withAnimation {
                                    isOpen = false
                                }
                            } label: {
                                Text(item)
                                    .applyCertiFont(.caption_semibold_12)
                                    .foregroundStyle(.grayscale600)
                                    .frame(height: 18)
                                    .padding(.vertical, 8)
                                    .padding(.leading, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(width: 161, height: 34)
                            .background(RoundedRectangle(cornerRadius: 1).stroke(.grayscale100))
                            .background(.white)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.grayscale100)
                    )
                    .offset(y: 40)
                }
            },
            alignment: .topLeading
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedPlace: String? = nil
        
        var body: some View {
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconCheck24)
                        .frame(width: 24, height: 24)
                    
                    Text("시험 장소")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                
                DropdownMenu(selectedPlace: $selectedPlace, options: ["서울", "경기", "인천", "강원", "충남", "충북"], menuPlaceholder: "시/도")
                    .zIndex(2)
                
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconCheck24)
                        .frame(width: 24, height: 24)
                    
                    Text("시험 시간")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundStyle(.grayscale600)
                        .frame(height: 22)
                }
                .zIndex(1)
            }
        }
    }
    return PreviewWrapper()
}
