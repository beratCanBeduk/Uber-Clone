//
//  LocationResultCell.swift
//  UberClone
//
//  Created by berat can beduk on 8.12.2022.
//

import SwiftUI

struct LocationResultCell: View {
    let title : String
    let subtitle : String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.blue)
                .frame(width: 40,height: 40)
            
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .font(.body)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading)
        }
        .padding(.leading,8)
        .padding(.vertical,8)
    
    }
}

struct LocationResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationResultCell(title: "", subtitle: "")
    }
}
