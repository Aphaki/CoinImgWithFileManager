//
//  CoinRowView.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/22.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack{
            CoinImage(coin: coin)
                .frame(width: 100, height: 100)
            Text(coin.id.uppercased())
                .font(.headline)
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
