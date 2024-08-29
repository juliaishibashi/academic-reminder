import SwiftUI

struct DetailView: View {
    @Binding var showDetailView: Bool
    @Binding var darkMode: Bool
    //binging has to be connect with state propertiy
    
    var body: some View {
        VStack{
            Button{
                showDetailView.toggle()
                darkMode.toggle()
            } label: {
                Text("dismiss")
            }
            Toggle(isOn: $darkMode){
                Text("dark mode")
                    .foregroundStyle(darkMode ? .white : .black)
            }
        }
    }
}
    
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(showDetailView: .constant(false), darkMode: .constant(false))
    }
}
