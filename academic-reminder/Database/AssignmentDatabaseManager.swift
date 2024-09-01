import SQLite3
import SwiftUI

class AssignmentDatabaseManager {
    var db: OpaquePointer?

    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("assignments.db")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening assignments database")
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
                date TEXT,
                status TEXT
            );
            """
        var createTableStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("Error creating assignments table")
        } else {
            if sqlite3_step(createTableStatement) != SQLITE_DONE {
                print("Error creating assignments table")
            }
        }
        sqlite3_finalize(createTableStatement)
    }

    func saveAssignment(title: String, courseName: String, type: String, weight: String, date: Date, status: String) {
        let insertStatementString = "INSERT INTO assignments (title, courseName, type, weight, date, status) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = dateFormatter.string(from: date)

            sqlite3_bind_text(insertStatement, 1, title, -1, nil)
            sqlite3_bind_text(insertStatement, 2, courseName, -1, nil)
            sqlite3_bind_text(insertStatement, 3, type, -1, nil)
            sqlite3_bind_text(insertStatement, 4, weight, -1, nil)
            sqlite3_bind_text(insertStatement, 5, dateString, -1, nil)
            sqlite3_bind_text(insertStatement, 6, status, -1, nil)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Error inserting assignment")
            }
        } else {
            print("Error preparing insert statement for assignment")
        }
        sqlite3_finalize(insertStatement)
    }

    func fetchAssignments() -> [Assignment] {
        let queryStatementString = "SELECT * FROM assignments;"
        var queryStatement: OpaquePointer?
        var assignments: [Assignment] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let title = String(cString: sqlite3_column_text(queryStatement, 1))
                let courseName = String(cString: sqlite3_column_text(queryStatement, 2))
                let type = String(cString: sqlite3_column_text(queryStatement, 3))
                let weight = String(cString: sqlite3_column_text(queryStatement, 4))
                let dateString = String(cString: sqlite3_column_text(queryStatement, 5))
                let status = String(cString: sqlite3_column_text(queryStatement, 6))
                
                // Convert dateString to Date
                let date = dateFormatter.date(from: dateString) ?? Date() // Default to current date if conversion fails
                
//                assignments.append(Assignment(id: Int(id), title: title, courseName: courseName, type: type, weight: weight, date: date, status: status ?? "Unknown"))
            }
        } else {
            print("Error preparing fetch statement for assignments")
        }
        sqlite3_finalize(queryStatement)
        return assignments
    }
}

