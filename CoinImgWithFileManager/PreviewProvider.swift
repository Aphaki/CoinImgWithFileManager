//
//  PreviewProvider.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}
class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    private init() { }
    
    let homeVM = ViewModel()
    
    let coin = CoinModel(id: "bitcoin",
                         image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")
}
                         
