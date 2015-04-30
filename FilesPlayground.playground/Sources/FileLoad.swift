//
//  FileLoad.swift
//
//  Created by Anthony Levings on 25/06/2014.

//

import Foundation

public struct FileLoad {
    
    
    public static func loadData(path:String, directory:NSSearchPathDirectory, subdirectory:String?) -> NSData?
    {
        
        let loadPath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        // load the file and see if it was successful
        let data = NSFileManager.defaultManager().contentsAtPath(loadPath)
        // Return data
        return data
        
    }
    
    
    public static func loadDataFromTemporaryDirectory(path:String, subdirectory:String?) -> NSData?
    {
        
        
        let loadPath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let data = NSFileManager.defaultManager().contentsAtPath(loadPath)
        
        // Return status of file save
        return data
        
        
    }
    
    
    // string methods
    
    public static func loadString(path:String, directory:NSSearchPathDirectory, subdirectory:String?, encoding enc:NSStringEncoding = NSUTF8StringEncoding) -> String?
    {
        let loadPath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        
        var error:NSError?
        println(loadPath)
        // Save the file and see if it was successful
        let text:String? = String(contentsOfFile:loadPath, encoding:enc, error: &error)
        
        
        return text
        
    }
    
    
    public static func loadStringFromTemporaryDirectory(path:String, subdirectory:String?, encoding enc:NSStringEncoding = NSUTF8StringEncoding) -> String? {
        
        let loadPath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        var error:NSError?
        println(loadPath)
        // Save the file and see if it was successful
        var text:String? = String(contentsOfFile:loadPath, encoding:enc, error: &error)
        
        
        return text
        
    }
    
    
    
    // private methods
    
    private static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested load path
        loadPath += newPath
        return loadPath
    }
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) -> String {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = FileDirectory.applicationTemporaryDirectory(),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        return loadPath
    }
    
    
    
    
    
}
