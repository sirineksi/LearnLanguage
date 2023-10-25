//
//  ScoreView.swift
//  LearnLanguage
//
//  Created by ceksi on 24.10.2023.
//

import SwiftUI

struct ScoreView: View {
  
    @AppStorage("highScore") private var dogruSayisi = 0
    @AppStorage("mistakes") private var yanlisSayisi = 0
    @AppStorage("UnitName") private var uniteAdi = ""
    
    var body: some View {
        VStack {
            
            Image("highscore")
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
                .padding(.bottom, 50)
            
            Text(" Ünite Adı: \(uniteAdi) ")
                .font(.title2)
                .padding()
            Text("Doğru: \(dogruSayisi) Yanlış: \(yanlisSayisi) ")
                .padding(.bottom, 50)
                .font(.title2)
            
            
            NavigationLink("Tekrar Oyna", destination: ContentView()) // Başlatma butonu ve yönlendirme
                .font(.title3)
                .padding()
                .background(Color(UIColor(hex: 0x187498))) // Arka plan rengi
                .foregroundColor(.white)// Metin rengi
                .cornerRadius(10) // Kenar yuvarlatma
        }
        .padding(.top, 10)

        }
    }
