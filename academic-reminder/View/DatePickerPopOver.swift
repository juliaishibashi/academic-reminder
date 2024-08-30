//import SwiftUI
//
//struct DatePickerPopOver: View {
//    @State private var date = Date()
//    @State private var selectedDate: String = ""
//    
//    init() {
//            let calendar = Calendar.current
//            var components = calendar.dateComponents([.year, .month, .day], from: Date())
//            components.hour = 23
//            components.minute = 59
//            _date = State(initialValue: calendar.date(from: components) ?? Date())
//        }
//
//    
//    private var dbManager = DatabaseManager()
//    
//    var body: some View {
//        VStack {
//            DatePicker(
//                "Due Date: ",
//                selection: $date,
//                in: Date()...,
//                displayedComponents: [.date, .hourAndMinute]
//            )
//            .onChange(of: date) { oldDate, newDate in
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .medium
//                dateFormatter.timeStyle = .short
//                selectedDate = dateFormatter.string(from: newDate)
//                print("SELECTED DATE: \(selectedDate)")
//            } //onChange
//            .padding()
//                   
//            Button(action: {
//            dbManager.saveAssi(date: date)
//            print("SAVED TO DB AS: \(selectedDate)")
//            }) {
//                Text("Save")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }//vstack
//        .padding()
//    }
//}
//                   
//struct DateSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePickerPopOver()
//    }
//}
//
//
