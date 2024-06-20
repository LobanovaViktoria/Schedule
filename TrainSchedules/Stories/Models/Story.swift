import Foundation

struct Stories: Hashable, Identifiable {
    var id = UUID()
    var items: [Story]
    var isItShown: Bool
}

struct Story: Hashable, Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var subTitle: String
}
