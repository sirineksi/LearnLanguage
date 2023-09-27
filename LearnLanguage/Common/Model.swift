//
//  Model.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI

struct Unit: Decodable, Identifiable {
    let id: Int
    let name: String? = ""
    let description: String? = ""
    let icon: String? = ""
    let premium: Bool = false
    let platformId: Int? = 0
    let funQuestions: [Int]? = []
    let funSubUnits: [Int]? = []
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case icon
        case premium
        case platformId
        case funQuestions
        case funSubUnits
        
    }

  





}
