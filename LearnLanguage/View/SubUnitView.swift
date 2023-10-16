//
//  UnitView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct SubUnitView: View {
    
    @State var unit: Unit
    @State var subUnits: [FunSubUnit] = []
    
    var body: some View {
        VStack{
           
                List (subUnits) { subUnit in
                    NavigationLink(destination: QuestionView(subUnit: subUnit )) {
                        HStack {
                            if let img = subUnit.icon.removingPrefix("data:image/png;base64,").imageFromBase64 {
                                Image(uiImage: img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 64, height: 64)
                            } else {
                                Text("görüntü yüklenemedi")
                            }
                             
                            VStack {
                                Text(subUnit.name)
                                .padding()
                                .foregroundColor(.red)
                                .font(.title2)
                            
                                Text(subUnit.description)
                                .padding()
                                .foregroundColor(.black)
                                .font(.title3)
                            }
                            
                            Spacer()
                            // ?? öndeki değerin boş olup olmadığını kontrol eder ve default değer verir.
                           
                            Image("openlock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            
                           
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Unit List", displayMode: .inline)
            
            
            .onAppear {
                APIManager().fetchFunSubUnits(unitId: unit.id, completion: { fetchedSubUnit in
                    self.subUnits = fetchedSubUnit.funSubUnits
                })
                }
            
               
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


        
    
