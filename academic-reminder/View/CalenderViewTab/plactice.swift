import SwiftUI

struct plactice: View {
    //state is origin (parent) view
    //binding is detail (child) view
    @State private var darkMode = false
    @State private var showDetailView = false
    
    var body: some View {
        ZStack{
            Color(darkMode ? .black : .white)
            VStack{
                Button{
                    showDetailView.toggle()
                } label: {
                    Text("show detail view")
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showDetailView, content: {
            //if $showDetailView is true it will open DetailView()
            DetailView(showDetailView: $showDetailView, darkMode: $darkMode)
            // "showDetailView: $showDetailView" connect w/ @binding
        })
        .ignoresSafeArea() //上のスペース
    }
}

#Preview {
    plactice()
}
