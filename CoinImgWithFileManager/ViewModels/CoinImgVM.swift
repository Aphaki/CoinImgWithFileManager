//
//  CoinImgVM.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImgVM: ObservableObject {
    let coin: CoinModel
    let urlString: String
    var cancellable = Set<AnyCancellable>()
    let coinImgService: CoinImgService
    @Published var uiIMG: UIImage? = nil
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinImgService = CoinImgService(coin: coin)
        self.urlString = coin.image
        subscribeService()
    }
    
    private func subscribeService() {
        coinImgService.$uiImage
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("코인이미지 뷰모델 구독 : \(completion)")
            } receiveValue: {[weak self] output in
                self?.uiIMG = output
            }
            .store(in: &cancellable)

    }
}
