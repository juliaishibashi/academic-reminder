////
////  DateSam.swift
////  academic-reminder
////
////  Created by Julia on 2024-08-24.
////
//
//import SwiftUI
//import Foundation // Import Foundation if needed
//
//struct DateSam: View {
//    @State private var selectedDate = Date()
//    @State private var isSaved = false
//    var oneSqlite = OneSqlite() // Ensure OneSqlite is recognized here
//
//    var body: some View {
//        VStack {
//            DatePicker("選択日時", selection: $selectedDate)
//                .datePickerStyle(.graphical)
//
//            Text("選択された日時: \(selectedDate, format: .dateTime)")
//                .padding()
//                .cornerRadius(10)
//
//            Button("保存") {
//                saveDateToDatabase(date: selectedDate)
//                isSaved = true
//            }
//            .disabled(isSaved)
//
//            Button("キャンセル") {
//                selectedDate = Date()
//                isSaved = false
//            }
//        }
//        .alert(isPresented: $isSaved) {
//            Alert(title: Text("保存完了"), message: Text("日時が保存されました。"))
//        }
//        .onAppear {
//            if !oneSqlite.createOneDB() {
//                print("DB creation failed on appear")
//            }
//        }
//    }
//
//    func saveDateToDatabase(date: Date) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let dateString = dateFormatter.string(from: date)
//
//        let insertQuery = "INSERT INTO dates (date) VALUES (?);"
//        var statement: OpaquePointer?
//
//        if sqlite3_prepare_v2(oneSqlite.dbPointer, insertQuery, -1, &statement, nil) == SQLITE_OK {
//            sqlite3_bind_text(statement, 1, (dateString as NSString).utf8String, -1, nil)
//            if sqlite3_step(statement) == SQLITE_DONE {
//                print("Date saved to database")
//            } else {
//                print("Failed to save date")
//            }
//            sqlite3_finalize(statement)
//        } else {
//            print("Failed to prepare insert statement")
//        }
//    }
//}DOES NOT WORK
//
//#Preview {
//    DateSam()
//}
