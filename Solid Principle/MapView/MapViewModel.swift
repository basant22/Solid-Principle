//
//  MapViewModel.swift
//  Solid Principle
//
//  Created by Kumar Basant on 19/07/24.
//

import Foundation
import MapKit

final class MapViewModel:NSObject,ObservableObject,CLLocationManagerDelegate{
    @Published var userRegion:MKCoordinateRegion = .myRegion
    //MKCoordinateRegion(center: .mylocation, span: MKCoordinateSpan(latitudeDelta: 0.45, longitudeDelta: 0.45))
  
  //  @Published var userLocation = CLLocationCoordinate2D(latitude: 28.5324, longitude: 77.4052)
    @Published var userLocation:CLLocationCoordinate2D = .mylocation
    //CLLocationCoordinate2D(latitude: 37.334, longitude: -122.34)
   // var locationManager:CLLocationManager?
    private let locationManager = CLLocationManager()
    func checkIfLocationServicesIsEnabled() async{
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled(){
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest/// kCLLocationAccuracyBest is the default
                    self.checkLocationAutherisation()
                }else{
                    // show message: Services desabled!
                }
            }
        }
    func checkIfLocationServiceIsEnable() async {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.checkLocationAutherisation()
            }else{
                print("show an alert letting them know this is off and to go turn it on.")
            }
        }
    }
   private func checkLocationAutherisation(){
      // debugPrint("checkLocationAutherisation")
       // guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            debugPrint("notDetermined")
            locationManager.requestWhenInUseAuthorization()
           
        case .restricted:
            debugPrint("your location is restricted likely due to parental control")
        case .denied:
            debugPrint("You have denied this app location permission.Go into setting to change it")
        case .authorizedAlways,.authorizedWhenInUse:
            debugPrint("authorizedAlways/authorizedWhenInUse")
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                debugPrint("latitude,\(self.locationManager.location!.coordinate.latitude)")
                debugPrint("longitude,\(self.locationManager.location!.coordinate.longitude)")
                self.userRegion = MKCoordinateRegion(center: self.locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.userLocation = CLLocationCoordinate2D(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
            }
            
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAutherisation()
    }
}




