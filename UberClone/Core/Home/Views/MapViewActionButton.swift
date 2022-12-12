//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by berat can beduk on 8.12.2022.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject var  viewModel : LocationSearchViewModel
    var body: some View {
        Button{
  
                withAnimation(.spring()){
                    actionForState(mapState)
            }
        } label: {
            Image(systemName: ImageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black,radius: 6)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    func actionForState(_ state : MapViewState){
        switch state{
        case.noInput:
            print("DEBUg : No INPUt")
        case .searchinForLocation:
            mapState = .noInput
        case .locationSelected :
            mapState = .noInput
            viewModel.selectedLocationCoordinate = nil
        }
    }
    
    func ImageNameForState(_ state : MapViewState) -> String {
        switch state{
        case.noInput:
            return "line.3.horizontal"
        case .searchinForLocation,.locationSelected:
            return "arrow.left"
        }

    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
