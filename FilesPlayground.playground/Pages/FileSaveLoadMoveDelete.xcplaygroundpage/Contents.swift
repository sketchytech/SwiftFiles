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



