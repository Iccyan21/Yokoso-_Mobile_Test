
//
//  EventData.swift
//  Yokoso!_Mobile_Test
//
//  Created by 岩下翔紀 on 2024/05/1.

import SwiftUI

// Identifiableプロトコルを利用して、構造体
struct EventItem: Identifiable {
    let id = UUID()
    let name: String
    let image: URL

} // Item ここまでß

// Evetデータ検索用クラス
@Observable class EventData {
    // JSONのデータ構造
    struct ResultJson: Codable {
        // JSONのitem内のデータ構造
        struct Item: Codable {
            // イベントの名称
            let name: String?
            //イベントの詳細
//            let details: String?
            // 掲載URL
//            let url: URL?
            // 画像URL
            let image: URL?
        }
        
        // 複数要素
        let item: [Item]?
    } // ResultJson ここまで

    // イベントのリスト（Identifiableプロトコル）
    var eventList: [EventItem] = []
            
    // Web API検索用メソッド　第一引数：keyword 検索したいワード
    func searchEvent(keyword: String) {
        // デバッグエリアに出力
        print("searchEventメソッドで受け取った値：\(keyword)")

        // Taskは非同期で処理を実行できる
        Task {
            // ここから先は非同期で処理される
            // 非同期でお菓子を検索する
            await search(keyword: keyword)
        } // Task ここまで
    } // searchここまで

    // 非同期でイベントデータを取得
    // @MainActorを使いメインスレッドで更新する
    @MainActor
    private func search(keyword: String) async {
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        } // guard let ここまで

        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://3a09dd63-e888-44b6-94a2-2244b4de6338.mock.pstmn.io/\(keyword_encode)") else {
            return
        } // guard let ここまで
        // デバッグエリアに出力
        print(req_url)
        
        do {
            // リクエストURLからダウンロード
            let (data, _) = try await URLSession.shared.data(from: req_url)
            // JSONDecoderのインスタンス取得
            let decoder = JSONDecoder()
            // 受け取ったJSONデータをパース（解析）して格納
            let json = try decoder.decode(ResultJson.self, from: data)

            // print(json)
            print(json)

            // イベントの情報が取得できているか確認
            guard let items = json.item else { return }
            // イベントのリストを初期化
            eventList.removeAll()
            
            // 取得しているお菓子の数だけ処理
            for item in items {
                // お菓子の名称、掲載URL、画像URLをアンラップ
                if let name = item.name,
//                   let details = item.details,
//                   let link = item.url,
                   let image = item.image {
                    // 1つのお菓子を構造体でまとめて管理
                    let event = EventItem(name: name,  image: image)
                    // お菓子の配列へ追加
                    eventList.append(event)
                } // if ここまで
            } // for ここまで
            print(eventList)
        } catch {
            // エラー処理
            print("エラーが出ました")
        } // do ここまで
    } // search ここまで
} // Data ここまで
