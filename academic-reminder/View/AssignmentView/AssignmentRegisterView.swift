import SwiftUI
import SwiftData

struct AssignmentRegisterView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var assignment_quiery: [Assignment]
    @Query private var reminder_quiery: [Reminder]

    
    @Binding var showAddAssignmentSheet: Bool
    
    @State private var newAssignmentName: String = ""
    @State private var newCourseName: String = ""
    @State private var selectedType: String = ""
    @State private var newWeight: String = ""
    
    //error handring for weight
    @State private var weightError: String?
    
    //initialized due time as 23:59
    @State private var date: Date = {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = 23
        components.minute = 59
        return calendar.date(from: components) ?? Date()
    }()
    
    @State private var selectedDate: String = ""
    
    @State private var showAddReminderSheet: Bool = false
    @State private var reminders: [Reminder] = []

        
    init(showAddAssignmentSheet: Binding<Bool>) {
        self._showAddAssignmentSheet = showAddAssignmentSheet
    }
    
    var body: some View {
        VStack{
            Text("Assignments")
                .font(.title.bold())
            
            HStack {
                Text("Title:")
                TextField("Enter assignment title", text: $newAssignmentName)
                    .padding()
            }//assignment title
            .onChange(of: newAssignmentName) { oldName, newName in
                print("SELECTED NAME: \(newAssignmentName)")
            }//onChange
            
            HStack {
                Text("Course:")
                TextField("Course", text: $newCourseName)
                    .padding()
            } // course
            .onChange(of: newCourseName) { oldName, newName in
                print("COURSE NAME: \(newCourseName)")
            }//onChange
            
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
            } //h
            .onChange(of: selectedType) { oldType, newType in
                print("COURSE TYPE: \(selectedType)")
            }//onChange
            
            HStack {
                Text("Weight:")
                TextField("Enter Weight", text: $newWeight)
                    .padding()
                    .keyboardType(.numberPad)
            }//weight
            .onChange(of: newWeight) { oldValue, newValue in
                print("COURSE WEIGHT: \(newWeight)")
                if let _ = Int32(newValue) {
                    weightError = nil
                } else {
                    weightError = "Please enter a valid integer value"
                }
            }//onChange
            
            .overlay(
                Group {
                    if let weightError = weightError {
                        Text(weightError)
                            .padding()
                            .foregroundColor(.red)
                    }
                },
                alignment: .topTrailing
            ) //error msg
            
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
                .sheet(isPresented: $showAddReminderSheet) {
                    ReminderView(showAddReminderSheet: $showAddReminderSheet, reminders: $reminders)
                }
            } //reminder
            ForEach(reminders, id: \.self) { reminder in
                Text(" Reminders: \(reminder.remindValue)\(reminder.selectedOption)")
            }

            Button(action: {
                //create and save the assignmnet to the context
                let newAssignemt = Assignment(
                    title: newAssignmentName,
                    courseName: newCourseName,
                    type: selectedType,
                    weight: newWeight,
                    date: selectedDate,
                    status: ""
                )
                
                context.insert(newAssignemt)
                
                for reminder in reminders {
                    context.insert(reminder)
                    print("REMINDER - Saving reminder with value:  \(reminder.id), \(reminder.remindValue), option: \(reminder.selectedOption)")
                }
                
                print("ASSIFNMENT - Saving new assignment: \(newAssignemt.id), Title: \(newAssignemt.title), Course: \(newAssignemt.courseName), Type: \(newAssignemt.type), Weight: \(newAssignemt.weight), Due Date: \(newAssignemt.date)")
                
//                for assignment in assignment_quiery {
//                    print("DEBUG - Assignment ID: \(assignment.id), Title: \(assignment.title), Course: \(assignment.courseName), Type: \(assignment.type), Weight: \(assignment.weight), Due Date: \(assignment.date), Reminder: \(assignment.remindValue), \(assignment.selectedOption)")
//                }
                showAddAssignmentSheet = false
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
//            ForEach(assignment_quiery, id: \.id) { assignment in
//                print("Assignment: \(assignment.title), Course: \(assignment.courseName)")
//            }
        }// Whole vstack
        .foregroundColor(.black)
        .padding(.leading, 15)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct AssignmentRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentRegisterView(showAddAssignmentSheet: .constant(false))
            .modelContainer(for: Assignment.self)
    }
}
