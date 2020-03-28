//
//  HomeView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct Row: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    
    let questions: String
    let answers: [Int]
    let trueAnswersCount: Int
}

struct RowView: View {
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 340, height: 100)
                .foregroundColor(.init(red: 68 / 255, green: 68 / 255, blue: 68 / 255))
                .opacity(0.8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 25))
                    .bold()
                    .lineLimit(3)
                Text(description)
                    .font(.system(size: 12))
                    .opacity(0.8)
                
                Spacer()
                    .frame(height: 15)
            }
            .foregroundColor(.white)
        }
        .padding([.leading, .trailing, .top])
    }
}

struct HomeView: View {
    @State private var rows = [Row(title: "Basic Maths", description: "This section is for primary school students. Maybe first, second or third grades.", questions: "What is 2 + 2?", answers: [4, 2, 1, 3], trueAnswersCount: 0)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(rows, id: \.id) { row in
                        NavigationLink(destination: QuestionView(row: row)) {
                            RowView(title: row.title, description: row.description)
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
