//
//  QuesitonView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

extension Color {
    static let cardGray = Color(red: 55 / 255, green: 55 / 255, blue: 55 / 255)
    static let answerGray = Color(red: 91 / 255, green: 91 / 255, blue: 91 / 255)
}

struct CardView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 170)
                .foregroundColor(Color.cardGray)
            
            Text(text)
                .font(.system(size: 35))
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct AnswerView: View {
    let text: String
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 270, height: 60)
                .foregroundColor(color)
            
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
    @State private var yAmount: CGFloat = 0
    @State private var opacityAmount = 1.0
    @State private var chosenAnswer = 0
    
    var body: some View {
        VStack {
            AnswerView(text: String(row.answers), color: chosenAnswer == 1 ? Color.red : Color.answerGray)
            AnswerView(text: String(row.falseAnswers[0]), color: chosenAnswer == 2 ? Color.red : Color.answerGray)

            CardView(text: self.row.questions)
                .opacity(opacityAmount)
                .offset(dragAmount)
                .gesture(DragGesture().onChanged {
                    self.dragAmount = $0.translation
                    self.opacityAmount = 0.4
                    self.yAmount = $0.translation.height
                    
                    switch self.yAmount {
                    case -300 ... -200:
                        self.chosenAnswer = 1
                    case -200 ... -100:
                        self.chosenAnswer = 2
                    case 100...200:
                        self.chosenAnswer = 3
                    case 200...300:
                        self.chosenAnswer = 4
                    default:
                        self.chosenAnswer = 0
                    }
                }.onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                        self.opacityAmount = 1.0
                    }
                })

            AnswerView(text: String(row.falseAnswers[1]), color: chosenAnswer == 3 ? Color.red : Color.answerGray)
            AnswerView(text: String(row.falseAnswers[2]), color: chosenAnswer == 4 ? Color.red : Color.answerGray)
        }
        .navigationBarTitle(Text(row.title), displayMode: .inline)
    }
}

struct QuesitonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(row: Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: "What is 2 + 2", answers: 4, falseAnswers: [2, 1, 3]))
    }
}
