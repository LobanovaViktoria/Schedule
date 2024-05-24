import Foundation

struct Stories: Hashable, Identifiable {
    var id = UUID()
    var items: [Story]
}

struct Story: Hashable, Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var subTitle: String
}
