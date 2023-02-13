//
//  DiaryDataManager.swift
//  SimpleDiaryTutorials
//
//  Created by sglee237 on 2023/02/13.
//

import Foundation

class DiaryDataManager:ObservableObject {
    static let DIARY_DATA_LIST_KEY = "diary_data_list_key"
    
    static let shared = DiaryDataManager()
    
    @Published var dataList:[DiaryModel] = []
    
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
            DiaryModel(keyDate: Date(), title: "오늘은 좋았던 날"),
            DiaryModel(keyDate: Date(), title: "오늘은 조금 평범했던 날")
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
        
        let returnList:[DiaryModel] = dataList
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
