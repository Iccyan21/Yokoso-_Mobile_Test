//
//  EventData.swift
//  Yokoso!_Mobile_Test
//
//  Created by 岩下翔紀 on 2024/05/1.

import SwiftUI

// Identifiableプロトコルを利用して、構造体
struct EventItem: Identifiable {
    let id = UUID()
    let festival_name: String
    let festival_img: URL
//    let date: Date  // 日付を追加
    let festival_data :Date
    let festival_start_time:String
//    let festival_end_time:Date
//    let festival_address:String
//    let festival_description:String
} // Item ここまで

// Evetデータ検索用クラス
@Observable class EventData {
    // JSONのデータ構造
    struct ResultJson: Codable {
        // JSONのitem内のデータ構造
        struct Item: Codable {
            // イベントの名称
            let festival_name: String?

            // 画像URL
            let festival_img: URL?
//            let date: String?  // 日付を追加
            let festival_data:String?
            let festival_start_time:String?
            
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
            // 非同期でEventを検索する
            await search(keyword: keyword)
        } // Task ここまで
    } // searchここまで
    
    // 非同期でイベントデータを取得
    // @MainActorを使いメインスレッドで更新する
    @MainActor
    private func search(keyword: String) async {
        // Eventの検索キーワードをURLエンコードする
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
//            let json = try decoder.decode(ResultJson.self, from: data)
            guard let json: ResultJson = try? decoder.decode(ResultJson.self, from: data) else {
                fatalError("Failed to decode from JSON.")
            }
            
            // print(json)
            print(json)
            
            
            // イベントの情報が取得できているか確認
            guard let items = json.item else { return }
            // イベントのリストを初期化
            eventList.removeAll()
            
            // 取得しているEventの数だけ処理
            for item in items {
                if let festival_name = item.festival_name,
                   let festival_img = item.festival_img,
                   let dateString = item.festival_data,
                   let festival_start_time = item.festival_start_time,
                   let festival_data = iso8601DateFormatter.date(from: dateString) {
                    
                    // 1つのEventを構造体でまとめて管理
                    let event = EventItem(festival_name: festival_name, festival_img: festival_img, festival_data: festival_data,festival_start_time:festival_start_time)
                    // Eventの配列へ追加
                    eventList.append(event)
                } // if ここまで
            } // for ここまで
            print(eventList)
        } catch {
            // エラー処理
            print("エラーが出ました")
        } // do ここまで
    } // search ここまで
    
    // ISO8601形式の日付フォーマッター
    private let iso8601DateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    
    
} // Data ここまで
