//
//  HomeView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct HomeView: View {
//    @State private var rows = [Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: ["What is 2 + 2?", "What is 2 + 5?"], answers: [[4, 2, 1, 3], [1, 2, 3, 7]], trueAnswersCount: [0, 3])]
    @State private var rows = [Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: [Question(text: "What is 2 + 2?", answerCount: 0), Question(text: "What is 5 + 2?", answerCount: 0)], answers: [[Answer(text: "4"), Answer(text: "3"), Answer(text: "1"), Answer(text: "2")], [Answer(text: "7"), Answer(text: "1"), Answer(text: "10"), Answer(text: "12")]])]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(rows, id: \.id) { row in
                        NavigationLink(destination: EducationView(row: row)) {
//                            RowView(title: row.title, description: row.description)
                            RowView(row: row)
                        }
                    }
                }
            }
            .navigationBarTitle("Question Card")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
