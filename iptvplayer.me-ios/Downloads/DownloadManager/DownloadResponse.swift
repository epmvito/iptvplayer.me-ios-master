import Foundation

class Movie{

    let url: URL
    
    var downloaded = false
    
    init(url: URL){
        self.url = url
    }
}
