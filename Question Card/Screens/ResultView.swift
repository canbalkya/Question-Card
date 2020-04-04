//
//  ResultView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var trueCount: Int
    var falseCount: Int
    
    @State private var trueHeight = 0
    @State private var falseHeight = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("You are amazing!")
                .font(.largeTitle)
            
            Spacer()
                .frame(minHeight: 50, maxHeight: 150)
            
            HStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.green)
                        .frame(width: CGFloat((280 * trueCount) / (trueCount + falseCount)), height: 40)
                    
                    Text(String(trueCount))
                        .foregroundColor(.white)
                        .padding(.leading, CGFloat((280 * trueCount) / (trueCount + falseCount)) - 24)
                }
                
                Text("true")
            }.animation(.spring())
            
            HStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.red)
                        .frame(width: CGFloat((280 * falseCount) / (trueCount + falseCount)), height: 40)
                    
                    Text(String(falseCount))
                        .foregroundColor(.white)
                        .padding(.leading, CGFloat((280 * falseCount) / (trueCount + falseCount)) - 24)
                }
                
                Text("false")
            }.animation(.spring())
            
            Spacer()
                .frame(minHeight: 50, maxHeight: 150)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    Rectangle()
                    .cornerRadius(16)
                        .foregroundColor(Color.cardGray)
                        .frame(width: 270, height: 60)
                    
                    Text("Return")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(trueCount: 6, falseCount: 7)
    }
}
