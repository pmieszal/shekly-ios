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
        VStack(alignment: .leading) {
            HStack() {
                Text("subcategory")
                    .padding(.leading, 20)
                    .padding(.top, 8)
                    .font(Font.system(size: 16, weight: .medium))
                Text("13 marzec 2019")
                    .foregroundColor(Color(Colors.text1Color))
                    .padding(.trailing, 20)
                    .padding(.top, 6)
                    .font(Font.system(size: 10, weight: .light))
            }
            .scaledToFill()
            HStack() {
                Text("category + comment")
                    .foregroundColor(Color(Colors.text1Color))
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .font(Font.system(size: 14, weight: .regular))
                    
                Text("- 5,00 zł")
                    .foregroundColor(Color(Colors.numberRed))
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .font(Font.system(size: 14, weight: .regular))
            }
        }
        .background(Color(Colors.brand2Color))
        .foregroundColor(.white)
        .border(Color.black)
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
