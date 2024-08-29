//
//  AssignmentRegisterView.swift
//  academic-reminder
//
//  Created by Julia on 2024-08-29.
//

import SwiftUI

struct AssignmentRegisterView: View {
    @State private var newAssignmentName: String = ""
    @State private var newCourseName: String = ""
    @State private var selectedType: String = ""
    @State private var newWeight: String = ""
    @State private var date = Date()
    @State private var selectedDate: String = ""
    
    @State private var showAddReminderSheet: Bool = false
    
    init() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 23
        components.minute = 59
        _date = State(initialValue: calendar.date(from: components) ?? Date())
    }
    
    private var dbManager = DatabaseManager()
    
    var body: some View {
        VStack{
            Text("Assignments")
                .font(.title.bold())
            
            HStack {
                Text("Title:")
                TextField("Enter assignment title", text: $newAssignmentName)
                    .padding()
            } // title
            
            HStack {
                Text("Course:")
                TextField("Course", text: $newCourseName)
                    .padding()
            } // course
            
            HStack {
                Text("Type:")
                Menu {
                    Button(action: {
                        selectedType = "Assignment"
                    }) {
                        Text("Assignment")
                    }
                    
                    Button(action: {
                        selectedType = "Quiz"
                    }) {
                        Text("Quiz")
                    }
                    
                    Button(action: {
                        selectedType = "Exam"
                    }) {
                        Text("Exam")
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 32)
                        
                        HStack {
                            Text(selectedType)
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .padding(.trailing, 10)
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                Text("Weight:")
                TextField("Enter Weight", text: $newWeight)
                    .padding()
            }
            
            VStack {
                DatePicker(
                    "Due Date: ",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .onChange(of: date) { oldDate, newDate in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    dateFormatter.timeStyle = .short
                    selectedDate = dateFormatter.string(from: newDate)
                    print("SELECTED DATE: \(selectedDate)")
                } //onChange
                .padding()
            }//due date
            
            HStack {
                Text("Reminder: ")
                Button(action: {
                    showAddReminderSheet = true
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .padding()
            } //reminder
            
            Button(action: {
                dbManager.saveDate(date: date)
                print("SAVED TO DB AS: \(selectedDate)")
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }// save botton
        }// Whole vstack
        .ignoresSafeArea()
        .foregroundColor(.black)
        .padding(.leading, 15)
        .textFieldStyle(RoundedBorderTextFieldStyle())

    }
}

#Preview {
    AssignmentRegisterView()
}
