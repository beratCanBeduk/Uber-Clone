//
//  SearchActivationView.swift
//  UberClone
//
//  Created by berat can beduk on 8.12.2022.
//

import SwiftUI

struct SearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            
            Text("Where to ?")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle().fill(.white).shadow(color: .black, radius: 6)
        )
    }
}

struct SearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchActivationView()
    }
}
