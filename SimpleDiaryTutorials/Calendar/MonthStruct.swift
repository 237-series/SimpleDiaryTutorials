//
//  MonthStruct.swift
//  CalendarSwiftUI
//
//  Created by sglee237 on 2023/01/25.
//

import Foundation

struct MonthStruct {
    var monthType:MonthType
    var dayInt : Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}
