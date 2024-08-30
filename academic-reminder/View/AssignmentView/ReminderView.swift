import SwiftUI

struct ReminderView: View {
    @Binding var showAddReminderSheet: Bool
    @Binding var reminderTimes: [String]
    @State private var reminders: [Reminder] = [Reminder(remindValue: "", selectedOption: "")]

    
    private var dbManager = DatabaseManager()
    
    init(showAddReminderSheet: Binding<Bool>, reminderTimes: Binding<[String]>) {
        self._showAddReminderSheet = showAddReminderSheet
        self._reminderTimes = reminderTimes
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Reminder: ")
                Button(action: {
//                    reminders.append(Reminder(remindValue: "", selectedOption: ""))
                    for reminder in reminders {
                                        reminderTimes.append("\(reminder.remindValue) \(reminder.selectedOption) Before")
                                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                Spacer()
            }
            .padding()
            
            ForEach(reminders.indices, id: \.self) { index in
                AddReminderView(reminderIndex: index, reminders: $reminders)
                    .id(index)
            }

            // Save button
            Button(action: {
                // Save the reminder data here if needed
                // dbManager.saveData(remindValue, selectedOption)
                reminderTimes = reminders.map { "\($0.remindValue) \($0.selectedOption) Before" }

                // Then close the sheet
                showAddReminderSheet = false
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
    }
    
    struct Reminder {
        var remindValue: String
        var selectedOption: String
    }
    
    struct AddReminderView: View {
        let reminderIndex: Int
        @Binding var reminders: [Reminder]
        @State private var remindValue: String = ""
        @State private var selectedOption: String = ""
        
        var body: some View {
            HStack {
                VStack {
                    HStack {
                        Text("Remind: ")
                        TextField("Input integer", text: $remindValue)
                            .frame(width: 50, height: 32)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Menu {
                            Button(action: {
                                selectedOption = "Minutes"
                            }) {
                                Text("Minutes")
                                    .padding()
                            }
                            Button(action: {
                                selectedOption = "Hours"
                            }) {
                                Text("Hours")
                            }
                            Button(action: {
                                selectedOption = "Days"
                            }) {
                                Text("Days")
                            }
                            Button(action: {
                                selectedOption = "Weeks"
                            }) {
                                Text("Weeks").fixedSize()
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 100, height: 32)
                                
                                HStack {
                                    Text(selectedOption)
                                        .frame(maxWidth: 100, alignment: .leading)
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        Text(" Before")
                            .padding()
                    }
                    .fixedSize()
                }
                Button(action: {
                    reminders.remove(at: reminderIndex)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
        } // vstack
    } // AddReminderView
}  //reminderview

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(showAddReminderSheet: .constant(false), reminderTimes: .constant([]))
    }
}

