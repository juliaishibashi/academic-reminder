import SwiftUI
import SQLite3
//これが練習してる場所

struct SamDate: View {
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var isSaved = false
    @State private var due: String = ""
    
    var oneSqlite = OneSqlite()
    
    var body: some View {
        VStack {
            Button(action: {
                showDatePicker.toggle()
                print("Turn on the date picker")
            }) {
                HStack {
                    Text("Due: ")
                    TextField("yyyy-mm-dd, hh:mm", text: $due)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
            }
            .frame(height: 40)
            .foregroundColor(.black)
            .popover(isPresented: $showDatePicker) {
                VStack {
                    DatePicker("選択日時", selection: $selectedDate)
                        .datePickerStyle(.graphical)
                    
                    Text("Selected date: \(selectedDate, format: .dateTime)")
                        .padding()
                        .cornerRadius(10)
                    
                    Button("Save") {
                        if oneSqlite.createOneDB() {
                            saveDateToDatabase(date: selectedDate)
                            isSaved = true
                            //ここを変えた
                            showDatePicker = false
                        } else {
                            print("DB creation failed")
                        }
                    }
                    .disabled(isSaved)
                    
                    Button("Cancel") {
                        selectedDate = Date()
                        isSaved = false
                    }
                }
                .alert(isPresented: $isSaved) {
                    Alert(title: Text("Saved"), message: Text("Date saved"))
                }
            }
            .onAppear {
                if !oneSqlite.createOneDB() {
                    print("DB creation failed on appear")
                }
            }
        }
    }
        func saveDateToDatabase(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        let insertQuery = "INSERT INTO dates (date) VALUES (?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(oneSqlite.dbPointer, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (dateString as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Date saved to database")
            } else {
                print("Failed to save date")
            }
            sqlite3_finalize(statement)
        } else {
            print("Failed to prepare insert statement")
        }
    }
}

class OneSqlite: NSObject {
    var dbPointer: OpaquePointer?
    let dbfile: String = "sample.db"
    
    func createOneDB() -> Bool {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(self.dbfile)
        print("Database Path: \(filePath.path)")
        self.dbPointer = nil
        if sqlite3_open(filePath.path, &self.dbPointer) == SQLITE_OK {
            let createTableQuery = """
            CREATE TABLE IF NOT EXISTS dates (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                date TEXT NOT NULL
            );
            """
            if sqlite3_exec(dbPointer, createTableQuery, nil, nil, nil) == SQLITE_OK {
                return true
            } else {
                print("Failed to create table")
                return false
            }
        } else {
            print("DB error")
            return false
        }
    }
}

#Preview {
    SamDate()
}

