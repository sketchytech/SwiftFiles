//
//  FileList.swift
//  SwiftFilesZip
//
//  Created by Anthony Levings on 30/04/2015.
//  Copyright (c) 2015 Gylphi. All rights reserved.
//

import Foundation
// see here for Apple's ObjC Code https://developer.apple.com/library/mac/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/AccessingFilesandDirectories/AccessingFilesandDirectories.html
public class FileList {
    public static func allFilesAndFolders(inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> [NSURL]? {

        // Create load path
        if let loadPath = buildPathToDirectory(directory, subdirectory: subdirectory) {
        
        let url = NSURL(fileURLWithPath: loadPath)
        var error:NSError?
        
        var properties = [NSURLLocalizedNameKey,
            NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey]
        if let url = url,
        array = NSFileManager.defaultManager().contentsOfDirectoryAtURL(url, includingPropertiesForKeys: properties, options:NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &error) as? [NSURL] {
        return array
            }
}
        return nil
}
    
    public static func allFilesAndFoldersInTemporaryDirectory(subdirectory:String?) -> [NSURL]? {
        
        // Create load path
        let loadPath = buildPathToTemporaryDirectory(subdirectory)
        
        let url = NSURL(fileURLWithPath: loadPath)
        var error:NSError?
        
        var properties = [NSURLLocalizedNameKey,
            NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey]
        if let url = url,
            array = NSFileManager.defaultManager().contentsOfDirectoryAtURL(url, includingPropertiesForKeys: properties, options:NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &error) as? [NSURL] {
                return array
                
        }
        return nil
    }
    
    
    // private methods
    
    private static func buildPathToDirectory(directory:NSSearchPathDirectory, subdirectory:String?) -> String?  {
        // Remove unnecessary slash if need
        // Remove unnecessary slash if need
        var subDir = ""
        if let sub = subdirectory {
        subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file delete path
        var buildPath = ""
        
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                buildPath = path + "/"
        }
        
        
        buildPath += subDir
        buildPath += "/"
        
        
        var dir:ObjCBool = true
        let dirExists = NSFileManager.defaultManager().fileExistsAtPath(buildPath, isDirectory:&dir)
        if dir.boolValue == false {
            return nil
        }
        if dirExists == false {
            return nil
        }
        return buildPath
    }
    public static func buildPathToTemporaryDirectory(subdirectory:String?) -> String {
        // Remove unnecessary slash if need

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