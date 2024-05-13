//
//  Eventdetail.swift
//  Yokoso!_Mobile_Test
//
//  Created by syoki iwasyita on 2024/05/07.
//
    
import SwiftUI

struct Eventdetail: View {
    
    @State var EventDataList = EventData()
    let itemName:String
    let itemImage:URL
    var body: some View {
        ScrollView{
            VStack{
                NavigationView {
                    //                Text(itemName)
                    AsyncImage(url: itemImage)
                        .scaledToFit()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                }.navigationBarTitle(Text(itemName))
            }
            
        }
    }
}
