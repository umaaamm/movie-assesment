//
//  Movies.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import SwiftUI
import Combine
import FetchImage

struct MoviesView: View {
    var cancellables: Set<AnyCancellable> = []
    var presenter:  MovieListPresenterProtocol
    @State private var shouldAnimate = false
    @State var state: MoviePresenterStateEnum = .loading
    var body: some View {
        VStack{
            switch state{
            case .empty:
                showEmptyView()
            case .error:
                showError()
            case .sucess:
                showListView()
            case .loading:
                showLoading()
            }
            
        }
        
        .padding([.leading,.trailing],20)
        .padding(.top,10)
        .navigationTitle("Movie Apps")
        .navigationBarHidden(true)
        .onReceive(presenter.MoviePresenterStatePublished){ presenterState in
            self.state = presenterState
        }
        .onAppear(){
            presenter.fetchData()
        }
    }
    
    func showEmptyView() -> some View {
        VStack {
            Spacer()
            Image("data-cuate").resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            
        }
    }
    
    func showError() -> some View {
        VStack {
            Spacer()
            Image("data-bro").resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            
        }
    }
    
    func showLoading() -> some View {
        
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
    
    func showListView() -> some View {
        VStack(alignment:.leading, spacing: 20){
            VStack(alignment:.leading,spacing:5){
                Text("Movie Apps")
                    .bold()
                    .font(.largeTitle)
                Divider().background(Color.white)
            }
            
            ScrollView(showsIndicators: false){
                ForEach(presenter.movies, id: \.self) { id in
                    presenter.linkBuilder(for: id){
                        MovieRow(movie: id)
                    }
                }
            }
        }
    }
}


struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieListViewModel()
        
        let interactor = MovieListTestInteractor(model: viewModel,movies: MovieEntity.fakes(quantity: 6))
        let presenter = MovieListPresenter(interactor: interactor)
        return MoviesView(presenter: presenter)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


