//
//  BottomSheet.swift
//  Test
//
//  Created by naeem alabboodi on 9/1/23.
//

import SwiftUI
import RiveRuntime
struct BottomSheet: View {
    @State var translation: CGSize = .zero
    @State private var sheetState: SheetState = .collapsed
    @EnvironmentObject var weatherViewModel: PittsburghWeatherViewModel
    @State var currentDate = Date()
    
    @State var offsetY: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            var yOffset : CGFloat {
                switch sheetState {
                case .collapsed:
                    return proxy.size.height * 0.7
                case .expanded:
                    return 0
                }
            }
        ZStack {
         
            Color.white
                .opacity(0.4)
            VStack {
                HStack {
                    Text("Next 5 Days")
                        .bold()
                    Button(action: {
                        weatherViewModel.setCityAndFetchWeather(for: "pittsburgh", completion: {})
                        print("Button 2 sheet button")
                    }, label: {
//                        Image(systemName: "cloud.sun.bolt.fill")
                        RiveViewModel(fileName: "scatteredClouds2").view()
                            .frame(width: 100,height: 100)
                    })
                }
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 35))
                VStack (alignment: .leading){
                    BottomSheetContent(weatherViewModel: _weatherViewModel, currentDate: currentDate)
                }
                .multilineTextAlignment  (.leading)
                  
                Spacer()
            }
            .padding()
        }
        .onAppear {
            weatherViewModel.fetchWeatherData()
        }
        .clipped()
        .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  maxHeight: .infinity)
        //        .background(Color.blue)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .offset(y:  self.translation.height + 350)

        .gesture(
            DragGesture()
                .onChanged { value in
                    self.translation = value.translation
                }
                .onEnded { value in
                    withAnimation {
                        let snap = self.translation.height + offsetY
                        let guarter  = proxy.size.height / 4
                        if snap > guarter && snap < guarter*3 {
                           offsetY = guarter*2
                        } else if snap > guarter*3 {
                            offsetY = guarter*3 + 100
                        } else {
                            offsetY = 0
                        }
                        self.translation = .zero
                    }
                }
        )
        .ignoresSafeArea(edges: .bottom)
    }
    }
    func yOffset(proxy: GeometryProxy) -> CGFloat {
        switch sheetState {
        case .collapsed:
            return proxy.size.height * 0.55
        case .expanded:
            return 0
        }
    }

}

#Preview {
    BottomSheet()
        .environmentObject(PittsburghWeatherViewModel())
        .background(.blue)
}
enum SheetState {
    case expanded, collapsed
}
