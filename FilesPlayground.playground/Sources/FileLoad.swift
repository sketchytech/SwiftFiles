//
//  FileLoad.swift
//
//  Created by Anthony Levings on 25/06/2014.

//

import Foundation

public struct FileLoad {
    
    public static func loadData(path:String, directory:NSSearchPathDirectory, subdirectory:String?) -> NSData?
    {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = applicationDirectory(directory),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        
        // Save the file and see if it was successful
        let data = NSFileManager.defaultManager().contentsAtPath(loadPath)
        
        // Return status of file save
        return data
        
    }

    
   public static func loadDataFromTemporaryDirectory(path:String, subdirectory:String?) -> NSData?
    {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = self.applicationTemporaryDirectory(),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        
        println(loadPath)
        // Save the file and see if it was successful
        let data = NSFileManager.defaultManager().contentsAtPath(loadPath)
        
        // Return status of file save
        return data
        
       
    }
    
   
    
    // string methods
    
   public static func loadString(path:String, directory:NSSearchPathDirectory, subdirectory:String?, encoding enc:NSStringEncoding = NSUTF8StringEncoding) -> String?
    {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = applicationDirectory(directory),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath

        var error:NSError?
        println(loadPath)
        // Save the file and see if it was successful
        let text:String? = String(contentsOfFile:loadPath, encoding:enc, error: &error)
        
        
        return text
        
    }
    
   
    public static func loadStringFromTemporaryDirectory(path:String, subdirectory:String?, encoding enc:NSStringEncoding = NSUTF8StringEncoding) -> String? {
        
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = self.applicationTemporaryDirectory(),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        
        var error:NSError?
        println(loadPath)
        // Save the file and see if it was successful
        var text:String? = String(contentsOfFile:loadPath, encoding:enc, error: &error)
        
        
        return text
        
    }
    
       
    
    // private methods
    
    //directories
    private static func applicationDirectory(directory:NSSearchPathDirectory) -> NSURL? {
        
        var appDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true);
        if paths.count > 0 {
            if let pathString = paths[0] as? String {
                appDirectory = pathString
            }
        }
        if let dD = appDirectory {
            return NSURL(string:dD)
        }
        return nil
    }
    
    
    
    
    private static func applicationTemporaryDirectory() -> NSURL? {
        
        if let tD = NSTemporaryDirectory() {
            return NSURL(string:tD)
        }
        
        return nil
        
    }
    
    //pragma mark - strip slashes
    
    private static func stripSlashIfNeeded(stringWithPossibleSlash:String) -> String {
        var stringWithoutSlash:String = stringWithPossibleSlash
        // If the file name contains a slash at the beginning then we remove so that we don't end up with two
        if stringWithPossibleSlash.hasPrefix("/") {
            stringWithoutSlash = stringWithPossibleSlash.substringFromIndex(advance(stringWithoutSlash.startIndex,1))
        }
        // Return the string with no slash at the beginning
        return stringWithoutSlash
    }
    
    
   
}
