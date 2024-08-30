import SQLite3
import SwiftUI

class DatabaseManager {
    var db: OpaquePointer?

    init() {
        // path to database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("sample.db")

        // open database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        } else {
            createTable()
        }
    }

    func createTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS assignments (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                courseName TEXT,
                type TEXT,
                weight TEXT,
                date TEXT
            );
            """
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

    func saveAssignment(title: String, courseName: String, type: String, weight: String, date: Date) {
        let insertStatementString = "INSERT INTO assignments (title, courseName, type, weight, date) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//            dateFormatter.timeZone = TimeZone.current
            let dateString = dateFormatter.string(from: date)
            
            sqlite3_bind_text(insertStatement, 1, title, -1, nil)
            sqlite3_bind_text(insertStatement, 2, courseName, -1, nil)
            sqlite3_bind_text(insertStatement, 3, type, -1, nil)
            sqlite3_bind_text(insertStatement, 4, weight,  -1, nil)
            sqlite3_bind_text(insertStatement, 5, dateString, -1, nil)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Error inserting row")
            }
        } else {
            print("Error preparing insert statement")
        }
        sqlite3_finalize(insertStatement)
    }
}

