//
//  ContentView.swift
//  H4X0R News
//
//  Created by Eremej Sumcenko on 03.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsManager = NewsManager()
    
    var body: some View {
        NavigationView {

            List(newsManager.posts) { post in
                NavigationLink(
                    destination: DetailView(urlString: post.url)){
                        PostView(points: post.points, title: post.title)
                    }
            }
            .navigationBarTitle("H4X0R NEWS")
            
        }
        .onAppear(perform: {
            newsManager.fetch()
        })
    }
}

struct PostView: View {
    let points: Int
    let title: String
    
    var body: some View {
        HStack {
            Text(String(points))
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Text(title)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
