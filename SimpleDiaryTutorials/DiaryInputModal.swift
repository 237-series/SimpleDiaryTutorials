//
//  DiaryInputModal.swift
//  SimpleDiaryTutorials
//
//  Created by sglee237 on 2023/02/13.
//

import SwiftUI

struct DiaryInputModal: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    
    var dataManager:DiaryDataManager = DiaryDataManager.shared
    
    @State var selectedWeather:DiaryWeatherItem = .sunny
    
    @State private var title:String = ""
    @State private var state:Int = 3
    var range: ClosedRange<Int> = 1...5
 
    func addData() -> Bool {
        let newData = DiaryModel(keyDate: Date(), title: title, weather: selectedWeather, state: DiaryStateItem(rawValue: state))
        return !dataManager.add(DiaryModel: newData)
    }
    
    var TopButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
            }
            Spacer()
            Text("오늘은 어떤가요?")
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
            Button {
                isPresented = addData()
            } label: {
                Image(systemName: "checkmark.circle")
                    .imageScale(.large)
            }

            
        }.padding()
    }
    
    var PickerArea: some View {
        VStack {
            Picker("", selection: $selectedWeather) {
                ForEach(DiaryWeatherItem.allCases, id: \.self) {
                    weatherItem in
                    Text(weatherItem.displayImoji)
                        .tag(weatherItem)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
        }
    }
    func changeStage(value:Int) {
        if range ~= state + value {
            state += value
        }
    }
    
    func getStateList() -> Array<String> {
        return Array(repeating: "heart.square", count: state)
    }
    
    var StateStar: some View {
        HStack(spacing: -3) {
            ForEach(getStateList(), id:\.self) { imageName in
                Image(systemName: imageName)
                    .imageScale(.large)
                    .foregroundColor(.red)
            }
        }
    }
    
    var StateStepper: some View {
        HStack {
            Button {
                self.changeStage(value: -1)
            } label: {
                Image(systemName: "minus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
            
            Text("오늘의 상태")
                .font(.title3)
                .foregroundColor(.gray)
            
            Spacer()
            StateStar
            
            Button {
                self.changeStage(value: 1)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
        }
    }
    
    var InputArea: some View {
        VStack {
            StateStepper
            PickerArea
            TextField("...입력하기...", text: $title, axis: .vertical)
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
    
    var body: some View {
        VStack {
            TopButton
            InputArea
            Spacer()
        }
        .padding()
    }
}

struct DiaryInputModal_Previews: PreviewProvider {
    static var previews: some View {
        DiaryInputModal(isPresented: .constant(true))
    }
}
