//: Playground - noun: a place where people can play

import UIKit


FileSave.saveStringToTemporaryDirectory("hello World", path: "myString.txt", subdirectory: "")
FileSave.applicationTemporaryDirectory()

FileSave.saveString("hello world", directory: NSSearchPathDirectory.DocumentDirectory, path: "myString.txt", subdirectory: "MyFiles")
FileSave.applicationDirectory(NSSearchPathDirectory.DocumentDirectory)


FileLoad.loadString("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles", encoding: NSUTF8StringEncoding)
FileDelete.deleteFile("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles")
FileLoad.loadString("myString.txt", directory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "MyFiles", encoding: NSUTF8StringEncoding) // returns nil file is deleted

let data = "Hello Swift".dataUsingEncoding(NSUTF8StringEncoding)!
FileSave.saveData(data, directory: NSSearchPathDirectory.CachesDirectory, path: "myFile.txt", subdirectory: "Data")

FileLoad.loadData("myFile.txt", directory: NSSearchPathDirectory.CachesDirectory, subdirectory: "Data") == data // true