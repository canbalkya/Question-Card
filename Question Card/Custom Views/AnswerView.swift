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
    
    private let widthConstant: CGFloat = 1.4
    private let heightConstant: CGFloat = 13
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width / widthConstant, height: UIScreen.main.bounds.height / heightConstant)
                .foregroundColor(color)
                .animation(.default)
            
            Text(text)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width / (widthConstant + 0.05), height: UIScreen.main.bounds.height / heightConstant)
        }
    }
}
