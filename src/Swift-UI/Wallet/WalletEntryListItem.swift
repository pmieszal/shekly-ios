//
//  WalletEntryListItem.swift
//  Swift-UI
//
//  Created by Patryk Mieszała on 18/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import SwiftUI
import Shared

struct WalletEntryListItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack() {
                Text("subcategory")
                    .padding(.leading, 20)
                    .padding(.top, 4)
                    .font(Font.system(size: 16, weight: .medium))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("13 marzec 2019")
                    .foregroundColor(Color(Colors.text1Color))
                    .padding(.trailing, 20)
                    .padding(.top, 4)
                    .font(Font.system(size: 10, weight: .light))
            }
            
            HStack(alignment: .top) {
                Text("category + comment + comment + comment + comment + comment + comment + comment + comment")
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(Colors.text1Color))
                    .padding(.leading, 20)
                    .padding(.bottom, 16)
                    .font(Font.system(size: 14, weight: .regular))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                Text("- 5,00 zł")
                    .foregroundColor(Color(Colors.numberRed))
                    .padding(.trailing, 20)
                    .font(Font.system(size: 14, weight: .semibold))
                    .frame(minWidth: 0, maxHeight: .infinity, alignment: .topTrailing)
            }
        }
        .background(Color(Colors.walletEntryBackground))
        .foregroundColor(.white)
        .fillHorizontally()
    }
}

struct WalletEntryListItem_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            WalletEntryListItem()
        }
        .padding(.top, 100)
    }
}
