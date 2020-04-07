//
//  QuesitonView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI
import CoreData

struct EducationView: View {
    @ObservedObject var card: Card
    var questions: [Question]
    
    @State private var dragAmount = CGSize.zero
    @State private var opacityAmount = 1.0
    @State private var chosenAnswer = 0
    @State private var isGiveUp = false
    @State private var isTrue = 0
    @State private var questionNumber = 0
    @State private var isPresented = false
    @State private var isSelected = false
    @State private var trueCount = 0
    @State private var falseCount = 0
    @State private var trueLength: CGFloat = 115
    @State private var falseLength: CGFloat = 115
    
    var count: Int
    var trueAnswerCount: Int {
        if self.questions[self.questionNumber].trueAnswerCount == "First" {
            return 1
        } else if self.questions[self.questionNumber].trueAnswerCount == "Second" {
            return 2
        } else if self.questions[self.questionNumber].trueAnswerCount == "Third" {
            return 3
        } else if self.questions[self.questionNumber].trueAnswerCount == "Fourth" {
            return 4
        }
        
        return 0
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color.cardGray)
                        .frame(width: 40, height: 40)
                        .opacity(0.8)
                    
                    Text(String(questionNumber + 1))
                        .foregroundColor(.white)
                }
                
                if (trueCount != 0 && trueCount + falseCount != 0) || (trueCount == 0 && trueCount + falseCount == 0) {
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
                }
                
                if (falseCount != 0 && trueCount + falseCount != 0) || (falseCount == 0 && trueCount + falseCount == 0) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(Color.red)
                            .frame(width: falseLength, height: 40)
                            .opacity(0.8)
                            .animation(.spring())
                    
                        Text(falseCount == 0 && trueCount + falseCount != 0 ? "" : String(falseCount))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                    }
                }
            }
            .padding(.top)
            
            Spacer()
            
            AnswerView(text: self.questions[self.questionNumber].firstAnswer!, color: getColor(answer: 1))
            AnswerView(text: self.questions[self.questionNumber].secondAnswer!, color: getColor(answer: 2))

            if !self.isGiveUp {
                QuestionView(text: self.questions[self.questionNumber == 3 ? 2 : self.questionNumber].text ?? "")
                    .opacity(opacityAmount)
                    .offset(self.isSelected ? .zero : dragAmount)
                    .gesture(DragGesture().onChanged {
                        guard !self.isSelected else { return }
                        
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
                            self.isSelected = true
                            
                            self.falseCount += 1
                            self.isTrue = 1
                            
                            self.trueLength = CGFloat((self.trueCount * 230) / (self.trueCount + self.falseCount))
                            self.falseLength = CGFloat((self.falseCount * 230) / (self.trueCount + self.falseCount))
                        }
                    }.onEnded { view in
                        guard !self.isSelected else { return }
                        
                        if !self.isGiveUp {
                            withAnimation(.spring()) {
                                self.dragAmount = CGSize.zero
                                self.opacityAmount = 1.0
                            }
                        } else {
                            withAnimation(.spring()) {
                                self.dragAmount = CGSize(width: view.translation.width > 150 ? 300 : -300, height: 0)
                                self.opacityAmount = 0.0
                                self.falseCount += 1
                            }
                        }
                        
                        if self.chosenAnswer != 0 {
                            self.isTrue = 0
                            self.isSelected = true
                            
                            if self.trueAnswerCount == self.chosenAnswer {
                                self.isTrue = 1
                                self.trueCount += 1
                                self.trueLength = CGFloat((self.trueCount * 230) / (self.trueCount + self.falseCount))
                                self.falseLength = CGFloat((self.falseCount * 230) / (self.trueCount + self.falseCount))
                            } else {
                                self.isTrue = 2
                                self.falseCount += 1
                                self.trueLength = CGFloat((self.trueCount * 230) / (self.trueCount + self.falseCount))
                                self.falseLength = CGFloat((self.falseCount * 230) / (self.trueCount + self.falseCount))
                            }
                        }
                    })
                    .padding()
                }

                AnswerView(text: self.questions[self.questionNumber].thirdAnswer!, color: getColor(answer: 3))
                AnswerView(text: self.questions[self.questionNumber].fourthAnswer!, color: getColor(answer: 4))
            
                Spacer()
            
                if self.isSelected {
                    Button(action: {
                        if self.questionNumber + 1 == self.count {
                            self.isPresented = true
                        } else {
                            self.chosenAnswer = 0
                            self.isTrue = 0
                            self.questionNumber += 1
                            self.isSelected = false
                            self.isGiveUp = false
                            self.opacityAmount = 1
                            self.dragAmount = .zero
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .frame(width: 200, height: 50)
                                .foregroundColor(.cardGray)
                            
                            Text(self.questionNumber + 1 == count ? "Done" : "Continue")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationBarTitle(Text(String(card.title!)), displayMode: .inline)
            .animation(.default)
            .sheet(isPresented: $isPresented, content: {
                ResultView(trueCount: self.trueCount, falseCount: self.falseCount)
            }
        )
    }
    
    func getColor(answer: Int) -> Color {
        if chosenAnswer == answer {
            switch isTrue {
            case 0:
                return Color.cardGray
            case 1:
                return Color.green
            default:
                return Color.red
            }
        }
        
        if (self.isSelected || self.isGiveUp) && trueAnswerCount == answer {
            return Color.green
        }
        
        return Color.answerGray
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
