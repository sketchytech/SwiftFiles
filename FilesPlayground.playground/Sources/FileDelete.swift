//
//  Created by Anthony Levings on 25/06/2014.

//

import Foundation


public struct FileDelete {
    
    public static func deleteFile(path:String, directory:NSSearchPathDirectory,  subdirectory:String?) -> Bool
    {
        let deletePath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        
        // Delete the file and see if it was successful
        var error:NSError?
        let ok:Bool = NSFileManager.defaultManager().removeItemAtPath(deletePath, error: &error)
        
        if error != nil {
            println(error)
        }
        // Return status of file delete
        return ok;
        
    }
    
    
    public static func deleteFileFromTemporaryDirectory(path:String, subdirectory:String?) -> Bool
    {
        let deletePath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        // Delete the file and see if it was successful
        var error:NSError?
        let ok:Bool = NSFileManager.defaultManager().removeItemAtPath(deletePath, error: &error)
        
        if error != nil {
            println(error)
        }
        // Return status of file delete
        return ok
    }
    
    
    // Delete folders
    
    public static func deleteSubDirectory(directory:NSSearchPathDirectory, subdirectory:String) -> Bool
    {
        // Remove unnecessary slash if need
        var subDir = stripSlashIfNeeded(subdirectory)
        
        // Create generic beginning to file delete path
        var deletePath = ""
        
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                deletePath = path + "/"
        }
        
        
        deletePath += subDir
        deletePath += "/"
        
        
        var dir:ObjCBool = true
        let dirExists = NSFileManager.defaultManager().fileExistsAtPath(deletePath, isDirectory:&dir)
        if dir.boolValue == false {
            return false
        }
        if dirExists == false {
            return false
        }
        
        
        // Delete the file and see if it was successful
        var error:NSError?
        let ok:Bool = NSFileManager.defaultManager().removeItemAtPath(deletePath, error: &error)
        
        
        if error != nil {
            println(error)
        }
        // Return status of file delete
        return ok
        
    }
    
    
    
    
    public static func deleteSubDirectoryFromTemporaryDirectory(subdirectory:String) -> Bool
    {
        // Remove unnecessary slash if need
        var subDir = stripSlashIfNeeded(subdirectory)
        
        // Create generic beginning to file delete path
        var deletePath = ""
        
        if let direct = FileDirectory.applicationTemporaryDirectory(),
            path = direct.path {
                deletePath = path + "/"
        }
        
        
        deletePath += subDir
        deletePath += "/"
        
        
        var dir:ObjCBool = true
        let dirExists = NSFileManager.defaultManager().fileExistsAtPath(deletePath, isDirectory:&dir)
        if dir.boolValue == false {
            return false
        }
        if dirExists == false {
            return false
        }
        
        
        // Delete the file and see if it was successful
        var error:NSError?
        let ok:Bool = NSFileManager.defaultManager().removeItemAtPath(deletePath, error: &error)
        
        
        if error != nil {
            println(error)
        }
        // Return status of file delete
        return ok
        
    }
    
    
    // private methods
    // private methods
    
    private static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
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
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
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
