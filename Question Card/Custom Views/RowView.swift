//
//  RowView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/3/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct RowView: View {
    let title: String
    let description: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 340, height: 100)
                .foregroundColor(.answerGray)
                .opacity(0.8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 25))
                    .bold()
                    .lineLimit(3)
                Text(description)
                    .font(.system(size: 12))
                    .opacity(0.8)
                
                Spacer()
                    .frame(height: 15)
            }
            .padding([.leading, .trailing])
            .foregroundColor(.white)
        }
        .padding(.top)
    }
}
