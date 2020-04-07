//
//  CardView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/3/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    let text: String
    
    private let widthConstant: CGFloat = 1.2
    private let heightConstant: CGFloat = 4.2
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: UIScreen.main.bounds.width / widthConstant, height: UIScreen.main.bounds.height / heightConstant)
                .foregroundColor(Color.cardGray)
            
            Text(text)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width / (widthConstant + 0.05), height: UIScreen.main.bounds.height / heightConstant)
        }
    }
}
