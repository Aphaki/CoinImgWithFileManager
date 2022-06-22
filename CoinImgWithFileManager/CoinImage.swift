//
//  CoinImage.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/21.
//

import SwiftUI

struct CoinImage: View {
    
    @StateObject var vm: CoinImgVM
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImgVM(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.uiIMG {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
        }
        
    }
}

struct CoinImage_Previews: PreviewProvider {
    static var previews: some View {
        CoinImage(coin: dev.coin)
    }
}
