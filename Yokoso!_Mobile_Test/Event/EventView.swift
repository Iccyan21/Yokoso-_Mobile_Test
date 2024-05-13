import SwiftUI

struct EventView: View {
    // EventDataを参照する変数
    var eventDataList = EventData()
    @State var selection = 1
    
    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            NavigationStack {
                // リスト表示する
                List(eventDataList.eventList) { event in
                    NavigationLink(destination: Eventdetail(itemName:event.festival_name,itemImage:event.festival_img)) {
                        // 1つ1つの要素を取り出す
                        // Listの表示内容を生成する
                        // 水平にレイアウト（横方向にレイアウト）
                        VStack(alignment: .leading){
                            // テキスト表示する
                            VStack(alignment: .leading) {
                                Text(event.festival_name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(event.festival_data, formatter: dateFormatter)") // 日付を表示
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // 画像を読み込み、表示する
                            AsyncImage(url: event.festival_img) { image in
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 150, height: 160)
                                    .background(
                                        image
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 1.50)
                                            .stroke(.black, lineWidth: 1.50)
                                    )
//                                image

                                
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Festival"))
            }
        }
        // 画面表示時に検索を実行
        .onAppear {
            search(keyword: "event2") // デフォルトの検索キーワードを設定
        }
    }
    
    // 検索
    func search(keyword: String) {
        eventDataList.searchEvent(keyword: keyword)
    }
    
    // DateFormatterのインスタンス
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 日付フォーマットに合わせる
        formatter.dateFormat = "MM月dd日HH:mm" // 日付フォーマットに合わせる
        return formatter
    }()
    //timestamp（Double）の表示形式を文字列に変換する関数
//    class func getDate(_ number: TimeInterval) -> String {
//        let date = Date(timeIntervalSince1970: number)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        return formatter.string(from: date)
//    }
}

// プレビュー描画
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
