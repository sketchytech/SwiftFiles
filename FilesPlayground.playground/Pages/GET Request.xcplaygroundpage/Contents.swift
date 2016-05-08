//: [Previous](@previous)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

if let url = NSURL(string: "https://itunes.apple.com/lookup?id=909253") {
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    let dataTask = session.dataTaskWithURL(url, completionHandler: {(d,_,_) in
        if let data = d {
            defer {
                XCPlaygroundPage.currentPage.finishExecution()
            }
            do {
            try FileSave.saveData(data, directory: NSSearchPathDirectory.DocumentDirectory, path: "myFile.txt", subdirectory: "Data")
                FileDirectory.applicationDirectory(.DocumentDirectory) // location of Data folder containing file we just saved
            }
            catch {
                print("error!")
            }
            
        }
    })
    
    dataTask.resume()
}

//: [Next](@next)
