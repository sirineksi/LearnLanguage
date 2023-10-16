//
//  FeedView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI

struct FeedView: View {
    
    @State var units: [Unit] = []
    
    var body: some View {
        VStack{
            NavigationView{
                List(units) { unit in
                    NavigationLink(destination: SubUnitView (unit: unit)) {
                        HStack {
                            if let img = unit.icon.removingPrefix("data:image/png;base64,").imageFromBase64 {
                                Image(uiImage: img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 64, height: 64)
                            } else {
                                Text("görüntü yüklenemedi")
                            }
                             
                            VStack {
                            Text(unit.name)
                                .padding()
                                .foregroundColor(.red)
                                .font(.title2)
                            
                                Text(unit.description)
                                .padding()
                                .foregroundColor(.black)
                                .font(.title3)
                            }
                            
                            Spacer() 
                            // ?? öndeki değerin boş olup olmadığını kontrol eder ve default değer verir.
                            if unit.premium ?? false {
                            Image("openlock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            
                            }else {
                                Image("closelock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Unit List", displayMode: .inline)
            }
            
            
                .onAppear{
                    APIManager().fetchUnits { fetchedUnit in
                        self.units = fetchedUnit
                        
                    }
                    
                }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}





