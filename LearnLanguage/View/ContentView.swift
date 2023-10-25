//
//  ContentView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI
import Foundation 


struct ContentView: View {
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex:0x187498 )
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
 
    @State private var secilenSekme = 0
    
    var body: some View {
        NavigationView{
            VStack{
                
                TabView(selection: $secilenSekme) {
                    FeedView()
                        .tabItem{
                            Image("home-button1")
                            Text("Ana Ekran")
                            
                        }
                        .tag(0)
                    
                    ScoreView()
                        .tabItem {
                            Image("star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("Score")
                            
                        }
                        .tag(1)
                    
                    SettingView()
                        .tabItem {
                            Image("settings")
                            Text("Ayarlar")
                        }
                        .tag(2)
                }
                .accentColor(getColor(tabIndex: secilenSekme))
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

