import SQLite3
import SwiftUI

class ReminderDatabaseManager {
    var db: OpaquePointer?

    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("reminders.db")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening reminders database")
        } else {
            createTable()
        }
    }

    func createTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS reminders (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                remindValue TEXT,
                selectedOption TEXT
            );
            """
        var createTableStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("Error creating reminders table")
        } else {
            if sqlite3_step(createTableStatement) != SQLITE_DONE {
                print("Error creating reminders table")
            }
        }
        sqlite3_finalize(createTableStatement)
    }

    func saveReminder(remindValue: String, selectedOption: String) {
        let insertStatementString = "INSERT INTO reminders (remindValue, selectedOption) VALUES (?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, remindValue, -1, nil)
            sqlite3_bind_text(insertStatement, 2, selectedOption, -1, nil)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Error inserting reminder")
            }
        } else {
            print("Error preparing insert statement for reminder")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func fetchReminders() -> [Reminder] {
        let queryStatementString = "SELECT * FROM reminders;"
        var queryStatement: OpaquePointer?
        var reminders: [Reminder] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let remindValue = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let selectedOption = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                reminders.append(Reminder(id: Int(id), remindValue: remindValue, selectedOption: selectedOption))
            }
        } else {
            print("Error preparing fetch statement for reminders")
        }
        sqlite3_finalize(queryStatement)
        return reminders
    }
}

struct Reminder {
    var id: Int
    var remindValue: String
    var selectedOption: String
}
