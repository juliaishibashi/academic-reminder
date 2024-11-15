////
////  Reminder.swift
////  academic-reminder
////
////  Created by Julia on 2024-11-12.
////
import Foundation
import SwiftData


@Model
final class Reminder: Hashable{
    
    @Attribute(.unique)
    var id: UUID
    var remindValue: String
    var selectedOption: String
    
    var parent: Assignment?
    
    init(remindValue: String, selectedOption: String) {
        self.id = UUID()
        self.remindValue = remindValue
        self.selectedOption = selectedOption
    }
}

//struct Reminder: Hashable{
//    var remindValue: String
//    var selectedOption: String
//}
