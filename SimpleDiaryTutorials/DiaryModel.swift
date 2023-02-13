//
//  DiaryModel.swift
//  SimpleDiaryTutorials
//
//  Created by sglee237 on 2023/02/13.
//

import Foundation

enum DiaryWeatherItem: String, CaseIterable, Codable {
    case sunny
    case cloudy
    case rain
    case snow
    case wind
    case cold
    case hot
    
    var displayImoji: String {
        switch self {
        case .sunny: return "☀️"
        case .cloudy: return "🌥️"
        case .rain: return "🌧️"
        case .snow: return "🌨️"
        case .wind: return "💨"
        case .cold: return "❄️"
        case .hot: return "🔥"
        }
    }
}

enum DiaryFeelingItem: CaseIterable, Codable {
    case happy
    case delight
    case exited
    case sad
    case moodiness
    case annoying
    case angry
    case soso
}

enum DiaryStateItem:Int, CaseIterable, Codable {
    case verygood   = 5
    case good       = 4
    case soso       = 3
    case bad        = 2
    case verybad    = 1
}

struct DiaryModel: Codable {
    var keyDate:Date
    
    func keyDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: keyDate)
    }
    
    var lastModifiedData:Date?
    
    var title: String
    var contents: String?
    
    var userId:UUID?
    var partnerId:UUID?
    
    var weather:DiaryWeatherItem?
    var feeling:DiaryFeelingItem?
    var state:DiaryStateItem?
    
    
}
