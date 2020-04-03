//
//  CardView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/3/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 170)
                .foregroundColor(Color.cardGray)
            
            Text(question.text)
                .font(.system(size: 35))
                .bold()
                .foregroundColor(.white)
        }
    }
}
