//
//  MovieGenreView.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import SwiftUI
import Combine
import FetchImage

struct MoviesGenreView: View {
    var cancellables: Set<AnyCancellable> = []
    var presenter:  MovieGenrePresenterProtocol
    @State private var shouldAnimate = false
    @State var state: MovieGenrePresenterStateEnum = .loading
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
        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
        .onReceive(presenter.MovieGenrePresenterStatePublished){ presenterState in
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
                Text("Genre Apps")
                    .bold()
                    .font(.largeTitle)
                Divider().background(Color.white)
            }
            
            Text("Choose  Genre Movies").font(.headline).foregroundColor(Color.black)
            
            ScrollView(showsIndicators: false){
                ForEach(presenter.moviesGenre, id: \.self) { id in
                                        presenter.linkBuilder(for: id){
                    
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text(id.name ?? "").font(.subheadline).foregroundColor(Color.black).multilineTextAlignment(.center)
                            Spacer()
                            Divider()
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity,maxHeight: 180, alignment: .center)
                    
                    
                }
                }
            }
        }
    }
}


struct MovieGenre_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieGenreViewModel()
        
        let interactor = MovieGenreInteractor(model: viewModel)
        let presenter = MovieGenrePresenter(interactor: interactor)
        return MoviesGenreView(presenter: presenter)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
