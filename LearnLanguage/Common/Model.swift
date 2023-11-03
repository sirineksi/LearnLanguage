//
//  Model.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct ResponseUnit: Decodable {
    let message: String
    let isSuccess: Bool
    let data: [Unit]
  
}

struct Unit: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let icon: String 
    let premium: Bool?
    let platformId: Int? = 0
    let funQuestions: [Int]? = []
    let funSubUnits: [Int]? = []
    let platform: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case icon
        case premium
        case platformId
        case funQuestions
        case funSubUnits
        case platform
        
    }

  }

struct Platform: Decodable {
    let nama: String?
    
}

struct ResponseSubUnit: Decodable {
    let message: String
    let isSuccess: Bool
    let data: FunSubUnits
  
}

struct FunSubUnits: Decodable {
    let funSubUnits: [FunSubUnit]
    
}


struct FunSubUnit: Decodable, Identifiable {
    let id: Int
    let unitId: Int
    let funTypeId: Int?
    let name: String
    let description: String
    let icon: String
    let isFirst: Bool?
    let funType: FunType?

    struct FunType: Decodable {
        let name: String
        let active: Bool?
        let icon: String?
        let description: String?
        let slug: String?
        let platformId: String?
    }
}

struct FunRoot: Decodable {
    let funSubUnits: [FunSubUnit]
}



struct Word: Codable,  Identifiable{
    let id: Int
    let en: String?
    let tr: String?
    let de: String?
    let it: String?
    let fr: String?
    let es: String?
    let pt: String?
    let ru: String?
    let sentence: String?
    let sentenceBlank: String?
    let image: String?
    let active: Bool?
    let platformId: Int?
    
   
}

struct SubUnitSirin: Codable {
    let unitId: Int?
    let funTypeId: Int?
    let name: String?
    let description: String?
    let icon: String?
    let isFirst: Bool?
}

struct UnitSirin: Codable {
    let platformId: Int?
    let name: String?
    let description: String?
    let icon: String?
    let premium: Bool?
}

struct FunQuestion: Codable {
    let id: Int
    let unitId: Int?
    let subUnitId: Int?
    let unit: UnitSirin?
    let subUnit: SubUnitSirin?
    var words: [Word]? = []
}

struct QuestionRoot: Codable {
    let isSuccess: Bool
    let message: String
    let data: FunQuestion
  
}




class UserSettings: ObservableObject {
    @Published var highScore: Int = 0
    @Published var mistakes: Int = 0
    @Published var unitName: String = ""
}


