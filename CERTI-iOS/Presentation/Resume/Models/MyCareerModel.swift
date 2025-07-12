//
//  MyCareerModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct MyCareerModel: Identifiable {
    var id: UUID = UUID()
    
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var discription: String
}

extension MyCareerModel {
    static func dummy() -> [MyCareerModel] {
        return [ MyCareerModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", discription: "트렌드 리서치 및 소재 조사ㅇ"),
                 MyCareerModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", discription: "트렌드 리서치 및 소재 조사ㅇ"),
                 MyCareerModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", discription: "트렌드 리서치 및 소재 조사ㅇ"),
                 MyCareerModel(startAt: "2021.11", endAt: "2022.01", name: "패션디자이너 인턴ㅇ", place: "서티그룹ㅇㅇㅇㅇㅇㅇ", discription: "트렌드 리서치 및 소재 조사ㅇ"),
        ]
    }
}
