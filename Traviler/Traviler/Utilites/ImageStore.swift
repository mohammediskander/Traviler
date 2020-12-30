//
//  Image.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 26/12/2020.
//

import UIKit
import Darwin

class ImageStore {
    
    static var shared: ImageStore = ImageStore()
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        
        if let data = image.toJPEG(with: .highQuality) {
            try? data.write(to: url)
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    
    /// Delete the
    /// - Parameter key: the Key to delete the image
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("ERR::\(#function)::An occure while removing image with key \(key) from dist.", error)
        }
    }
    
    /// Generate a url in user's domain mask's document directory by the given `key`.
    /// - Parameter key: the `String` key to generate new `URL`. the `key` will be used as the image file name
    /// - Returns: The generated `URL`.
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    
    /// Get the the imageStore cache memory size in `Mega bytes (1024 / 1024)`
    /// - Returns: cache memory size in `Mega bytes (1024 / 1024)`
    func fileSizeOfCache() -> Double {
        // Remove the cache folder directory cache files are in this directory
        let cachePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        // Cache directory path
        
        // Remove all file arrays under the folder
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // Quickly enumerate all file names Calculate file size
        var size: Double = 0
        for file in fileArr! where !file.hasSuffix(".json") {
            
            // splicing the file name into the path
            let path = cachePath?.appending("\(file)")
            // remove the file attribute
            let floder = try? FileManager.default.attributesOfItem(atPath: path!)
            // Use the tuple to remove the file size attribute
            
            for (key, value) in floder! {
                // accumulate file size
                if key == FileAttributeKey.size {
//                    size += (bcd as AnyObject).integerValue
                    size += (value as AnyObject).doubleValue
                }
            }
        }
        
        return size / 1024 / 1024
    }
    
    
    /// Clear imageStore cache memory
    func clear() {
        do {
            let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!

            let contents = try FileManager.default.contentsOfDirectory(atPath: documentDirectory.path).filter { !$0.hasSuffix(".json") }

            let urls = contents.map { URL(string:"\(documentDirectory.appendingPathComponent("\($0)"))")! }
            urls.forEach {  try? FileManager.default.removeItem(at: $0) }
            
            /// `exit(0)` is reported as a crash, but we're using it for now just for force quit the application after clearing image cache.
            exit(0)
        }
        catch {
            print("ERR::\(error)")
        }
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowestQuality  = 0
        case lowQuality     = 0.25
        case mediumQuality  = 0.5
        case highQuality    = 0.75
        case heighstQuality = 1
    }
    
    /// Return the data for the specified image in JPEG format.
    /// if the image object's underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - Parameter quality: The quality of the resulting JPEG image; default is `.mediumQuality`
    /// - Returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func toJPEG(with quality: JPEGQuality = .mediumQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}

