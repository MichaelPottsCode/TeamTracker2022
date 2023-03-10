//
//  FileManager+Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/16/22.
//

import UIKit

extension FileManager {
    
    func retrieveImage(with id: String) -> UIImage? {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveImage(with id: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            do {
//                print("\(id)")

                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                try data.write(to: url)
//                print("Image saved")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Could not save image")
        }
    }
    
    func deleteImage(with id: String) {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
//                print("OLD IMAGE DELETED")
            } catch {
                print("Could not delete image")
            }
        } else {
            print("Could not find the image")
        }
    }
}
