//
//  ImageCache+URLSession+RxSwift.swift
//  downloadImageCache
//
//  Created by 김민국 on 2020/11/23.
//

import UIKit
import Foundation
import RxSwift

class APIService {
    static func getImage(url: String) -> Observable<UIImage?> {
        return Observable.create({ observer -> Disposable in
            let cacheKey = NSString(string: url)
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
                observer.onNext(cachedImage)
                observer.onCompleted()
            } else {
                if let imageURL = URL(string: url) {
                    let task = URLSession.shared.dataTask(with: imageURL) { (data, res, err) in
                        if let err = err {
                            observer.onError(err)
                        }
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                            observer.onNext(image)
                            observer.onCompleted()
                        } else {
                            observer.onNext(UIImage())
                            observer.onCompleted()
                        }
                    }
                    task.resume()
                    return Disposables.create{
                        task.cancel()
                    }
                }
            }
            return Disposables.create()
        })
    }
}
