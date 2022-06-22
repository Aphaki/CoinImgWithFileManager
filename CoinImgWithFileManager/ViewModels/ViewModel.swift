//
//  ViewModel.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var coin: [CoinModel] = []
    private var cancellable = Set<AnyCancellable>()
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    
    init() {
        downloadCoin()
    }
    
    func downloadCoin() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(3)
            .tryMap{ output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badURL)
                }
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("DownloadCoin : \(completion)")
            } receiveValue: { [weak self] response in
                self?.coin = response
            }
            .store(in: &cancellable)

    }
}
