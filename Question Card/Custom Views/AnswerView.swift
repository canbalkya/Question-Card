//
//  AnswerView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/3/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct AnswerView: View {
    let text: String
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 270, height: 60)
                .foregroundColor(color)
                .animation(.default)
            
            Text(text)
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.white)
        }
    }
}
