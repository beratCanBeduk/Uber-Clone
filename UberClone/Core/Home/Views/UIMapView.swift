//
//  UIMapView.swift
//  UberClone
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI
import MapKit

struct UberMapView : UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState : MapViewState
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
         
        return mapView
    }
     
    
    
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG : Map state is \(mapState)")
        
        switch mapState{
        case .noInput :
            context.coordinator.clearMapView()
        case .searchinForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocationCoordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate, to: coordinate)
            }
        }
       
        

    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    
}

extension UberMapView {
    class MapCoordinator : NSObject , MKMapViewDelegate {
        let parent  : UberMapView
        var userLocationCoordinate : CLLocationCoordinate2D?
        var currentRegion : MKCoordinateRegion?
        
        init(parent: UberMapView) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        func addAndSelectAnnotation(withCoordinate coordinate : CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            
    
        }
        
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D,to destination : CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            getDestinationRoute(from: userLocationCoordinate , to:coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
            
            func getDestinationRoute(from userLocation : CLLocationCoordinate2D , to destination : CLLocationCoordinate2D,completion: @escaping(MKRoute) -> Void){
                let userPlacemark = MKPlacemark(coordinate: userLocation)
                let destinationPlacemark = MKPlacemark(coordinate: destination)
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: userPlacemark)
                request.destination = MKMapItem(placemark: destinationPlacemark)
                let directions = MKDirections(request: request)
                directions.calculate { response, error in
                    if let error = error {
                        print("DEBUG : Failed to get directions with error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let route = response?.routes.first else {return}
                    completion(route)
                }
            }
            
            func clearMapView(){
                parent.mapView.removeAnnotations(parent.mapView.annotations)
                parent.mapView.removeOverlays(parent.mapView.overlays)
                if let currentRegion = currentRegion {
                    parent.mapView.setRegion(currentRegion, animated: true)
                }
            }
        }
    }

