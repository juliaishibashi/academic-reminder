import SwiftUI

struct ReminderView: View {
    @Binding var showAddReminderSheet: Bool
    @Binding var reminderTimes: [String]
    @State private var reminders: [Reminder] = [Reminder(remindValue: "", selectedOption: "")]
    
    @State private var intError: String?
    
    private var dbManager = ReminderDatabaseManager()
    
    init(showAddReminderSheet: Binding<Bool>, reminderTimes: Binding<[String]>) {
        self._showAddReminderSheet = showAddReminderSheet
        self._reminderTimes = reminderTimes
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Reminder: ")
                Button(action: {
                    reminders.append(Reminder(remindValue: "", selectedOption: ""))
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                Spacer()
            }
            .padding()
            
            ForEach(reminders.indices, id: \.self) { index in
                AddReminderView(reminder: $reminders[index])
                    .id(index)
            }

            // Save button
            Button(action: {
                for reminder in reminders {
                    print("Checking reminder with value: \(reminder.remindValue) and option: \(reminder.selectedOption)")
                    dbManager.saveReminder(
                        remindValue: reminder.remindValue,
                        selectedOption: reminder.selectedOption
                    )
                }
                print("SAVED TO REMINDER DB: \(reminders.map { "\($0.remindValue) \($0.selectedOption)" }.joined(separator: ", "))")
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
        @Binding var reminder: Reminder
        
        var body: some View {
            HStack {
                VStack {
                    HStack {
                        Text("Remind: ")
                        TextField("Input integer", text: $reminder.remindValue)
                            .frame(width: 50, height: 32)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Menu {
                            Button(action: {
                                reminder.selectedOption = "Minutes"
                            }) {
                                Text("Minutes")
                            }
                            Button(action: {
                                reminder.selectedOption = "Hours"
                            }) {
                                Text("Hours")
                            }
                            Button(action: {
                                reminder.selectedOption = "Days"
                            }) {
                                Text("Days")
                            }
                            Button(action: {
                                reminder.selectedOption = "Weeks"
                            }) {
                                Text("Weeks").fixedSize()
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 100, height: 32)
                                
                                HStack {
                                    Text(reminder.selectedOption)
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
                    // この行で reminder を reminders 配列から削除
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(showAddReminderSheet: .constant(false), reminderTimes: .constant([]))
    }
}
