//
//  DatePickerViewPopOver.swift
//  academic_reminder
//
//  Created by Julia on 2024-08-21.
//

import SwiftUI

struct DatePickerViewPopover: View {
    @Binding var selectedDate: Date
    @State private var showDatePicker: Bool = false
    @State private var due: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Text("Due Date:")
                    TextField("Enter Due Date", text: $due)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .popover(isPresented: $showDatePicker) {
                    DatePickerView(currentDate: $selectedDate)
                        .frame(width: 300, height: 350)
                }
            }
        }.foregroundColor(.black)
            .frame(height: 40)
            .padding(.leading, 10)
        
    }
}
struct DatePickerViewPopover_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerViewPopover(selectedDate: .constant(Date()))
    }
}
