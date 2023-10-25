//
//  Helper.swift
//  LearnLanguage
//
//  Created by ceksi on 27.09.2023.
//

import Foundation
import SwiftUI


func getColor(tabIndex: Int ) ->  Color {
    if tabIndex == 0 {
        return (Color(UIColor(hex: 0x187498)))
        
    }
    else if tabIndex == 1 {
        return (Color(UIColor(hex: 0xEB5353)))
    }
    
    else if tabIndex == 2 {
        return Color.yellow
    }
    
    else {
        return Color.black
    }
    
}


