//
//  Home.swift
//  academic_reminder
//
//  Created by Julia on 2024-08-21.
//

import SwiftUI

struct Home: View {
    
    @State var currentDate: Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){//DatePickerView
                DatePickerView(currentDate: $currentDate)
            }
        }
    }
}

#Preview {
    Home()
}
