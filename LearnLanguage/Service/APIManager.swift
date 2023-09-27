//
//  APIManager.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation

class APIManager {
    func fetchUnits (completion: @escaping([Unit]) -> Void) {
        guard let url = URL(string: "http://quiz.bankomaclar.com/api/FunUnit") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                print("sirin: \(data)")
                let units = try JSONDecoder().decode([Unit].self, from: data)
                DispatchQueue.main.async {
                    print(units)
                    completion(units)
                    
                }
            }catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
            
        }.resume()
        
        
        
    }
    
    
    
}
