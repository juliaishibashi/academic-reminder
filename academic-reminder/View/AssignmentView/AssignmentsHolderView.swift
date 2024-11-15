import SwiftUI
import SwiftData

enum AssignmentStatus: String {
    case notStarted = "Not started"
    case inProgress = "In progress"
    case done = "Done"
}

struct AssignmentsHolderView: View {
    @Environment(\.modelContext) private var context
    var assignment: Assignment
    var onStatusChanged: (() -> Void)?
    
    @State private var currentStatus: String
    
    init(assignment: Assignment, onStatusChanged: (() -> Void)? = nil) {
        self.assignment = assignment
        self.onStatusChanged = onStatusChanged
        _currentStatus = State(initialValue: assignment.status.isEmpty ? "Status" : assignment.status)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 100)
                .foregroundColor(currentStatus == AssignmentStatus.done.rawValue ? Color.gray.opacity(0.2) : Color(red: 1.0, green: 1.0, blue: 0.8))
            
            VStack {
                HStack {
                    Text(assignment.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)

                    Menu {
                        Button(action: {
                            updateStatus(for: assignment, to: .notStarted)
                        }) {
                            Text("Not started")
                        }
                        Button(action: {
                            updateStatus(for: assignment, to: .inProgress)
                        }) {
                            Text("In progress")
                        }
                        Button(action: {
                            updateStatus(for: assignment, to: .done)
                        }) {
                            Text("Done")
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(height: 32)
                            HStack {
                                Text(currentStatus)
                                    .padding(.leading, 10)
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Text(assignment.type + " (" + assignment.weight + " %) - " + assignment.courseName)
                Text("Due: \(assignment.date)")
            }
        }
        .swipeActions {
            Button(role: .destructive) {
                deleteAssignment(assignment)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
    
    private func deleteAssignment(_ assignment: Assignment) {
        context.delete(assignment)
        try? context.save()
        let displayName = assignment.courseName.isEmpty ? "\(assignment.id)" : assignment.courseName
        print("Deleted: \(displayName)")
        printRemainingData()
    }
    
    private func printRemainingData() {
        // Create a fetch descriptor to fetch all assignments
        let assignmentDescriptor = FetchDescriptor<Assignment>()
        
        // Fetch all assignments using the descriptor
        let allAssignments: [Assignment] = try! context.fetch(assignmentDescriptor)
        
        // Fetch all reminders using a similar fetch descriptor
        let reminderDescriptor = FetchDescriptor<Reminder>()
//        let allReminders: [Reminder] = try! context.fetch(reminderDescriptor)
        
        // Print remaining assignments
        print("Remaining Assignments:")
        for assignment in allAssignments {
            print("Assignment ID: \(assignment.id), Title: \(assignment.title), Course: \(assignment.courseName), Type: \(assignment.type), Weight: \(assignment.weight), Due Date: \(assignment.date)")
            
            // Print related reminders for each assignment
            for reminder in assignment.children {
                print("  - Reminder ID: \(reminder.id), Value: \(reminder.remindValue), Option: \(reminder.selectedOption)")
            }
        }
        // Print all reminders
//        print("Remaining Reminders:")
//        for reminder in allReminders {
//            print("Reminder ID: \(reminder.id), Value: \(reminder.remindValue), Option: \(reminder.selectedOption)")
//        }
    }

    private func updateStatus(for assignment: Assignment, to status: AssignmentStatus) {
        let oldStatus = assignment.status
        assignment.status = status.rawValue
        currentStatus = status.rawValue // @State
        context.insert(assignment)
        try? context.save()

        print("\(assignment.courseName): Previous Status: \(oldStatus), New Status: \(assignment.status)")
        
        onStatusChanged?()
    }
}

