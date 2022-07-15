//
//  ContentView.swift
//  VINA ( Virtual International News Assistant )
//
//  Created by Youssef Ahab on 05/07/2022.
//

import SwiftUI
//import AVFoundation

struct NewsSheetView: View {

    @StateObject private var vm: ArticleListViewModel
    
    init(vm: ArticleListViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    @AppStorage("tint") var tint: String = Theme.clear.name
    @State private var color: Color = .blue
    private let width: CGFloat = 500
    private let height: CGFloat = 900
    private let opacity: Double = 0.2
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text("Latest News")
                    .padding()
                    .font(.title.bold())
                    .foregroundColor(.white)
                Divider()
                    .padding([.leading,.trailing], 50)
                    .padding(.bottom)
            }
            
            ScrollViewReader { scrollProxy in
                ScrollView {
                    ForEach(vm.articles, id: \.id) { article in
                        ArticleView(article: article)
                            .id(article.id)
                        Divider()
                    }
                }
                .onChange(of: vm.articles.count) { _ in
                    withAnimation { scrollProxy.scrollTo(vm.articles.last?.id, anchor: .bottom) }
                }
                .onAppear {
                    Task {
                        await vm.populateNews()
//                        withAnimation(.spring()) {vm.articles.append(ArticleViewModel(article: Article.sampleData[0]))}
                    }
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                        Task {
                            await vm.populateNews()
//                            withAnimation(.spring()) {vm.articles.append(ArticleViewModel(article: Article.sampleData[1]))}
                        
                        }
                    }
                }
            }
            
        }
        .frame(width: width, height: height, alignment: .center)
        .background(
            LinearGradient(colors: [color.opacity(opacity), color.opacity(opacity)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .blur(radius: 200)
        )
        .onAppear { setColor() }
        .onChange(of: tint){ _ in
            setColor()
        }
    }
    private func setColor() {
        self.color = Color(self.tint)
    }
}

struct NewsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSheetView(vm: ArticleListViewModel())
    }
}
