// 
//  NTRandomBackgroundViewModel+Image.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture

extension NTRandomBackgroundViewModel {
    struct ImageInput {
        let size: Observable<CGSize>
    }
    
    struct ImageOutput {
        let image: Observable<Image?>
    }
    
    struct Image {
        var image: UIImage
        var isDarkImage: Bool
    }
    
    func handleImage(input: ImageInput) -> ImageOutput {
        let imageURL = input.size
            .map {
                let width = Int($0.width)
                let height = Int($0.height)
                let imageURL = URL(string: "https://source.unsplash.com/random/\(width)x\(height)?geometric")!
                
                return imageURL
            }
        
        let image = Observable<Int>
            .interval(.seconds(5), scheduler: SerialDispatchQueueScheduler(qos: .background))
            .startWith(0)
            .withLatestFrom(imageURL)
            .flatMapLatest { imageURL -> Observable<Image?> in
                return .create { obs in
                    let workItem = DispatchWorkItem {
                        var imageData: Data!
                        do {
                            imageData = try Data(contentsOf: imageURL)
                        } catch {
                            obs.onError(error)
                        }
                        guard let image = UIImage(data: imageData) else {
                            obs.onNext(nil)
                            return
                        }
                        let info = Image(
                            image: image,
                            isDarkImage: image.isDark)
                        obs.onNext(info)
                        obs.onCompleted()
                    }
                    
                    DispatchQueue.global(qos: .background)
                        .async(execute: workItem)
                    
                    return Disposables.create {
                        workItem.cancel()
                    }
                }
                .share(replay: 1)
                .catch { _ in .empty() }
            }
        
        return .init(image: image)
    }
}
