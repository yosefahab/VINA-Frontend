//
//  NewsView.swift
//  VINA
//
//  Created by Youssef Ahab on 06/07/2022.
//

import SwiftUI

struct ArticleView: View {
    let article: ArticleViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(article.title)
                .font(.title)
                .fontWeight(.light)
                .padding(.bottom)
            
            Text(article.summary)
                .font(.body)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .minimumScaleFactor(0.3)
            
            Rectangle()
                .fixedSize(horizontal: false, vertical: true)
                .hidden()
//            Divider()
//                .padding(.trailing, 320)
            
            HStack {
                HStack {
                    Text("Source:")
                    Link(destination: URL(string:article.link)!) {
                        Text(article.domainName)
                            .underline()
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                HStack {
                    Text("Date:")
                    Text(article.date)
                }
            }
            .font(.footnote)
        }
        .foregroundColor(article.isBreakingNews ? .red : .white)
        .padding(.horizontal)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: ArticleViewModel(article: Article.sampleData[6]))
    }
}
