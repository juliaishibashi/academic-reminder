////
////  AssignmentsHolder.swift
////  academic-reminder
////
////  Created by Julia on 2024-08-29.
////
//
//import SwiftUI
//
//struct AssignmentsHolderView: View {
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
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.gray, lineWidth: 1)
//                                .frame(height: 32)
//                            
//                            HStack {
//                                Text(assignment.status)
//                                Spacer()
//                                Image(systemName: "arrowtriangle.down.fill")
//                                    .padding(.trailing, 10)
//                            }
//                        }
//                        //                    } label: {
//                        //                        HStack {
//                        //                            Text(assignment.status)
//                        //                                .padding(.leading, 10)
//                        //                            Spacer()
//                        //                            Image(systemName: "arrowtriangle.down.fill")
//                        //                                .padding(.trailing, 10)
//                        //                        }
//                        //                    }
//                    }
//                    .padding(.horizontal)
//                    
//                    Text(assignment.type + " (" + assignment.weight + " %) - " + assignment.course)
//                    Text("Due: \(formattedDueDate)")
//                }
//            }
//        }
//        var formattedDueDate: String {
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: assignment.due)
//            let day = components.day ?? 0
//            let month = components.month ?? 0
//            let year = components.year ?? 0
//            let hour = components.hour ?? 0
//            let minute = components.minute ?? 0
//            return String(format: "%02d-%02d-%04d %02d:%02d", day, month, year, hour, minute)
//        }
//    }
//}//AssignmentsHolderView
//
////struct Assignment: Identifiable {
////    var id = UUID()
////    var name: String
////    var status: String
////    var course: String
////    var due: Date
////    var type: String
////    var weight: String
////}
//
//struct AssignmentsHolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentsHolderView(assignment: .constant(Assignment(
//            name: "Sample Assignment",
//            status: "Not started",
//            course: "Math 101",
//            due: Date(),
//            type: "Homework",
//            weight: "10"
//        )))
//    }
//}
