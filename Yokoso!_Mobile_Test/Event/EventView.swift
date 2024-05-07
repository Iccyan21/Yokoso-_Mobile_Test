import SwiftUI

struct EventView: View {
    // EventDataを参照する変数
    var EventDataList = EventData()
    @State var selection = 1
    
    var body: some View {
        
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            NavigationView {
                
                // リスト表示する
                List(EventDataList.eventList) { event in
                    NavigationLink(destination: Eventdetail()) {
                        // 1つ1つの要素を取り出す
                        // Listの表示内容を生成する
                        // 水平にレイアウト（横方向にレイアウト）
                        
                        VStack{
                            // テキスト表示する
                            VStack(alignment: .leading) {
                                Text(event.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            // 画像を読み込み、表示する
                            AsyncImage(url: event.image) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300,
                                           height: 150,
                                           alignment: .leading)
                                
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                            } placeholder: {
                                ProgressView()
                            }
                        
                        } // HStackここまで
                        
                    }.navigationBarTitle(Text("Event・Festival"))
                } // Listここまで
            } // VStack ここまで
        }
        // 画面表示時に検索を実行
        .onAppear {
            search(keyword: "event2") // デフォルトの検索キーワードを設定
        }
    } // body ここまで
    // 検索
    func search(keyword: String) {
        EventDataList.searchEvent(keyword: keyword)
    }
    
} // ContentView ここまで



// プレビュー描画
#Preview {
    EventView()
} // プレビュー ここまで
