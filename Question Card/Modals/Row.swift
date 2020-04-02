//
//  Row.swift
//  Question Card
//
//  Created by Can Balkaya on 4/3/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import Foundation

struct Row: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    
    let questions: [String]
    let answers: [[Int]]
    let trueAnswersCount: [Int]
}
