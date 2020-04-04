//
//  CreateView.swift
//  Question Card
//
//  Created by Can Balkaya on 4/4/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var question = ""
    @State private var answers = ["", "", "", ""]
    @State private var trueAnswer = "First"
    @State private var questions = Array(1...1)
    
    static let trueAnswers = ["First", "Second", "Third", "Fourth"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                ForEach(questions, id: \.self) { number in
                    Section(header: Text("\(number). Question")) {
                        TextField("Question", text: self.$question)

                        TextField("Answer", text: self.$answers[0])
                        TextField("Answer", text: self.$answers[1])
                        TextField("Answer", text: self.$answers[2])
                        TextField("Answer", text: self.$answers[3])
                        
                        Picker("True Answer", selection: self.$trueAnswer) {
                            ForEach(Self.trueAnswers, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        self.questions.append(self.questions.last! + 1)
                    }) {
                        Text("Add new question")
                    }
                }
                    
                Section {
                    Button(action: {

                    }) {
                        Text("Create")
                    }
                }
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
