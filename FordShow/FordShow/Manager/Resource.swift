//
//  Resource.swift
//  FordShow
//
//  Created by xinyue on 2019/6/4.
//  Copyright © 2019 weicheng. All rights reserved.
//

import UIKit
import Photos

let albumName = "FordShow"

class Resource {
    
    static let shared = Resource()
    
    var collection: PHAssetCollection?
    
    var isAlbumExist: Bool {
        
        if collection != nil {
            return true
        }
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        collections.enumerateObjects(options: .reverse) { [weak self] (item, idx, stop) in
            if item.localizedTitle == albumName {
                print("has album")
                self?.collection = item
                stop.pointee = true
            }else{
                print("looking \(item.localizedTitle ?? "none")")
            }
        }
        
        guard let _ = collection else { return false }
        
        return true
    }
    
    func list(for id: String) -> [UIImage] {
        
        if !isAlbumExist { return [] }
        
        guard let collection = collection else { return [] }
        var assets = [PHAsset]()
        var images = [UIImage]()
        
        
        let asset = PHAsset.fetchAssets(in: collection, options: nil)
        asset.enumerateObjects(options: .reverse) { (asset, idx, stop) in
            assets.append(asset)
        }
        assets.forEach { (asset) in
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100,height: 100), contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image, info) in
                if let img = image {
                    images.append(img)
                }
            })
        }
        
        return images
    }

}
