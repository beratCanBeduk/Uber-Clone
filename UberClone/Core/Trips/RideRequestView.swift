//
//  RideRequestView.swift
//  UberClone
//
//  Created by berat can beduk on 9.12.2022.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType : RideType = .uberX
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
                .padding(.top,8 )
            // trip info View
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8,height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 32)
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 8,height: 8)
                    
                    
                    
                }
                VStack{
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom,10)
                    Spacer().frame(height: 20)
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Text("1:45 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                
                }
                .padding(.leading,8)
            }// HStack
            .padding()
            
            Divider().frame(height: 3)
                .overlay(.gray)
                
                .padding(.horizontal)
            
            // ride type selection view
            
            Text("Suggested Rides")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(Color(.gray))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 12){
                    ForEach(RideType.allCases){type in
                        VStack(alignment: .leading){
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack (){
                                Text(type.description)
                                    .font(.system(size: 14,weight: .semibold))
                                .foregroundColor(type == selectedRideType ? .white : .black)
                                Text("\(locationViewModel.computeRidePrice(forType: type))")
                                    .font(.system(size: 14,weight: .semibold))
                                    .foregroundColor(type == selectedRideType ? .white : .black)
                            }
                            .padding(type == selectedRideType ?  18 : 8)
                        }
                        .frame(width: 112,height: 140)
                      
                        .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.25 : 1.00)
                        .cornerRadius(10)
                        
                        .onTapGesture {
                            withAnimation(){
                                selectedRideType = type
                            }
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
            Divider().padding(.vertical,8)
            //Payment Option View
            
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                
                Text("*****123")
                    .fontWeight(.bold)
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(width: 350, height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            //request ride button
            
            Button{
                
            } label: {
                Text("Confirm Ride")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
            }
            
        }
        .padding(.bottom,16)
        .background(.white)
        .cornerRadius(22)
        
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView().environmentObject(LocationSearchViewModel())
    }
}
