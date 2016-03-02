import Foundation

public struct FileMove {
    // if a file exists at the old path and doesn't exist at the new path then the file is move
    public static func move(fromPath:String, fromDirectory:NSSearchPathDirectory,  fromSubdirectory:String?, toPath:String, toDirectory:NSSearchPathDirectory,  toSubdirectory:String?) throws {
     
        let oldPath = buildPath(fromPath, inDirectory: fromDirectory, subdirectory: fromSubdirectory)
        let newPath = buildPath(toPath, inDirectory: toDirectory, subdirectory: toSubdirectory)
        if let newDirectory = NSURL(fileURLWithPath: newPath).URLByDeletingLastPathComponent
        {
        try NSFileManager.defaultManager().createDirectoryAtURL(newDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        if NSFileManager.defaultManager().fileExistsAtPath(oldPath) && !NSFileManager.defaultManager().fileExistsAtPath(newPath) {
        try NSFileManager.defaultManager().moveItemAtURL(NSURL(fileURLWithPath: oldPath), toURL: NSURL(fileURLWithPath: newPath))
        }
    }
    
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
}