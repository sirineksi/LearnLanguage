//
//  UnitListView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI

struct UnitListView: View {
    
    @State var units: [Unit] = []
    
    var body: some View {
        VStack{
            NavigationView{
                List(units) { unit in
                    NavigationLink(destination: UnitView(unit: unit)) {
                        VStack{
                            Text(unit.name ?? "")
                                .padding()
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            if let base64Data = Data(base64Encoded: unit.icon ?? "") {
                                if let uiImage = UIImage(data: base64Data) {
                                    let image = Image(uiImage: uiImage)
                                    image
                                                   .resizable()
                                                   .aspectRatio(contentMode: .fit)
                                                   .frame(width: 64, height: 64)
                                    }
                                Text("Base64 Resim")
                                
                                HStack{
                                    Button(action: {}) {
                                        Text("Kategori")
                                    }
                                    
                                }
                                .padding()
                                
                                
                                
                            }

                        }
                    }
                     
                }
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


