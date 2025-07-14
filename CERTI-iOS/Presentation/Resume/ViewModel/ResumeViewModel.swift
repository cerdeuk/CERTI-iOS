//
//  ResumeViewModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/14/25.
//

import Foundation

final class ResumeViewModel: ObservableObject {
    @Published var myCareer: [ResumeModel] = ResumeModel.myCareerDummy()
    
}
