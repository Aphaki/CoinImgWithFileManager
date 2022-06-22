//
//  CoinImgService.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImgService {
    private let coin: CoinModel
    private let folderName = "coin_images"
    private let imageName: String
    private let fileManager = LocalFileManager.shared
    @Published var uiImage: UIImage? = nil
    var subscription: AnyCancellable? = nil
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    func getCoinImage() {
        if let localImg = fileManager.getImageFromImgURL(imgName: imageName, folderName: folderName){
            uiImage = localImg
            print("이미지 가져오기 - 로컬")
        } else {
            downloadCoinImage()
            print("이미지 다운로드 - 네트워크")
        }
    }
    
    func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
       subscription = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, urlResponse) -> UIImage? in
                guard let response = urlResponse as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
                else { print("이미지 다운로딩중 유효한 코드가 아님.")
                    return nil }
                return UIImage(data: data)
            }
            .sink { completion in
                print("이미지 다운로드 컴플리션: \(completion)")
            } receiveValue: {[weak self] uiimage in
                guard
                    let self = self,
                    let downloadImg = uiimage
                else { return }
                self.uiImage = downloadImg
                self.subscription?.cancel()
                self.fileManager.saveImage(image: downloadImg, folderName: self.folderName, imgName: self.imageName)
            }
    }
}
