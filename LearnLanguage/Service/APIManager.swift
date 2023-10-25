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

    // İstek verilerini oluştur
    let requestData: [String: Any] = [
        "platformId": 3,
        "userId": 3,
        "webapikey": "3be63bc9-7f43-4d0e-a57b-fd1566c5c680"
    ]
    
    
    func fetchUnits(completion: @escaping (ResponseUnit) -> Void) {
        guard let url = URL(string: "\(baseUrl)/FunUnit/GetAllUnit") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       
        
        
        // Veriyi JSON formatına dönüştür
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestData) {
            request.httpBody = jsonData
           
        }
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                //print("sirin: \(data)")
                let units = try JSONDecoder().decode(ResponseUnit.self, from: data)
                DispatchQueue.main.async {
                    print(units)
                    completion(units)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }

    
    func fetchFunSubUnits (unitId: Int, completion: @escaping(ResponseSubUnit) -> Void) {
       
        guard let url = URL(string: "\(baseUrl)/FunSubUnit/unitId/\(unitId)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        // Veriyi JSON formatına dönüştür
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestData) {
            request.httpBody = jsonData

        }
 
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                //print("sirin: \(data)")
                let funRoot = try JSONDecoder().decode(ResponseSubUnit.self, from: data)
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
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        // Veriyi JSON formatına dönüştür
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestData) {
            request.httpBody = jsonData
            print(jsonData)
        }
        
        print(request)
     
        URLSession.shared.dataTask(with: request) { data, response, error in
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
