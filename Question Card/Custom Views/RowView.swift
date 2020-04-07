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
    
    private let widthConstant: CGFloat = 1.1
    private let heightConstant: CGFloat = 8
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: UIScreen.main.bounds.width / widthConstant, height: UIScreen.main.bounds.height / heightConstant)
                .foregroundColor(.answerGray)
                .opacity(0.8)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 25))
                        .bold()
                        .lineLimit(3)
                    Text(description)
                        .font(.system(size: 12))
                        .opacity(0.8)
                }
                
                Spacer()
            }
            .padding([.leading, .trailing])
            .frame(width: UIScreen.main.bounds.width / widthConstant, height: UIScreen.main.bounds.height / heightConstant)
            .foregroundColor(.white)
        }
        .padding([.leading, .trailing, .top])
    }
}
