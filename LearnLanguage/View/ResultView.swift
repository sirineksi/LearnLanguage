//
//  ResultView.swift
//  LearnLanguage
//
//  Created by ceksi on 17.10.2023.
//

import SwiftUI

struct ResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    
    @State var score: Int
    @State var wordsCount: Int
    @State var UnitName: String
    
    var body: some View {
        VStack{
            
            Image("theend")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            
            Text("Score: \(score) / \(wordsCount)")
                .font(.title)
                .padding()
                .foregroundColor(Color(UIColor(hex: 0xEB5353)))
            
            
            
            HStack{
                
                Button("Next Level") {
                    presentationMode.wrappedValue.dismiss()
                    presentationMode.wrappedValue.dismiss()
                    
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color(UIColor(hex: 0x36AE7C)))
                .cornerRadius(10)
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .font(.headline)
                
                
            }
        }
        .onAppear {
           // userSettings.highScore = score
            //userSettings.mistakes = score
           // userSettings.unitName = UnitName
            
            UserDefaults.standard.set(score, forKey: "highScore")
            UserDefaults.standard.set(wordsCount - score, forKey: "mistakes")
            UserDefaults.standard.set(UnitName, forKey: "UnitName")
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Result", displayMode: .inline)
    }
}


