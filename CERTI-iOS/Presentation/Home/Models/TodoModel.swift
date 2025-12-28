//
//  TodoModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 12/23/25.
//

import SwiftUI

struct TodoModel: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TodosModel: Identifiable {
    var id = UUID().uuidString
    var todo: [TodoModel]
    var todoDate: Date
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasks: [TodosModel] = [
    TodosModel(todo: [TodoModel(title: "어쩌구 자격증"), TodoModel(title: "정처기 시험")], todoDate: getSampleDate(offset:1)),
    TodosModel(todo: [TodoModel(title: "저쩌구 자격증")], todoDate: getSampleDate(offset:-3)),
]

