//
//  ContentView.swift
//  Yokoso!_Mobile_Test
//
//  Created by 水原　樹 on 2024/04/22.
//

import SwiftUI

struct ContentView: View {
    
    // タブの選択項目を保持する
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            Word_Manner()  //✅ 1つ目のページをTabViewに配置
                .tabItem { // ⬅︎
                    Label("Word", systemImage: "1.circle")
                }
                .tag(1) // ⬅︎
            
            MapView()  //✅ 2つ目のページをTabViewに配置
                .tabItem {
                    Label("MAP", systemImage: "2.circle")
                }
                .tag(2)
            
            EventView()  //✅ 3つ目のページをTabViewに配置
                .tabItem {
                    Label("Evnet", systemImage: "3.circle")
                }
                .tag(3)
            
        } // TabView ここまで
    } // body
} // View


#Preview {
    ContentView()
}
