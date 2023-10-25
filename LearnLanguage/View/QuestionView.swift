//
//  QuestionView.swift
//  LearnLanguage
//
//  Created by ceksi on 29.09.2023.
//

import SwiftUI
import Foundation
import AVFoundation


struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isSoundOn: Bool = UserDefaults.standard.bool(forKey: "isSoundOn")
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showAlert = false
    @State private var selectedAnswerIndex: Int?
    
    @State var words: [Word] = []
    @State var shuffledWords: [Word] = []
    
    @State var subUnit: FunSubUnit
    @State private var showResult = false
    
    @State private var isRedirected = false
    
    @State private var isLoading = true
    @State private var player: AVAudioPlayer?
    @State private var playerFail: AVAudioPlayer?
    
    var body: some View {
        
        VStack {
            
            if isLoading {
                ProgressView("Loading...")
            }else {
                //kaçıncı soru olduğu
                Text("Question \(currentQuestionIndex + 1) of \(words.count)")
                if currentQuestionIndex >= 0 && currentQuestionIndex < words.count {
                    
                    //soru
                    Text(words[currentQuestionIndex].sentenceBlank ?? "")
                        .font(.title)
                        .padding()
                    
                    // cevap şıkları
                    VStack {
                        
                        ForEach(0..<shuffledWords.count, id: \.self) { optionIndex in
                            Button(   action: {
                                checkAnswer(optionIndex)
                            }) {
                                Text(shuffledWords[optionIndex].en ?? "")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .labelStyle(.iconOnly)
                            }
                            .frame(maxWidth: .infinity - 20) // Tam ekran genişliği
                            .padding(.vertical, 10)
                            .background(getOptionColor(optionIndex))
                            .cornerRadius(10)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(
                        
                        NavigationLink("",
                                       destination: ResultView(
                                        
                                        score: score,
                                        wordsCount: words.count,
                                        UnitName: subUnit.name
                                       ),
                                       isActive: $isRedirected)
                        
                    )
                    
                    // ileri- geri butonları
                    HStack {
                        Button("Previous") {
                            previousQuestion()
                        }
                        .foregroundColor(Color(UIColor(hex: 0x187498)))
                        .disabled(currentQuestionIndex == 0)
                        
                        Spacer()
                        
                        Button("Next") {
                            nextQuestion()
                        }
                        .foregroundColor(Color(UIColor(hex: 0x187498)))
                        .disabled(currentQuestionIndex == words.count - 1)
                    }
                    .padding()
                    
                    
                } else {
                    Text("No more questions.")
                }
            }
            
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle(subUnit.name, displayMode: .inline)
        .onAppear {
            
            
            
            APIManager().fetchFunQuestions(subUnitId: subUnit.id, completion: { fetchFunQuestion in
                self.words = fetchFunQuestion.data.words ?? []
                self.shuffledWords = self.words
                isLoading = false
                
                if let audioURL = Bundle.main.url(forResource: "correct", withExtension: "mp3") {
                    print("Audio URL: \(audioURL)")
                    do {
                        self.player = try AVAudioPlayer(contentsOf: audioURL)
                        
                    } catch {
                        print("Error playing audio: \(error.localizedDescription)")
                    }
                } else {
                    print("Audio file not found.")
                }
                
                if let audioURL = Bundle.main.url(forResource: "fail", withExtension: "mp3") {
                    print("Audio URL: \(audioURL)")
                    do {
                        self.playerFail = try AVAudioPlayer(contentsOf: audioURL)
                        
                    } catch {
                        print("Error playing audio: \(error.localizedDescription)")
                    }
                } else {
                    print("Audio file not found.")
                }
                
            })
        }
        
    }
    
    func getOptionColor(_ optionIndex: Int) -> Color {
        
        if optionIndex == selectedAnswerIndex {
            if shuffledWords[optionIndex].en == words[currentQuestionIndex].en {
                return (Color(UIColor(hex: 0x36AE7C))
                ) // Doğru yanıt yeşil
            } else {
                return (Color(UIColor(hex: 0xEB5353))
                )// Yanlış yanıt kırmızı
            }
        }
        return (Color(UIColor(hex: 0x187498))
        )
    }
    
    
    func checkAnswer(_ optionIndex: Int) {
        print("mevcut soru: \(words[currentQuestionIndex].sentence) ")
        print("mevcut cevab: \(words[currentQuestionIndex].en) ")
        print("seçilen soru: \(shuffledWords[optionIndex].sentence) ")
        print("seçilen cevab: \(shuffledWords[optionIndex].en) ")
        
        if shuffledWords[optionIndex].en == words[currentQuestionIndex].en {
            score = score + 1
            if isSoundOn {
                player?.play()
            }
        } else {
            if isSoundOn {
                playerFail?.play()
            }
            print("Hata sesi çal")
        }
        
        selectedAnswerIndex = optionIndex
        
        //son soruuuuu
        if currentQuestionIndex == words.count - 1 {
            print("son eleman tıklandı")
            // 1 saniye sonra çalışır
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isRedirected = true
            }
            
        }else {
            delayNextQuestion()
            isRedirected = false
        }
        
    }
    
    func nextQuestion() {
        if currentQuestionIndex < words.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            self.shuffledWords = self.shuffledWords.shuffled()
        } else {
            //son soru
        }
        
    }
    
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            selectedAnswerIndex = nil
            self.shuffledWords = self.shuffledWords.shuffled()
        }
    }
    
    func delayNextQuestion() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            nextQuestion()
        }
    }
    
}
