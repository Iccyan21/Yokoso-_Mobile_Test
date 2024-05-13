
import SwiftUI

struct testui: View {
    var eventDataList = EventData()
    var body: some View {
//        NavigationView{
        ScrollView{
                VStack() {
                    ForEach(eventDataList.eventList){event in
                        NavigationLink(destination: Eventdetail(itemName: event.festival_name, itemImage: event.festival_img)) {
                            
                        }
                    }
                    ZStack() {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 360, height: 190)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 2)
                                        .stroke(.black, lineWidth: 2)
                                )
                                .offset(x: 0, y: 0)
                                .shadow(
                                    color: Color(red: 0, green: 0, blue: 0, opacity: 1), radius: 0, x: 8, y: 6
                                )
                            ZStack() {
                                Text("Yodogawa Hanabi")
                                    .font(Font.custom("Roboto", size: 20).weight(.black))
                                    .foregroundColor(.black)
                                    .offset(x: 0, y: 16.50)
                                Text("Osaka")
                                    .font(Font.custom("Roboto", size: 20).weight(.black))
                                    .foregroundColor(.black)
                                    .offset(x: -52.50, y: 49.50)
                                Text("4/29")
                                    .font(Font.custom("Roboto", size: 20).weight(.black))
                                    .foregroundColor(.black)
                                    .offset(x: -60, y: -49.50)
                                Text("19:00~19:30")
                                    .font(Font.custom("Roboto", size: 20).weight(.black))
                                    .foregroundColor(.black)
                                    .offset(x: -22, y: -16.50)
                            }
                            .frame(width: 162, height: 122)
                            .offset(x: 76, y: -19)
                        }
                        .frame(width: 360, height: 190)
                        .offset(x: 0, y: 0)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 150, height: 160)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/150x160"))
                            )
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 1.50)
                                    .stroke(.black, lineWidth: 1.50)
                            )
                            .offset(x: -90, y: 0)
                    }
                    .frame(width: 360, height: 190)
                    .offset(x: -2.50, y: -251)
                    }
                    .frame(width: 393, height: 127)
                    .offset(x: 0, y: 362.50)
                }
//                .frame(width: 393, height: 852)
//                .background(.white);
            }
//        .navigationBarTitle(Text("Festibal"))
        }
//    }


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    testui()
  }
}
