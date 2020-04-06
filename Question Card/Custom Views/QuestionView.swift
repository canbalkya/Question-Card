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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 170)
                .foregroundColor(Color.cardGray)
            
            Text(text)
                .font(.system(size: 30))
                .foregroundColor(.white)
        }
    }
}
