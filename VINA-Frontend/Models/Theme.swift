//
//  Theme.swift
//  VINA
//
//  Created by Youssef Ahab on 12/07/2022.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case clear
    case black
    case white
    case blue
    case orange
    case purple
    case green
    case red
    case yellow
    
    var accentColor: Color {
        switch self {
        case .blue, .orange, .yellow, .white: return .black
        case .purple, .black, .red: return .white
        case _: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        self.rawValue.capitalized
    }
    var id: String {
        self.name
    }
}
