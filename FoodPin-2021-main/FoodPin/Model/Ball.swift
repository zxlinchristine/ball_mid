
import Foundation

//the Hashable protocol is needed for Diffable Data Source
struct Ball: Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var summary: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}

//extend the defintion of an existing structure or class
extension Ball {
    //class-level method function
    static func generateData( sourceArray: inout [Ball]) {
        sourceArray = [
            Ball(name: "baseball", image: "baseball.jpg"),
            Ball(name: "basketball", image: "basketball.jpg"),
            Ball(name: "football", image: "football.jpg"),
            Ball(name: "other",  image: "other.jpg"),
        ]
    }
    
}
