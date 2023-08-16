//
//  SwiftUINewsScreenView.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-16.
//

import SwiftUI

struct ArticlesViewState {
    var articles: [Article]
    var errorMessage: ErrorMessage?
}

struct SwiftUINewsScreenView: View {
    @StateObject private var viewModel = NewsViewModel()
    let langDeviceCode = Locale.current.languageCode ?? "en"
    var body: some View {
        NavigationView {
        if !viewModel.viewState.articles.isEmpty {
            List{
                ForEach(0...viewModel.viewState.articles.count-1, id: \.self) { i in
                    NavigationLink(destination: NewsDetailViewController(viewModel: viewModel)) {
                        ArticleCell(article: viewModel.viewState.articles[i])
                    }
                    .onAppear {
                        viewModel.process(intent: .selectedNews(index: i))
                    }
                }
            }
            
        } else if let errorMessage = viewModel.viewState.errorMessage {
            Text(errorMessage.rawValue)
                .foregroundColor(.red)
        } else {
            Text("Loading...")
        }
    }
        .onAppear() {
            viewModel.process(intent: .fetchNewsSwiftUI)
        }
    }
}

//Holder For ViewController
struct NewsDetailViewController: UIViewControllerRepresentable {
    var viewModel: NewsViewModelProtocol
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = NewsDetailsViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}
