//
//  HomeView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @State private var isPresented = false
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
    @FetchRequest(entity: Question.entity(), sortDescriptors: []) var questions: FetchedResults<Question>
    
    var allQuestions: [Question] {
        var questions = [Question]()
        
        for i in 0...self.questions.count - 1 {
            let question = self.questions[i]
            questions.append(question)
        }
        
        return questions
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if cards.count > 0 {
                        ForEach(cards, id: \.id) { card in
                            NavigationLink(destination: EducationView(card: card, questions: self.allQuestions, count: self.cards.count)) {
                                RowView(title: card.title!, description: card.des!)
                            }
                        }
                    } else {
                        Text("It is empty.")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .padding(.top, 200)
                        
                        Image(systemName: "pause.circle.fill")
                            .font(.system(size: 50))
                    }
                }
                .onAppear {
                    print(self.cards.count)
                }
            }
            .navigationBarTitle("Question Card")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .font(.system(size: 23))
            })
            .sheet(isPresented: $isPresented, content: {
                CreateView()
                    .environment(\.managedObjectContext, self.moc)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
