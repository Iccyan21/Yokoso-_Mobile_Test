//
//  Word_Manner.swift
//  Yokoso!_Mobile_Test
//
//  Created by 水原　樹 on 2024/04/25.
//

import SwiftUI

struct EventView: View {
    // EventDataを参照する変数
    var EventDataList = EventData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    

    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                // 入力完了直後に検索をする
                EventDataList.searchEvent(keyword: inputText)
            } // .onSubmit ここまで
            // キーボードの改行を検索に変更する
            .submitLabel(.search)
            // 上下左右に空白を空ける
            .padding()

            // リスト表示する
            List(EventDataList.eventList) { event in
                // 1つ1つの要素を取り出す
                // Listの表示内容を生成する
                // 水平にレイアウト（横方向にレイアウト）
                HStack {
                    // 画像を読み込み、表示する
                    AsyncImage(url: event.image) { image in
                        // 画像を表示する
                        image
                            // リサイズする
                            .resizable()
                            // アスペクト比（縦横比）を維持してエリア内に収まるようにする
                            .scaledToFit()
                            // 高さ40
                            .frame(height: 40)
                    } placeholder: {
                        // 読み込み中はインジケーターを表示する
                        ProgressView()
                    } // AsyncImage ここまで
                    // テキスト表示する
                    Text(event.name)
                } // HStackここまで
            } // Listここまで
        } // VStack ここまで
    } // body ここまで
} // ContentView ここまで

// プレビュー描画
#Preview {
    EventView()
} // プレビュー ここまで



