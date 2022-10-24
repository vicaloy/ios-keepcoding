import SwiftUI

struct ListsView: View {
    var body: some View {
        NavigationView {
            List(1..<100) { row in
                NavigationLink(destination: InnerListView()) {
                    Text("Row \(row)")
                }
                .isDetailLink(false)
            }
            .navigationTitle("Outer List")
        }
    }
}

struct InnerListView: View {
    var body: some View {
        List(1..<100) { row in
            NavigationLink(destination: Text("Details for row \(row)")) {
                Text("Row \(row)")
            }
            .isDetailLink(false)
            .navigationTitle("Inner List")
        }
    }
}

struct ListsViewView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
