//
//  CreateView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/4/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI
import CoreData

struct CreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var questions = ["", "", ""]
    @State private var answers = [["", "", "", ""], ["", "", "", ""], ["", "", "", ""]]
    @State private var trueAnswer = ["First", "First", "First"]
    @State private var showingAlert = false
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
    
    static let trueAnswers = ["First", "Second", "Third", "Fourth"]
    let count = (0...2)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                ForEach(count, id: \.self) { number in
                    Section(header: Text("\(number + 1). Question")) {
                        TextField("Question", text: self.$questions[number])

                        ForEach(0...3, id: \.self) { i in
                            TextField("Answer", text: self.$answers[number][i])
                        }
                        
                        Picker("True Answer", selection: self.$trueAnswer[number]) {
                            ForEach(Self.trueAnswers, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                    
                Section {
                    Button(action: {
                        if self.title == "" || self.description == "" {
                            self.showingAlert = true
                            return
                        }
                        
                        let card = Card(context: self.moc)
                        card.id = UUID()
                        card.title = self.title
                        card.des = self.description
                        card.index = Int16(self.cards.count)
                        
                        for i in self.count {
                            let question = Question(context: self.moc)
                            question.id = UUID()
                            question.text = self.questions[i]
                            question.firstAnswer = self.answers[i][0]
                            question.secondAnswer = self.answers[i][1]
                            question.thirdAnswer = self.answers[i][2]
                            question.fourthAnswer = self.answers[i][3]
                            question.trueAnswerCount = self.trueAnswer[i]
                            question.card = card.id
                        }
                        
                        do {
                            try self.moc.save()
                        } catch {
                            
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Create")
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Write title or description!"), message: Text("You have to write title and description for create new card."), dismissButton: .default(Text("Ok")))
            }
            .navigationBarTitle("Create a new row")
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
