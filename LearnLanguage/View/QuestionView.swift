//
//  QuestionView.swift
//  LearnLanguage
//
//  Created by ceksi on 29.09.2023.
//

import SwiftUI
import Foundation 


struct QuestionView: View {
    
       @State private var currentQuestionIndex = 0
       @State private var score = 0
       @State private var showAlert = false
       @State private var selectedAnswerIndex: Int?
    @State private var isQuizFinished = false
    
    @State var words: [Word] = []
    
    @State var subUnit: FunSubUnit
    
    var body: some View {
        VStack {
            
            Text("Quiz")
            .font(.largeTitle)
            .padding()
            
            //kaçıncı soru olduğu
            Text("Question \(currentQuestionIndex + 1) of \(words.count)")
            
            
            if currentQuestionIndex >= 0 && currentQuestionIndex < words.count {
               
                //soru
                Text(words[currentQuestionIndex].sentenceBlank ?? "")
                               .font(.title)
                               .padding()
                
                // cevap şıkları
                VStack {
                ForEach(0..<4, id: \.self) { optionIndex in
                                Button(action: {
                                    checkAnswer(optionIndex)
                                   
                                }) {
                                    Text(words[optionIndex].en ?? "") // Assuming "tr" is the correct translation
                                        .font(.headline)
                                        .padding()
                                        .background(getOptionColor(optionIndex))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .padding(.vertical, 10)
                            }
                }
                
                // ileri- geri butonları
                   HStack {
                                Button("Previous") {
                                    previousQuestion()
                                }
                                .disabled(currentQuestionIndex == 0)
                                
                                Spacer()
                                
                                Button("Next") {
                                    nextQuestion()
                                }
                                .disabled(currentQuestionIndex == words.count - 1)
                            }
                            .padding()
                
                           Spacer()
                
                 
                // score hesaplama
                           if currentQuestionIndex == words.count - 1 {
                               Text("Score: \(score) / \(words.count)")
                                   .font(.title)
                                   .padding()
                               Button("Finish") {
                                   showAlert = true
                               }
                               .alert(isPresented: $showAlert) {
                                   Alert(title: Text("Quiz Finished"), message: Text("Your Score: \(score) / \(words.count)"), dismissButton: .default(Text("OK")))
                               }
                           }
                       
                
                
                       } else {
                           Text("No more questions.")
                       }
            
            
            
            
            
            
            
            
            
            
         
           
        }
        
        .onAppear {
            APIManager().fetchFunQuestions(subUnitId: subUnit.id, completion: { fetchFunQuestion in
                self.words = fetchFunQuestion.funQuestion.words ?? []
            })
        }
    }
  
    func getOptionColor(_ optionIndex: Int) -> Color {
        if optionIndex == selectedAnswerIndex {
            return optionIndex == 0 ? .green : .red
        } else {
            return .blue
        }
    }

    func checkAnswer(_ optionIndex: Int) {
        print("mevcut sorunun cevabı en \(words[currentQuestionIndex].en) ")
        print("seçilen cevabın cevabı en \(words[optionIndex].en) ")
        
        
        if words[optionIndex].en == words[currentQuestionIndex].en {
            score += 1
        }
        selectedAnswerIndex = optionIndex
    }


    func nextQuestion() {
        if currentQuestionIndex < words.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            if currentQuestionIndex == words.count - 1 {
                isQuizFinished = true
            }
        }
    }

    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            selectedAnswerIndex = nil
        }
    }

    func delayNextQuestion() {
        // Delay nextQuestion by 2 seconds (adjust the duration as needed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            nextQuestion()
        }
    }
}
