//
//  DiaryDataManager.swift
//  SimpleDiaryTutorials
//
//  Created by sglee237 on 2023/02/13.
//

import Foundation

extension Date {
    func dateString(_ date:Date? = nil) -> String {
        var targetDate:Date = self
        if let date = date {
            targetDate = date
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: targetDate)
    }
}

class DiaryDataManager:ObservableObject {
    static let DIARY_DATA_LIST_KEY = "diary_data_list_key"
    
    static let shared = DiaryDataManager()
    var today:String = Date().dateString()
    
    @Published var dataList:[DiaryModel] = []
    @Published var keyDate = ""
    var strKeyDate: String {
        get {
            keyDate
        }
        set(newKeyDate) {
            if keyDate == newKeyDate {
                keyDate = ""
                return
            }
            
            keyDate = newKeyDate
        
        }
    }
    
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DiaryDataManager.DIARY_DATA_LIST_KEY) as? Data {
            let originlist = try? PropertyListDecoder().decode([DiaryModel].self, from: data)
            if let list = originlist {
                dataList = list
            }
        }
    }
    
    func getDummyData() -> [DiaryModel] {
        return  [
            DiaryModel(keyDate: Date(), title: "(예시)오늘은 좋았던 날"),
            DiaryModel(keyDate: Date(), title: "(예시)오늘은 조금 평범했던 날")
        ]
    }
    
    func saveDiary(Diary diary:DiaryModel?) -> Bool {
        if let data = diary {
            
            for (i, item) in dataList.enumerated() {
                if item.keyDate == data.keyDate {
                    dataList.remove(at: i)
                    break
                }
            }
            dataList.insert(data, at: 0)
            return true
        }
        
        
        return false
    }
    
    func getList() -> [DiaryModel] {
        if dataList.isEmpty {
            return getDummyData()
        }
        
        var returnList:[DiaryModel] = dataList
        
        if keyDate != "" {
            returnList = []
            for diaryModelItem in dataList {
                if diaryModelItem.keyDateString() == keyDate {
                    returnList.append(diaryModelItem)
                }
            }
        }
        
        
        return returnList
    }
    
    func add(DiaryModel data:DiaryModel?) -> Bool {
        if let data = data {
            dataList.insert(data, at: 0)
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(dataList), forKey: DiaryDataManager.DIARY_DATA_LIST_KEY)
            return UserDefaults.standard.synchronize()
        }
        
        return false
    }
}
