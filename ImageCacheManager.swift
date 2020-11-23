//
//  ImageCacheManager.swift
//  downloadImageCache
//
//  Created by 김민국 on 2020/11/23.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
