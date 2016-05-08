//: [Previous](@previous)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
let downloadURL = FileDirectory.applicationDirectory(.DocumentDirectory)
let newLocation = downloadURL!.URLByAppendingPathComponent("PDF/my.pdf")
class SessionDelegate:NSObject, NSURLSessionDownloadDelegate {
    
    
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        defer {
            XCPlaygroundPage.currentPage.finishExecution()
        }
        try? FileDelete.deleteFile(newLocation.path!, directory: .DocumentDirectory, subdirectory: "PDF")
        do {
            
            try NSFileManager.defaultManager().moveItemAtURL(location, toURL: newLocation)
            
        }
        catch {
            print("error")
        }
        
        NSFileManager.defaultManager().subpathsAtPath(downloadURL!.URLByAppendingPathComponent("PDF").path!)
        
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("did write data: \(bytesWritten)")
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("did resume data")
    }
}
if let downloadURL = FileDirectory.applicationDirectory(.DocumentDirectory) {
    let newLocation = downloadURL.URLByAppendingPathComponent("PDF") //
    NSFileManager.defaultManager().subpathsAtPath(downloadURL.URLByDeletingLastPathComponent!.path!)
    try? NSFileManager.defaultManager().createDirectoryAtURL(newLocation, withIntermediateDirectories: true, attributes: nil)
    do {
        try   FileHelper.createSubDirectory(newLocation.path!)
    }
    catch {
        print("create error")
    }
}
// create a background session configuration with identifier
let config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("myConfig")

if let url = NSURL(string: "http://partners.adobe.com/public/developer/en/xml/AdobeXMLFormsSamples.pdf") {
    let delegate = SessionDelegate()
    // create session by instantiating with configuration and delegate
    let session = NSURLSession(configuration: config, delegate: delegate, delegateQueue: NSOperationQueue.mainQueue())
    
    let downloadTask = session.downloadTaskWithURL(url)
    
    downloadTask.resume()
    
}

//: [Next](@next)
