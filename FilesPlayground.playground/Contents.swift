//: Playground - noun: a place where people can play

import Foundation

do {
    try FileSave.saveStringToTemporaryDirectory("hello World", path: "myString.txt", subdirectory: "")
    try FileSave.saveString("hello world", directory: NSSearchPathDirectory.DocumentDirectory, path: "myString.txt", subdirectory: "MyFiles")
    try FileLoad.loadString("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles", encoding: NSUTF8StringEncoding)
    
    
    let data = "Hello Swift My Friend!".dataUsingEncoding(NSUTF8StringEncoding)!
    try FileSave.saveData(data, directory: NSSearchPathDirectory.CachesDirectory, path: "myFile.txt", subdirectory: "Data")
    FileLoad.loadData("myFile.txt", directory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data") == data // true
    
    for files in try FileList.allFilesAndFolders(inDirectory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data")! {
        files
    }
    
    // find out the location of your files to use in Finder -> Go -> Go to Directory dialogue box
    FileDirectory.applicationDirectory(NSSearchPathDirectory.DocumentDirectory)
    FileDirectory.applicationTemporaryDirectory()
    
    for files in try FileList.allFilesAndFoldersInTemporaryDirectory(nil)! {
        files
    }
    // Clean up, deleting files
    try FileDelete.deleteFile("myFile.txt", directory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data")
    try FileDelete.deleteFile("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles")
    try FileDelete.deleteFileFromTemporaryDirectory("myString.txt", subdirectory: "")

    
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
