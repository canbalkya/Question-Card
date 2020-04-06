//
//  QuesitonView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct EducationView: View {
    let row: Row
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var dragAmount = CGSize.zero
    @State private var opacityAmount = 1.0
    @State private var chosenAnswer = 0
    @State private var isGiveUp = false
    @State private var isTrue = 0
    @State private var seconds = 0
    @State private var dragCount = 0
    @State private var questionNumber = 0
    @State private var isPresented = false
    @State private var isSelected = false
    @State private var trueCount = 0
    @State private var falseCount = 0
    @State private var trueLength: CGFloat = 115
    @State private var falseLength: CGFloat = 115
//    @State private var isStart = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.cardGray)
                        .frame(width: 40, height: 40)
                        .opacity(0.8)
                    
                    Text(String(trueCount + falseCount))
                        .foregroundColor(.white)
                }
                
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.green)
                        .frame(width: trueLength, height: 40)
                        .opacity(0.8)
                        .animation(.spring())
                    
                    Text(String(trueCount))
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.red)
                        .frame(width: falseLength, height: 40)
                        .opacity(0.8)
                        .animation(.spring())
                    
                    Text(String(falseCount))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
            }
            .padding(.top)
            
            Spacer()
            
            AnswerView(answer: row.answers[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber][0], color: getColor(answer: 1))
            AnswerView(answer: row.answers[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber][1], color: getColor(answer: 2))

            if !self.isGiveUp {
                QuestionView(question: self.row.questions[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber])
                    .opacity(opacityAmount)
                    .offset(dragCount != questionNumber ? .zero : dragAmount)
//                    .onReceive(timer, perform: { _ in
//                        if self.isDrag {
//                            if self.seconds < 2 {
//                                self.seconds += 1
//                            }
//
//                            if self.seconds == 2 {
//                                self.isStart = true
//                            }
//                        }
//                    })
                    .gesture(DragGesture().onChanged {
                        guard self.questionNumber < self.row.questions.count else { return }
                        
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
//                        guard self.questionNumber < self.row.questions.count else { return }
                        
                        if !self.isGiveUp {
                            withAnimation(.spring()) {
                                self.dragAmount = CGSize.zero
                                self.opacityAmount = 1.0
                            }
                        } else {
                            withAnimation(.spring()) {
                                self.dragAmount = CGSize(width: view.translation.width > 150 ? 300 : -300, height: 0)
                                self.opacityAmount = 0.0
                            }
                        }
                        
                        if self.chosenAnswer != 0 {
                            self.isTrue = 0
                            self.dragCount += 1
                            self.questionNumber += 1
                            self.isSelected = true
                            
                            if self.row.questions[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber - 1].answerCount == self.chosenAnswer - 1 {
                                self.isTrue = 1
                                self.trueCount += 1
                                self.trueLength = CGFloat((self.trueCount * 115) / (self.trueCount + self.falseCount))
                                self.falseLength = CGFloat((self.falseCount * 115) / (self.trueCount + self.falseCount))
                            } else {
                                self.isTrue = 2
                                self.falseCount += 1
                                self.trueLength = CGFloat((self.trueCount * 115) / (self.trueCount + self.falseCount))
                                self.falseLength = CGFloat((self.falseCount * 115) / (self.trueCount + self.falseCount))
                            }
                        }
                        
                        if self.questionNumber == self.row.questions.count {
                            self.isPresented = true
                        }
                        
                        if self.isGiveUp {
                            self.dragCount += 1
                            self.isPresented = true
                        }
                    })
                    .padding()
                }

                AnswerView(answer: row.answers[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber][2], color: getColor(answer: 3))
                AnswerView(answer: row.answers[self.questionNumber == self.row.questions.count ? self.row.questions.count - 1 : self.questionNumber][3], color: getColor(answer: 4))
            
                Spacer()
            }
            .navigationBarTitle(Text(row.title), displayMode: .inline)
            .animation(.default)
            .sheet(isPresented: $isPresented, content: {
                ResultView(trueCount: self.trueCount, falseCount: self.falseCount)
            }
        )
    }
    
    public func getColor(answer: Int) -> Color {
        if chosenAnswer == answer {
            switch isTrue {
            case 0:
                return Color.cardGray
            case 1:
                return /* self.isStart ? */ Color.green /* : Color.cardGray */
            default:
                return /* self.isStart ? */ Color.red /* : Color.cardGray */
            }
        }
        
        print(questionNumber)
        
        if /* self.isStart && */ self.isSelected && self.row.questions[questionNumber - 1].answerCount == answer - 1 /* || self.isGiveUp && answer - 1 == self.row.trueAnswersCount */ {
            return Color.green
        }
        
        return Color.answerGray
    }
}

struct QuesitonView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView(row: Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: [Question(text: "What is 2 + 2?", answerCount: 0), Question(text: "What is 2 + 2?", answerCount: 0)], answers: [[Answer(text: "4"), Answer(text: "3"), Answer(text: "2"), Answer(text: "1")], [Answer(text: "4"), Answer(text: "3"), Answer(text: "2"), Answer(text: "1")]]))
    }
}
