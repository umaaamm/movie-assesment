//
//  MovieDetailView.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import SwiftUI
import Combine
import FetchImage
import AVFoundation
import _AVKit_SwiftUI
import WebKit

struct MovieDetailView: View {
    var presenter:  MovieDetailPresenterProtocol
    var cancellables: Set<AnyCancellable> = []
    var dataMovie: MovieEntity
    @State var state: MovieDetailPresenterStateEnum = .empty
    @State private var shouldAnimate = false
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            VStack{
                switch state{
                case .empty:
                    showEmptyView()
                case .error:
                    showError()
                case .sucess:
                    showDetail()
                case .loading:
                    showLoading()
                }
            }
            
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing],12)
            //            .padding(.top,10)
            .onReceive(presenter.MovieDetailPresenterStatePublished){ presenterState in
                self.state = presenterState
            }
            .onAppear(){
                //                presenter.fetchData(id:dataMovie.id)
                presenter.fetcDataReview(id: dataMovie.id)
            }
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
        VStack{
            Spacer()
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
            Spacer()
        }
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    func showDetail() -> some View {
        VStack(alignment:.leading, spacing: 8){
            VStack(alignment:.leading){
                Text("\(dataMovie.title) (\(dataMovie.releaseYear ?? ""))")
                    .bold()
                    .font(.title)
                Divider().background(Color.white)
            }
            
            VStack{
                YoutubeVideoView(youtubeVideoID: presenter.moviesVideos[0].key)
                    .frame(height: 200)
                //                    ImageViewDetail(url: dataMovie.imageURLBackDrop)
            }
            
            VStack(alignment: .leading, spacing: 5){
                Text("Overview")
                    .font(.headline).foregroundColor(.black).bold()
                Text(dataMovie.overview)
                    .font(.subheadline).foregroundColor(.black)
            }
            HStack{
                Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 14))
                Text(String(dataMovie.vote_average)).font(.system(size: 14)).foregroundColor(Color.gray)
            }
            
            HStack{
                Text(String(dataMovie.genre)).font(.system(size: 14)).foregroundColor(Color.gray).padding(5).border(.gray).cornerRadius(3)
            }
            
            
            Divider().background(Color.gray)
            Text("Reviews").font(.headline)
            ScrollView(showsIndicators: false){
                ForEach(presenter.moviesReviews, id: \.self) { id in
                    VStack{
                        HStack(alignment: .top){
                            ImageView(url: id.authorDetails!.imageURLAvatar).clipShape(Circle()).frame(width: 60,height: 60).padding(.top,30)
                            
                            VStack(alignment: .leading){
                                Text(id.author ?? "").font(.headline).foregroundColor(Color.black).multilineTextAlignment(.center)
                                
                                Text(id.content ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                
                                HStack{
                                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 14))
                                    Text(String(id.authorDetails?.rating ?? 0)).font(.system(size: 12)).foregroundColor(Color.gray)
                                    Spacer()
                                    Text("Date create : "+String(formattedDateFromString(dateString: id.createdAt ?? "-", withFormat: "dd-mm-yyyy") ?? "-")).font(.system(size: 12)).foregroundColor(Color.gray)
                                }
                                
                                Divider()
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity,maxHeight: 120, alignment: .center)
                    }
                    
                }
            }
            Spacer()
            
        }.navigationBarTitle(Text(""), displayMode: .inline)
        
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieDetailViewModel()
        let interactor = MovieDetailInteractor(model: viewModel)
        let presenter = MovieDetailPresenter(interactor: interactor)
        MovieDetailView(presenter:presenter, dataMovie: MovieEntity.getRandomTestMovie)
        
    }
}


struct ImageViewDetail: View {
    let url: URL
    
    @StateObject private var image = FireImage()
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.white)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        }
        .onAppear { image.load(url) }
        .onDisappear(perform: image.reset)
        .animation(.default)
    }
}

struct YoutubeVideoView: UIViewRepresentable {
    
    var youtubeVideoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let path = "https://www.youtube.com/embed/\(youtubeVideoID)"
        guard let url = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}

