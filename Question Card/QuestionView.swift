//
//  QuesitonView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 170)
                .foregroundColor(.init(red: 55 / 255, green: 55 / 255, blue: 55 / 255))
            
            Text(text)
                .font(.system(size: 35))
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct AnswerView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 270, height: 60)
                .foregroundColor(.init(red: 91 / 255, green: 91 / 255, blue: 91 / 255))
            
            Text(text)
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct QuestionView: View {
    let row: Row
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            AnswerView(text: String(row.answers))
            AnswerView(text: String(row.falseAnswers[0]))
            
            CardView(text: self.row.questions)
                .offset(dragAmount)
                .gesture(DragGesture().onChanged {
                    self.dragAmount = $0.translation
                }.onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                    }
                })
            
            AnswerView(text: String(row.falseAnswers[1]))
            AnswerView(text: String(row.falseAnswers[2]))
        }
        .navigationBarTitle(Text(row.title), displayMode: .inline)
    }
}

struct QuesitonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(row: Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: "What is 2 + 2", answers: 4, falseAnswers: [2, 1, 3]))
    }
}
