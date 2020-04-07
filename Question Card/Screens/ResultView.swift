//
//  ResultView.swift
//  Question Card
//
//  Created by Can Balkaya on 3/22/20.
//  Copyright © 2020 Can Balkaya. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var startingAnimation = false
    
    var trueCount: Int
    var falseCount: Int
    
    private let heightConstant: CGFloat = 20
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.main.bounds.height / heightConstant)
            
            Text(getTitleText())
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .padding()
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    ZStack(alignment: .trailing) {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(Color.green)
                            .frame(width: getResult(count: trueCount), height: 45)
                        
                        Text(String(trueCount))
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                    
                    Text("true")
                        .font(.system(size: 24))
                }
                
                HStack {
                    ZStack(alignment: .trailing) {
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(Color.red)
                            .frame(width: getResult(count: falseCount), height: 45)
                        
                        Text(String(falseCount))
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                    
                    Text("false")
                        .font(.system(size: 24))
                    
                    Spacer()
                }
            }
            .padding(.leading, -10)
            .animation(.spring())
            
            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    Rectangle()
                    .cornerRadius(16)
                        .foregroundColor(Color.cardGray)
                        .frame(width: 270, height: 60)
                    
                    Text("Return")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
        }
        .onAppear {
            self.startingAnimation = true
        }
    }
    
    func getTitleText() -> String {
        switch trueCount - falseCount {
        case -falseCount...0:
            return "You should try again. 💫"
        case 0...trueCount / 2:
            return "Not bad, Darlin. 🙃"
        case trueCount / 2...trueCount:
            return "You are amazing! 💪"
        default:
            return ""
        }
    }
    
    func getResult(count: Int) -> CGFloat {
        if startingAnimation {
            if count == 0 {
                return 40
            }
            
            return CGFloat((310 * count) / (trueCount + falseCount))
        }
        
        return 0
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(trueCount: 6, falseCount: 7)
    }
}
