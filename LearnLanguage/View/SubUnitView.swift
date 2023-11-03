//
//  UnitView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct SubUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                                .frame(width: 70, height: 70)
                                .padding(.bottom, 10)
                                .padding(.top, 10)

                        } else {
                            Text("görüntü yüklenemedi")
                        }
                        
                        VStack (alignment: .leading) {
                            Text(subUnit.name)
                                .foregroundColor(Color(UIColor(hex: 0xEB5353)))
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.bottom, 3)
                           Text(subUnit.description)
                               .foregroundColor(Color(UIColor(hex: 0xB4B4B3)))
                               .font(.callout)
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
            .navigationBarTitle("Units", displayMode: .inline)
            
            
            .onAppear {
                APIManager().fetchFunSubUnits(unitId: unit.id, completion: { fetchedSubUnit in
                    self.subUnits = fetchedSubUnit.data.funSubUnits
                })
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}




