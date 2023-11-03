//
//  ContentView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI
import Foundation 


struct ContentView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false


    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex:0x187498 )
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
 

    
    @State public var secilenSekme = 0
    
    var body: some View {
      
            VStack{
                
                TabView(selection: $secilenSekme) {
                   
                    FeedView()
                        .tabItem{
                            Image("home-button1")
                            Text("Ana Ekran")
                            
                        }
                        .tag(0)
                    
                    ScoreView(selectedTab: $secilenSekme)
                        .tabItem {
                            Image("star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("Score")
                            
                        }
                        .tag(1)
                    
                    SettingView(selectedTab: $secilenSekme)
                        .tabItem {
                            Image("settings")
                            Text("Ayarlar")
                        }
                        .tag(2)
                }
                .accentColor(getColor(tabIndex: secilenSekme))
                
                
            
            }.preferredColorScheme(darkModeEnabled ? .dark : .light)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

