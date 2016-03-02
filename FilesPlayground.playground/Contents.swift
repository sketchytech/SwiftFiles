//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

do {
    try FileSave.saveStringToTemporaryDirectory("hello World", path: "myString.txt", subdirectory: "")
    try FileSave.saveString("hello world", directory: NSSearchPathDirectory.DocumentDirectory, path: "myString.txt", subdirectory: "MyFiles")
     try FileSave.saveString("hello world", directory: NSSearchPathDirectory.DocumentDirectory, path: "yourString.txt", subdirectory: "MyFiles")
    try FileLoad.loadString("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles", encoding: NSUTF8StringEncoding)

    do {
        try FileMove.move("yourString.txt", fromDirectory: .DocumentDirectory, fromSubdirectory: "MyFiles", toPath: "yourString.txt", toDirectory: .DocumentDirectory, toSubdirectory: "OurFiles")
    }
    catch {
        print("error")
    }
      try! FileList.allFilesAndFolders(inDirectory: .DocumentDirectory, subdirectory: "OurFiles")
    
    let data = "Hello Swift My Friend!".dataUsingEncoding(NSUTF8StringEncoding)!
    try FileSave.saveData(data, directory: NSSearchPathDirectory.CachesDirectory, path: "myFile.txt", subdirectory: "Data")
    FileLoad.loadData("myFile.txt", directory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data") == data // true
    do {
        if let files = try FileList.allFilesAndFolders(inDirectory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data") {
        for file in files {
            print("Filename:\(file.lastPathComponent!) NSURL:\(file)") //
            }
        }
        else {
            print("failed to find given location")
        }

    }
    catch  {
        print("error occurred")
    }
    
    // find out the location of your files to use in Finder -> Go -> Go to Directory dialogue box
    FileDirectory.applicationDirectory(NSSearchPathDirectory.DocumentDirectory)
    FileDirectory.applicationTemporaryDirectory()
    
    for files in try FileList.allFilesAndFolders(inDirectory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "OurFiles")! {
        files
    }
    // Clean up, deleting files
    try FileDelete.deleteFile("myFile.txt", directory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data")
    try FileDelete.deleteFile("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles")
   try FileDelete.deleteFile("yourString.txt", directory: NSSearchPathDirectory.ApplicationDirectory, subdirectory: "OurFiles")

    
}
catch _ {
    print("error")
}

do {
    try FileLoad.loadString("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles", encoding: NSUTF8StringEncoding) // throws error because file is deleted
}
catch _ {
    print("error, because file was deleted")
}


XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
let downloadURL = FileDirectory.applicationDirectory(.DocumentDirectory)
let newLocation = downloadURL!.URLByAppendingPathComponent("folder/my.pdf")
class SessionDelegate:NSObject, NSURLSessionDownloadDelegate {
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print(error)
    }
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
       try? FileDelete.deleteFile(newLocation.path!, directory: .DocumentDirectory, subdirectory: "folder")
            do {
             try NSFileManager.defaultManager().moveItemAtURL(location, toURL: newLocation)
                
            }
            catch {
                print("error")
            }

        NSFileManager.defaultManager().subpathsAtPath(downloadURL!.URLByAppendingPathComponent("folder").path!)

        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("did write data: \(bytesWritten)")
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("did resume data")
    }
}
if let downloadURL = FileDirectory.applicationDirectory(.DocumentDirectory) {
    let newLocation = downloadURL.URLByAppendingPathComponent("folder") //
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


