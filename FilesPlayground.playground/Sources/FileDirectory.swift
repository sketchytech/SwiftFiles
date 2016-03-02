import Foundation

public struct FileDirectory {
    public static func applicationDirectory(directory:NSSearchPathDirectory, subdirectory:String? = nil) -> NSURL? {
    
    
    if let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
    {
        if let subD = subdirectory {
            return NSURL(fileURLWithPath:documentsDirectoryPath).URLByAppendingPathComponent(subD)
        }
        else {
            return NSURL(fileURLWithPath:documentsDirectoryPath)
        }
    }
    else {
     return nil
    }
}

public static func applicationTemporaryDirectory() -> NSURL? {
    
        let tD = NSTemporaryDirectory()
    
        return NSURL(string:tD)
    
}
}