//
//  SearchView.swift
//  UberClone
//
//  Created by berat can beduk on 8.12.2022.
//

import SwiftUI

struct SearchView: View {
    @State  var startLocationText : String

    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            //header view
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6,height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 24)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6,height: 6)
                
                    
    
                }
                VStack{
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                       
                    TextField("Where To?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                    
                    
                }
            }.padding(.horizontal).padding(.top,80)
            Divider().frame(height: 2)
                .overlay(.gray)
                .padding(.vertical)
                .padding(.horizontal)
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach(viewModel.result, id: \.self){ element in
                        LocationResultCell(title: element.title, subtitle:element.subtitle )
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectLocation(localSearch: element)

                                    mapState = .locationSelected
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            //list view
        }
        .background(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(startLocationText: "",
                   mapState:.constant(.searchinForLocation)).environmentObject(LocationSearchViewModel())
    }
}
