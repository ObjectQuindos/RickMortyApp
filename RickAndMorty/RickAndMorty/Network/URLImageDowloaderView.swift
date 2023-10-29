//
//  URLImageDowloaderView.swift
//  RickAndMorty
//
//  Created by David López on 25/10/23.
//

import Foundation
import SwiftUI
import Kingfisher

@ViewBuilder
func KingFisherImageView(url: String, size: CGSize) -> KFImage {
    
    let processor = DownsamplingImageProcessor(size: size)
                 |> RoundCornerImageProcessor(cornerRadius: 20)
    
    KFImage(URL(string: url))
        .placeholder {
            Image(systemName: "hourglass")
                .font(.largeTitle)
                .opacity(0.25)
        }
        .setProcessor(processor)
        .cacheMemoryOnly()
        .fade(duration: 0.2)
        .onSuccess { result in
            
        }.onFailure { error in
            print("Failed to load image: \(error)")
            
        }
}
