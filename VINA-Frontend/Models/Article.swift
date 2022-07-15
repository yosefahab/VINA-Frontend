//
//  News.swift
//  VINA
//
//  Created by Youssef Ahab on 06/07/2022.
//

import SwiftUI

struct Article: Decodable {

    let title: String
    let summary: String
    let link: String
    let domainName: String
    let date: String
    let isBreakingNews: Bool
    
    init(title: String, summary: String, link: String, domainName: String, date: String, breakingNews: Bool = false) {
        self.title = title
        self.summary = summary
        self.link = link
        self.domainName = domainName
        self.date = date
        self.isBreakingNews = breakingNews
    }
    static var sampleData: [Article] {
        var samples: [Article] = []
        for i in 1...10 {
            samples.append(
                Article(title: "Title\(i)",
                        summary: String(repeating: "some news for article number\(i). ", count: 4*i/2) ,
                        link: "www.google.com",
                        domainName: "google",
                        date: "08-07-2022",
                        breakingNews: i%2==0 ? true : false))
        }
        return samples
    }
}

@MainActor
class ArticleListViewModel: ObservableObject {
    
    @Published var articles: [ArticleViewModel] = []
    
    func populateNews() async {
        do {
            let news = try await Client().getNews(url: URL(string: "http://raspberrypi.local:1234")!)
            let newNews = news.map(ArticleViewModel.init)
            withAnimation {
                self.articles.append(contentsOf: newNews)
            }
        } catch {
            print(error)
        }
    }
}

struct ArticleViewModel: Identifiable {
    let id: UUID
    private var article : Article
    
    init(article: Article){
        self.article = article
        self.id = UUID()
    }
    var title: String {
        article.title
    }
    var summary: String {
        article.summary
    }
    var domainName: String {
        article.domainName
    }
    var link: String {
        article.link
    }
    var isBreakingNews: Bool {
        article.isBreakingNews
    }
    var date: String {
        article.date
    }
    func getName() -> String {
             return "Entry with id \(id.uuidString)"
    }
}
