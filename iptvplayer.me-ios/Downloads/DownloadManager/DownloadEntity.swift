import Foundation

class Download {
  
  var isDownloading = false
  var progress: Float = 0
  var resumeData: Data?
  var task: URLSessionDownloadTask?
  var movie: Movie
  
  init(movie: Movie) {
    self.movie = movie
  }
}
