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


    var body: some View {
        VStack {
           
            Toggle("Ses Aç/Kapat", isOn: $isSoundOn)
                            .font(.title3)
                            .padding()
                            .onChange(of: isSoundOn) { newValue in
                              UserDefaults.standard.set(newValue, forKey: "isSoundOn")
                            }
            
            
             NavigationLink("Oyuna Başla", destination: ContentView()) // Başlatma butonu ve yönlendirme
                .font(.title3)
                .padding()
                .background(Color(UIColor(hex: 0x187498))) // Arka plan rengi
                .foregroundColor(.white)// Metin rengi
                .cornerRadius(10) // Kenar yuvarlatma
        }
        .padding(.top, 10)
    }
}
