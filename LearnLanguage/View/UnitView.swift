//
//  UnitView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct UnitView: View{
    
    @State var unit: Unit
    
    var body: some View {
        VStack{
            Text(unit.name ?? "")
                .font(.title)
                .padding()
                .foregroundColor(Color.red)
            Text(unit.description ?? "")
            
            if unit.premium  {
                Image("favourite.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            } else {
                Image("home-button")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
        }
        
        .navigationBarTitle(unit.name ?? "")
    }
    
    
    
    
}
