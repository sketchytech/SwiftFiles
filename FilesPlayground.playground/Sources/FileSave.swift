import Foundation


public struct FileSave {
    
    
    public static func saveData(fileData:NSData, directory:NSSearchPathDirectory, path:String, subdirectory:String?) throws -> Bool
    {
        
        let savePath = try buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
        
    }
    
    public static func saveDataToTemporaryDirectory(fileData:NSData, path:String, subdirectory:String?) throws -> Bool
    {
        
        let savePath = try buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
    }
    
    
    // string methods
    
    public static func saveString(fileString:String, directory:NSSearchPathDirectory, path:String, subdirectory:String) throws {
        let savePath = try buildPath(path, inDirectory: directory, subdirectory: subdirectory)

        // Save the file and see if it was successful
        
        try fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding)
        
        
        // Return status of file save

        
    }
    public static func saveStringToTemporaryDirectory(fileString:String, path:String, subdirectory:String) throws {
        
        let savePath = try buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        // Save the file and see if it was successful
        try fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding)
        
    }
    
    
    
    
    // private methods
    public static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) throws -> String  {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                savePath = path + "/"
        }
        
        if (newSubdirectory != nil) {
            savePath = savePath.stringByAppendingString(newSubdirectory!)
            try FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        
        return savePath
    }
    
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) throws -> String {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationTemporaryDirectory(),
            path = direct.path {
                savePath = path + "/"
        }
        
        if let sub = newSubdirectory {
            savePath += sub
            try FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        return savePath
    }
    
    
    
    
}
