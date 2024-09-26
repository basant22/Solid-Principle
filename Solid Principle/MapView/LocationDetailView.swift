//
//  LocationDetailView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 19/07/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Binding var mapSelection:MKMapItem?
    @Binding var show:Bool
    @Binding var getDirection:Bool
    @State private var mkLookArounrScene:MKLookAroundScene?
   
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .padding(.trailing)
                }
                Spacer()
                Button{
                    show.toggle()
                    mapSelection = nil
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.gray,Color(.systemGray6))
                }
            }
            //.padding(.top,5)
           // .padding(.horizontal,10)
            if let scene = mkLookArounrScene{
                LookAroundPreview(initialScene: scene)
                    .frame(height:200)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12,bottomLeading: 12,bottomTrailing: 12, topTrailing: 12)))
                    .padding()
            }else{
                ContentUnavailableView("No preview available", systemImage:"eye.slash")
            }
            HStack(spacing: 24){
                Button{
                    if let mapSelection{
                        mapSelection.openInMaps()
                    }
                }label:{
                    Text("Open in Map")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 170, height: 48)
                        .background(.teal)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12,bottomLeading: 12,bottomTrailing: 12, topTrailing: 12)))
                }
                Button{
                        getDirection = true
                        show = false
                }label:{
                    Text("Show Directions")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 170, height: 48)
                        .background(.green)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12,bottomLeading: 12,bottomTrailing: 12, topTrailing: 12)))
                }
            }
        }
        .onAppear{
            debugPrint("call onappear")
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection){oldValue,newValue in
            debugPrint("call onchange of mapselection")
            fetchLookAroundPreview()
        }
        .padding()
    }
}
extension LocationDetailView{
    func fetchLookAroundPreview(){
        if let mapSelection{
            mkLookArounrScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                mkLookArounrScene = try? await request.scene
            }
        }
    }
}
#Preview {
    LocationDetailView(mapSelection: .constant(nil), show: .constant(false), getDirection: .constant(false))
}
