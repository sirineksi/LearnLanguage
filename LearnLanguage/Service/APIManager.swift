//
//  APIManager.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import Metal

class APIManager {
    
    let baseUrl = "https://ceksi.app/api"
    
    func fetchUnits (completion: @escaping([Unit]) -> Void) {
       
        guard let url = URL(string: "\(baseUrl)/FunUnit?") else {
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
    
    func fetchFunSubUnits (unitId: Int, completion: @escaping(FunRoot) -> Void) {
       
        guard let url = URL(string: "\(baseUrl)/FunSubUnit/unitId/\(unitId)") else {
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
                let funRoot = try JSONDecoder().decode(FunRoot.self, from: data)
                DispatchQueue.main.async {
                    print(funRoot)
                    completion(funRoot)
                    
                }
            }catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
            
        }.resume()

    }
    
    func fetchFunQuestions(subUnitId: Int, completion: @escaping (QuestionRoot) -> Void) {
        guard let url = URL(string: "\(baseUrl)/FunQuestion/GetAllQuestion/\(subUnitId)") else {
           
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error decoding data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                
                return
            }

            do {
                let funRoot = try JSONDecoder().decode(QuestionRoot.self, from: data)
                DispatchQueue.main.async {
                    completion(funRoot)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }

        }.resume()
    }

    
}
