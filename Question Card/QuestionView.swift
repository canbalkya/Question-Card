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
                .animation(.default)
            
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
    @State private var opacityAmount = 1.0
    @State private var chosenAnswer = 0
    @State private var isGiveUp = false
    
    var body: some View {
        VStack {
            AnswerView(text: String(row.answers), color: chosenAnswer == 1 ? Color.cardGray : Color.answerGray)
            AnswerView(text: String(row.falseAnswers[0]), color: chosenAnswer == 2 ? Color.cardGray : Color.answerGray)

            CardView(text: self.row.questions)
                .opacity(opacityAmount)
                .offset(dragAmount)
                .gesture(DragGesture().onChanged {
                    self.dragAmount = $0.translation
                    self.opacityAmount = 0.4
                    
                    switch $0.translation.height {
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
                    
                    if ($0.translation.width > 150 || $0.translation.width < -150) && ($0.translation.height > -100 && $0.translation.height < 100) {
                        self.isGiveUp = true
                    }
                }.onEnded { view in
                    if self.isGiveUp {
                        withAnimation(.spring()) {
                            self.dragAmount = CGSize(width: view.translation.width > 150 ? 300 : -300, height: 0)
                            self.opacityAmount = 0.0
                        }
                    } else {
                        withAnimation(.spring()) {
                            self.dragAmount = CGSize.zero
                            self.opacityAmount = 1.0
                        }
                    }
                })
                .padding()

            AnswerView(text: String(row.falseAnswers[1]), color: chosenAnswer == 3 ? Color.cardGray : Color.answerGray)
            AnswerView(text: String(row.falseAnswers[2]), color: chosenAnswer == 4 ? Color.cardGray : Color.answerGray)
        }
        .navigationBarTitle(Text(row.title), displayMode: .inline)
    }
}

struct QuesitonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(row: Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: "What is 2 + 2", answers: 4, falseAnswers: [2, 1, 3]))
    }
}
