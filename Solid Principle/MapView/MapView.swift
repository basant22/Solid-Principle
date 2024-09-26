//
//  MapView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import SwiftUI
import MapKit
struct MapViewContent:View {
    @State private var showMenu = false
    @State private var selectedTab = 0
    var body: some View {
        ZStack{
            MapView(showMenu: $showMenu)
            SideMenu(isShowing: $showMenu, selectedTab: $selectedTab)
        }
    }
}
struct MapView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject private var mapModel = MapViewModel()
    @EnvironmentObject private var router:Router
    @State private var cameraPosition:MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
        //.camera(MapCamera(MKMapCamera(lookingAtCenter: .mylocation, fromEyeCoordinate: .mylocation, eyeAltitude: 100000)))
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection:MKMapItem?
    @State private var showDetail:Bool = false
    @State private var getDirection  = false
    @State private var routeDisplaying  = false
    @State private var route:MKRoute?
    @State private var routeDestination:MKMapItem?
    @Binding var showMenu:Bool
    var body: some View {
        //ZStack{
        
        Map(position: $cameraPosition,selection: $mapSelection){
                Annotation("",coordinate: mapModel.userLocation){
                    ZStack{
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.blue.opacity(0.25))
                        Circle()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(.white)
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.blue)
                    }
                }
                ForEach(self.results,id: \.self){ item in
//                    if routeDisplaying{
//                        if item == routeDestination{
//                            let loaction = item.placemark
//                            Marker(loaction.name ?? "", coordinate: loaction.coordinate)
//                        }
//                    }else{
                        let loaction = item.placemark
                        Marker(loaction.name ?? "", coordinate: loaction.coordinate)
                    //}
                    
                }
                if let route{
                    MapPolyline(route.polyline)
                        .stroke(.blue,lineWidth:6)
                }
            }
            .overlay(alignment:.top){
                HStack(spacing:10){
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .imageScale(.small)
                        .clipShape(Circle())
                        .frame(width: 22, height: 22)
                        .padding(.leading,9)
                        .foregroundColor(.teal)
                    TextField("",text: $searchText,prompt: Text("Search for a utility...")
                        .foregroundColor(.teal))
                        .font(.title3)
                        .padding(16)
                        .foregroundStyle(.black)
                        //.background(.white)
                        .shadow(radius: 10)
                    
                        
                        
                    //Spacer()
                        
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12,bottomLeading: 12,bottomTrailing: 12, topTrailing: 12)))
                //.background(RoundedRectangle(cornerSize: 12, style: .circular))
                .padding(.leading,5)
                .padding(.top,4)
                .padding(.trailing,65)
                
            }
            .onSubmit {
                print("search for location with query = \(searchText)")
                if !searchText.isEmpty{
                    Task{
                        await searchPlaces()
                    }
                }
            }
            .mapControls {
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
            }
        // .ignoresSafeArea()
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.linear,value: showMenu)
        .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading){
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 25,height: 18)
                    .foregroundColor(.green)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                           // router.path.removeLast()
                        }
                    }
            }

        })
        .navigationBarBackButtonHidden(true)
        //.padding()
        .onAppear{
//            Task{
//               await viewModel.checkIfLocationIsEnabled()
//            }
            Task{
               await mapModel.checkIfLocationServiceIsEnable()
                cameraPosition = .region(mapModel.userRegion)
                    //.camera(MapCamera(MKMapCamera(lookingAtCenter: mapModel.userLocation, fromEyeCoordinate: mapModel.userLocation, eyeAltitude: 100000)))
            }
        }
        .onChange(of: getDirection){ oldValue,newValue in
            if newValue{
                fetchRoutes()
            }
        }
        .onChange(of: mapSelection){ oldValue,newValue in
            showDetail = newValue != nil
        }
        .sheet(isPresented: $showDetail) {
            LocationDetailView(mapSelection: $mapSelection,
                               show: $showDetail,
                               getDirection:$getDirection)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        }
           
        //}
            
        
    }
}
extension MapView{
    func searchPlaces() async{
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .myRegion
        let result = try? await MKLocalSearch(request: request).start()
        self.results = result?.mapItems ?? []
    }
    func fetchRoutes(){
        if let mapSelection{
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: mapModel.userLocation))
            request.destination = mapSelection
            Task{
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = mapSelection
            withAnimation(.snappy){
                routeDisplaying = true
                showDetail = false
                getDirection = false
                if let rect = route?.polyline.boundingMapRect,routeDisplaying{
                    cameraPosition = .rect(rect)
                }
            }
            }
        }
    }
}
#Preview {
    MapView(showMenu: .constant(false))
}
final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.457105, longitude: -80.508361), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var cameraPosition:MapCameraPosition = .region(.myRegion)
    var binding: Binding<MKCoordinateRegion> {
        Binding {
            self.mapRegion
        } set: { newRegion in
            self.mapRegion = newRegion
        }
    }

    func checkIfLocationIsEnabled() async{
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let previousAuthorizationStatus = manager.authorizationStatus
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
        }
    }

    private func checkLocationAuthorization() {
        guard let location = locationManager else {
            return
        }

        switch location.authorizationStatus {
        case .notDetermined:
            print("Location authorization is not determined.")
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location permission denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = location.location {
                mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }

        default:
            break
        }
    }
}
