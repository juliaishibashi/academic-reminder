//
//  Assignment.swift
//  academic-reminder
//
//  Created by Julia on 2024-08-31.
//

import Combine

class Assignment: ObservableObject, Identifiable {
    var id: Int
    @Published var title: String
    @Published var courseName: String
    @Published var type: String
    @Published var weight: String
    @Published var date: String
    @Published var status: String

    init(id: Int, title: String, courseName: String, type: String, weight: String, date: String, status: String) {
        self.id = id
        self.title = title
        self.courseName = courseName
        self.type = type
        self.weight = weight
        self.date = date
        self.status = status
    }
}

