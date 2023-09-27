//
//  ContentView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var secilenSekme = 0
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: UnitListView()) {
                    Text("Unit List View")
                }.padding()
                
                TabView(selection: $secilenSekme) {
                    FeedView()
                        .tabItem{
                            Image("home-button")
                            Text("Ana Ekran")
                            
                        }
                        .tag(0)
                    
                    FavoriteView()
                        .tabItem {
                            Image("favourite.2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                Text("Favoriler")
                            
                        }
                        .tag(1)
                    
                    SettingView()
                        .tabItem {
                            Image("setting")
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

