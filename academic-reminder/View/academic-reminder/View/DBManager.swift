import SQLite3
import SwiftUI

class DatabaseManager {
    var db: OpaquePointer?

    init() {
        // データベースのパス
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("sample.db")

        // データベースのオープン
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        } else {
            createTable()
        }
    }

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS dates (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT);"
        var createTableStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("Error creating table")
        } else {
            if sqlite3_step(createTableStatement) != SQLITE_DONE {
                print("Error creating table")
            }
        }
        sqlite3_finalize(createTableStatement)
    }

    func saveDate(date: Date) {
        let insertStatementString = "INSERT INTO dates (date) VALUES (?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            
            sqlite3_bind_text(insertStatement, 1, dateString, -1, nil)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Error inserting row")
            }
        } else {
            print("Error preparing insert statement")
        }
        sqlite3_finalize(insertStatement)
    }
}

