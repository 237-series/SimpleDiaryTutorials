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
    
    func addData() -> Bool {
        let newData = DiaryModel(keyDate: Date(), title: title)
        return !dataManager.add(DiaryModel: newData)
    }
    
    var TopButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("돌아가기")
            }
            Spacer()
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
    
    var InputArea: some View {
        VStack {
            HStack {
                Text("오늘은 어떤가요?")
                    .font(.title)
                Spacer()
                Button {
                    isPresented = addData()
                } label: {
                    Image(systemName: "arrow.up")
                        .imageScale(.large)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                }

            }
            PickerArea
            TextField("...입력하기...", text: $title)
                .font(.title)
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
