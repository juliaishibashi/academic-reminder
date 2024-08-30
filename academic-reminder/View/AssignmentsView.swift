import SwiftUI

struct AssignmentsView: View {
    @State private var showAddAssignmentSheet = false
    
    var body: some View {
        VStack {
            Text("Assignments")
                .font(.title.bold())
            
            Button(action: {
                showAddAssignmentSheet = true
            }) {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .padding()
            }
            .sheet(isPresented: $showAddAssignmentSheet) {

                AssignmentRegisterView(showAddAssignmentSheet: $showAddAssignmentSheet)
            }
        } // vstack
    }
}

#Preview {
    AssignmentsView()
}


















//import SwiftUI
//
//struct AssignmentsView: View {
//    //    @State private var assignments: [Assignment] = []
//    @State private var showAddAssignmentSheet = false
//    
//    var body: some View {
//        VStack {
//            Text("Assignments")
//                .font(.title.bold())
//            
//            Button(action: {
//                showAddAssignmentSheet = true
//            }) {
//                Spacer()
//                Image(systemName: "plus.circle.fill")
//                    .font(.system(size: 24))
//                    .padding()
//            }
//            
//            //            List {
//            //                ForEach($assignments) {assignment in
//            //                    AssignmentsHolderView(assignment: $assignments)
//            //                }
//            //            }
//            .sheet(isPresented: $showAddAssignmentSheet) {
//                //                AssignmentRegisterView(assignments: $assignments, showAddAssignmentSheet: $showAddAssignmentSheet)
//                AssignmentRegisterView(showAddAssignmentSheet: $showAddAssignmentSheet)
//            }
//        } // vstack
//    }
//    
//    
//    
//}


//struct AssignmentsHolder: View {
//    @Binding var assignment: Assignment
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 15)
//                .frame(width: 350, height: 100)
//                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 0.8))
//
//            VStack {
//                HStack {
//                    Text(assignment.name)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .fontWeight(.semibold)
//
//                    Menu {
//                        Button(action: {
//                            assignment.status = "Not started"
//                        }) {
//                            Text("Not started")
//                        }
//
//                        Button(action: {
//                            assignment.status = "In progress"
//                        }) {
//                            Text("In progress")
//                        }
//
//                        Button(action: {
//                            assignment.status = "Done"
//                        }) {
//                            Text("Done")
//                        }
//                    } label: {
//                        HStack {
//                            Text(assignment.status)
//                                .padding(.leading, 10)
//                            Spacer()
//                            Image(systemName: "arrowtriangle.down.fill")
//                                .padding(.trailing, 10)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//
//                Text(assignment.type + " (" + assignment.weight + " %) - " + assignment.course)
//                Text("Due: \(formattedDueDate)")
//            }
//        }
//    }
//    var formattedDueDate: String {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: assignment.due)
//        let day = components.day ?? 0
//        let month = components.month ?? 0
//        let year = components.year ?? 0
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
//        return String(format: "%02d-%02d-%04d %02d:%02d", day, month, year, hour, minute)
//    }
//}//AssignmentsHolder

//    struct Assignment: Identifiable {
//        var id = UUID()
//        var name: String
//        var status: String
//        var course: String
//        var due: Date
//        var type: String
//        var weight: String
//    }


//
//
//
//
//struct AssignmentRegister: View {
//    @Binding var assignments: [Assignment]
//    @Binding var showAddAssignmentSheet: Bool
//
//    @State private var newAssignmentName: String = ""
//    @State private var newStatus: String = "Not started"
//    @State private var selectedType: String = ""
//    @State private var newCourseName: String = ""
//    @State private var newWeight: String = ""
//    @State private var date: Date = Date()
//    @State private var showDatePickerView: Bool = false
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Name:")
//                TextField("Enter assignment name", text: $newAssignmentName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//            }
//            HStack {
//                Text("Course:")
//                TextField("Course", text: $newCourseName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//            }
//            HStack {
//                Text("Type:")
//                Menu {
//                    Button(action: {
//                        selectedType = "Assignment"
//                    }) {
//                        Text("Assignment")
//                    }
//
//                    Button(action: {
//                        selectedType = "Quiz"
//                    }) {
//                        Text("Quiz")
//                    }
//
//                    Button(action: {
//                        selectedType = "Exam"
//                    }) {
//                        Text("Exam")
//                    }
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.gray, lineWidth: 1)
//                            .frame(height: 32)
//
//                        HStack {
//                            Text(selectedType)
//                                .padding(.leading, 10)
//                            Spacer()
//                            Image(systemName: "arrowtriangle.down.fill")
//                                .padding(.trailing, 10)
//                        }
//                    }
//                }
//                .frame(height: 40)
//                .padding(.leading, 10)
//            }
//            HStack {
//                Text("Weight:")
//                TextField("Enter Weight", text: $newWeight)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//            }
//            HStack {
//                DatePicker(
//                    "Due Date: ",
//                    selection: $date,
//                    in: Date()...,
//                    displayedComponents: [.date, .hourAndMinute]
//                )
//            }
//
//            HStack {
//                Text("Reminder: ")
//                Button(action: {
//                    showAddAssignmentSheet = true
//                }) {
//                    Image(systemName: "plus.circle.fill")
//                        .font(.system(size: 24))
//                        .padding(.leading)
//                }
//                Spacer()
//            }
//            .padding()
//
//            Button("Add Assignment") {
//                let newAssignment = Assignment(
//                    name: newAssignmentName,
//                    status: newStatus,
//                    course: newCourseName,
//                    due: date,
//                    type: selectedType,
//                    weight: newWeight
//                )
//                assignments.append(newAssignment)
//                // Reset fields
//                newAssignmentName = ""
//                newStatus = "Not started"
//                newCourseName = ""
//                date = Date()
//                selectedType = ""
//                newWeight = ""
//                showAddAssignmentSheet = false
//            }
//            Spacer()
//            .padding()
//        }
//        .padding()
//        .foregroundColor(.black)
//    }
//    var formattedDueDate: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
//    }
//}
//
//
