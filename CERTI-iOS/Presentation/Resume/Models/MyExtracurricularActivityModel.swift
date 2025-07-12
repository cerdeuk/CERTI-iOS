//
//  MyExtracurricularActivityModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct MyExtracurricularActivityModel: Identifiable {
    var id: UUID = UUID()
    
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var discription: String
}

extension MyExtracurricularActivityModel {
    static func dummy() -> [MyExtracurricularActivityModel] {
        return [ MyExtracurricularActivityModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", discription: "서비스 기획 및 아이디어 도출"),
                 MyExtracurricularActivityModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", discription: "서비스 기획 및 아이디어 도출"),
                 MyExtracurricularActivityModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", discription: "서비스 기획 및 아이디어 도출"),
                 MyExtracurricularActivityModel(startAt: "2021.11", endAt: "2022.01", name: "동아리 36기 기획", place: "SOPTㅇㅇㅇㅇㅇㅇ", discription: "서비스 기획 및 아이디어 도출"),
        ]
    }
}
