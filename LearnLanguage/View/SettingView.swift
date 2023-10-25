//
//  SettingsView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct SettingView: View {
    
    @State private var isSoundOn: Bool = UserDefaults.standard.bool(forKey: "isSoundOn")
    @State private var showAlert = false



    var body: some View {
        VStack {
           
            Toggle("Ses Aç / Kapat", isOn: $isSoundOn)
                            .font(.title3)
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                            .onChange(of: isSoundOn) { newValue in
                              UserDefaults.standard.set(newValue, forKey: "isSoundOn")
                            }
            Spacer()
            
            Button("Highscore Sıfırla") {
                           UserDefaults.standard.set(0, forKey: "highScore")
                           UserDefaults.standard.set(0, forKey: "mistakes")
                           UserDefaults.standard.set("", forKey: "UnitName")
                          showAlert = true // Alert'ı göster
           
                   }
                       .font(.title3)
                       .frame(width: 200, height: 60)
                       .background(Color(UIColor(hex: 0xEB5353)))
                       .foregroundColor(.white)
                       .cornerRadius(10)
                      
                    .padding(.bottom, 50)
                       .alert(isPresented: $showAlert) {
                                      Alert(
                                          title: Text("Highscore Sıfırlandı!"),
                                          message: Text("Highscore başarıyla sıfırlandı."),
                                          dismissButton: .default(Text("Tamam"))
                                      )
                                  }
            
            
             NavigationLink("Oyuna Başla", destination: ContentView()) // Başlatma butonu ve yönlendirme
                .font(.title3)
                .padding()
                .background(Color(UIColor(hex: 0x187498))) // Arka plan rengi
                .foregroundColor(.white)// Metin rengi
                .cornerRadius(10) // Kenar yuvarlatma
        }
        .padding(.bottom, 100)
    }
}
