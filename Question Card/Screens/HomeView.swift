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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if cards.count > 0 {
                        ForEach(cards, id: \.id) { card in
                            NavigationLink(destination: EducationView(card: card, questions: self.getQuestions(index: Int(card.index), card: card), count: 3)) {
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
    
    func getQuestions(index: Int, card: Card) -> [Question] {
        var currentQuestions = [Question]()
        
        for i in 0...questions.count - 1 {
            if questions[i].card == card.id {
                currentQuestions.append(questions[i])
            }
        }
        
        return currentQuestions.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
