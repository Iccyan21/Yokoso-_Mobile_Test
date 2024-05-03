//
//  Word_Manner.swift
//  Yokoso!_Mobile_Test
//
//  Created by 水原　樹 on 2024/04/25.
//

import SwiftUI

import SwiftUI

struct EventView: View {
  // EventDataを参照する変数
  var EventDataList = EventData()
  // 入力された文字列を保持する状態変数
  @State var inputText = "カレー" // Initial value set to "カレー"

  var body: some View {
    // 垂直にレイアウト（縦方向にレイアウト）
    VStack {
      // ボタンを表示する
      Button(action: {
        // 検索を実行する
        EventDataList.searchEvent(keyword: inputText)
      }) {
        Text("検索")
      }

      // リスト表示する
      List(EventDataList.eventList) { event in
        // 1つ1つの要素を取り出す
        // Listの表示内容を生成する
        // 水平にレイアウト（横方向にレイアウト）
        HStack {
          // テキスト表示する
            VStack(alignment: .trailing) {
            Text(event.name)
            Spacer() // ここでスペースを追加
          }

          // 画像を読み込み、表示する
          AsyncImage(url: event.image) { image in
            image
              .resizable()
              .scaledToFit()
              .frame(height: 100)
          } placeholder: {
            ProgressView()
          }
        } // HStackここまで
      } // Listここまで
    } // VStack ここまで
  } // body ここまで
} // ContentView ここまで

// プレビュー描画
#Preview {
  EventView()
} // プレビュー ここまで
