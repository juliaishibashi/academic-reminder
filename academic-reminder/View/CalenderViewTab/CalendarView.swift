import SwiftUI

//struct OnChangeSmp: View {
//    @State private var searchText = ""
//    @State private var results: [String] = []
//    private let allItems = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape"]
//
//    var body: some View {
//        NavigationStack {
//            List(results, id: \.self) { item in
//                Text(item)
//            }
//            .searchable(text: $searchText)
//            .onChange(of: searchText) {
//                searchItems(query: searchText)
//            }
//        }
//    }
//
//    private func searchItems(query: String) {
//        if query.isEmpty {
//            results = allItems
//        } else {
//            results = allItems.filter { $0.lowercased().contains(query.lowercased()) }
//        }
//    }
//}

struct OnChangeSmp: View {
    @State private var text = ""

    var body: some View {
        VStack {
            TextField("Enter text", text: $text)
            Text("Current text: \(text)")
        }
//        .onChange(of: text, initial: false) {
        .onChange(of: text) {
            print("Text changed to: \(text)")
        }
    }
}

#Preview {
    OnChangeSmp()
}

