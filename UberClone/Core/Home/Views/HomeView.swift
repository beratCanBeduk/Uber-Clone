//
//  HomeView.swift
//  UberClone
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var viewModel : LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ZStack(alignment: .top) {
                UberMapView(mapState: $mapState)
                    .ignoresSafeArea()
                if mapState == MapViewState.searchinForLocation  {
                    SearchView(startLocationText: "", mapState: $mapState)
                }else if mapState == .noInput{
                    SearchActivationView().padding(.top,70)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchinForLocation
                            }
                        }
                }
                
                
                MapViewActionButton(mapState: $mapState).padding(.leading).padding(.top,4)
            }
            if mapState == .locationSelected{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                viewModel.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
