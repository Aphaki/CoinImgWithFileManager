//
//  ContentView.swift
//  CoinImgWithFileManager
//
//  Created by Sy Lee on 2022/06/21.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()) , GridItem(.flexible())]
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, pinnedViews: []) {
                ForEach(vm.coin) { coin in
//                    AsyncImage(url: URL(string: coin.image)!) { image in
//                        image
//                            .resizable()
//                            .frame(width: 150, height: 150)
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .padding(.vertical, 30)
                    CoinRowView(coin: coin)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
