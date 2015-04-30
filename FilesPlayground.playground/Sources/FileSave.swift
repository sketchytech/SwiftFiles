import Foundation


public struct FileSave {
    
    
    public static func saveData(fileData:NSData, directory:NSSearchPathDirectory, path:String, subdirectory:String?) -> Bool
    {
        
        let savePath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
        
    }
    
    public static func saveDataToTemporaryDirectory(fileData:NSData, path:String, subdirectory:String?) -> Bool
    {
        
        let savePath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
    }
    
    
    // string methods
    
    public static func saveString(fileString:String, directory:NSSearchPathDirectory, path:String, subdirectory:String) -> Bool {
        let savePath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        var error:NSError?
        // Save the file and see if it was successful
        let ok:Bool = fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding, error:&error)
        
        if (error != nil) {println(error)}
        
        // Return status of file save
        return ok
        
    }
    public static func saveStringToTemporaryDirectory(fileString:String, path:String, subdirectory:String) -> Bool {
        
        let savePath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        var error:NSError?
        // Save the file and see if it was successful
        var ok:Bool = fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding, error:&error)
        
        if (error != nil) {
            println(error)
        }
        
        // Return status of file save
        return ok;
        
    }
    
    
    
    
    // private methods
    public static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = self.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = self.stripSlashIfNeeded(sub)
        }
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                savePath = path + "/"
        }
        
        if (newSubdirectory != nil) {
            savePath.extend(newSubdirectory!)
            self.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        
        return savePath
    }
    
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) -> String {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationTemporaryDirectory(),
            path = direct.path {
                savePath = path + "/"
        }
        
        if let sub = newSubdirectory {
            savePath += sub
            createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        return savePath
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
    
    private static func createSubDirectory(subdirectoryPath:String) -> Bool {
        var error:NSError?
        var isDir:ObjCBool=false;
        var exists:Bool = NSFileManager.defaultManager().fileExistsAtPath(subdirectoryPath, isDirectory:&isDir)
        if (exists) {
            /* a file of the same name exists, we don't care about this so won't do anything */
            if isDir {
                /* subdirectory already exists, don't create it again */
                return true;
            }
        }
        var success:Bool = NSFileManager.defaultManager().createDirectoryAtPath(subdirectoryPath, withIntermediateDirectories:true, attributes:nil, error:&error)
        
        if (error != nil) { println(error) }
        
        return success;
    }
}
