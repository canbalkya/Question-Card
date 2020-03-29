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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var dragAmount = CGSize.zero
    @State private var opacityAmount = 1.0
    @State private var chosenAnswer = 0
    @State private var isGiveUp = false
    @State private var isTrue = 0
    @State private var seconds: Int = 0
    @State private var isDrag = false
    @State private var isStart = false
    
    var body: some View {
        let answers: [AnswerView] = [AnswerView(text: String(row.answers[0]), color: getColor(answer: 1)), AnswerView(text: String(row.answers[1]), color: getColor(answer: 2)), AnswerView(text: String(row.answers[2]), color: getColor(answer: 3)), AnswerView(text: String(row.answers[3]), color: getColor(answer: 4))]
        
        return VStack {
            answers[0]
            answers[1]

            if !self.isGiveUp {
                CardView(text: self.row.questions)
                    .opacity(opacityAmount)
                    .offset(isDrag ? .zero : dragAmount)
                    .onReceive(timer, perform: { _ in
                        if self.isDrag {
                            if self.seconds < 2 {
                                self.seconds += 1
                            }

                            if self.seconds == 2 {
                                self.isStart = true
                            }
                        }
                    })
                    .gesture(DragGesture().onChanged {
                        if self.isDrag == false {
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
                        }
                    }.onEnded { view in
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
                            self.isDrag = true
                            
                            if self.row.trueAnswersCount == self.chosenAnswer - 1 {
                                self.isTrue = 1
                            } else {
                                self.isTrue = 2
                            }
                        }
                        
                        if self.isGiveUp {
                            self.isDrag = true
                        }
                    })
                    .padding()
                }

                answers[2]
                answers[3]
            }
            .navigationBarTitle(Text(row.title), displayMode: .inline)
            .animation(.default)
    }
    
    func getColor(answer: Int) -> Color {
        if chosenAnswer == answer {
            switch isTrue {
            case 0:
                return Color.cardGray
            case 1:
                return self.isStart ? Color.green : Color.cardGray
            default:
                return self.isStart ? Color.red : Color.cardGray
            }
        }
        
        if self.isStart && answer - 1 == self.row.trueAnswersCount || self.isGiveUp && answer - 1 == self.row.trueAnswersCount {
            return Color.green
        }
        
        return Color.answerGray
    }
}

struct QuesitonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(row: Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: "What is 2 + 2?", answers: [4, 2, 1, 3], trueAnswersCount: 0))
    }
}
