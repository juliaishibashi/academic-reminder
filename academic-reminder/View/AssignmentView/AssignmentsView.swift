import SwiftUI
import SwiftData

struct AssignmentsView: View {
    @Environment(\.modelContext) private var context
    @Query private var assignments: [Assignment]
    
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
            
            List {
                ForEach(assignments.sorted {
                    // "Done" to bottom
                    $0.status == AssignmentStatus.done.rawValue ? false : $1.status == AssignmentStatus.done.rawValue
                }, id: \.id) { assignment in
                    AssignmentsHolderView(assignment: assignment)
                }
            }
        } 
    }
}

#Preview {
    AssignmentsView()
}

