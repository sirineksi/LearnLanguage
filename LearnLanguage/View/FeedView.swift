//
//  FeedView.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import SwiftUI

struct FeedView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    var themeColor: Color {
        return darkModeEnabled ? Color.black : Color.white
    }
    @Environment(\.presentationMode) var presentationMode
    
    @State var units: [Unit] = []
    
    var body: some View {
        NavigationView{
        VStack{
            
            List(units) { unit in
                NavigationLink(destination: SubUnitView (unit: unit)) {
                    HStack {
                        if let img = unit.icon.removingPrefix("data:image/png;base64,").imageFromBase64 {
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
                            Text(unit.name)
                                .foregroundColor(Color(UIColor(hex: 0xEB5353)))
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.bottom, 1)
                           
                            Text(unit.description)
                               .foregroundColor(Color(UIColor(hex: 0xB4B4B3)))
                               .font(.callout)
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
            .navigationBarTitle("Categories", displayMode: .inline)
            
            
            
            
            
            .onAppear{
                APIManager().fetchUnits { fetchedUnit in
                    self.units = fetchedUnit.data
                    
                }
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        }
    }
}





