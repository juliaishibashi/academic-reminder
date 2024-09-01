import SwiftUI

struct AssignmentsView: View {
    @State private var showAddAssignmentSheet = false
    @State private var assignments: [Assignment] = []
    
    private var dbManager = AssignmentDatabaseManager()
    
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
                    .onDisappear {
                        assignments = dbManager.fetchAssignments()
                    }
            }
            
            List(assignments) { assignment in
                AssignmentsHolderView(assignment: assignment)
            }
        } // vstack
        .onAppear {
            assignments = dbManager.fetchAssignments()
        }
    }
}

struct AssignmentsHolderView: View {
    var assignment: Assignment

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 100)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 0.8))

            VStack {
                HStack {
                    Text(assignment.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)

                    Menu {
                        Button(action: {
                            assignment.status = "Not started"
                        }) {
                            Text("Not started")
                        }

                        Button(action: {
                            assignment.status = "In progress"

                        }) {
                            Text("In progress")
                        }

                        Button(action: {
                            assignment.status = "Done"
                        }) {
                            Text("Done")
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(height: 32)

                            HStack {
                                Text("Status")
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    .padding(.horizontal)

                    Text(assignment.type + " (" + assignment.weight + " %) - " + assignment.courseName)
                    Text("Due: \(assignment.date)")
                }
            }
        }
    }
}

#Preview {
    AssignmentsView()
}

