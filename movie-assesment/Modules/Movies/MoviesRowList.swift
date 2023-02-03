//
//  MoviesRowList.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import SwiftUI
import FetchImage

struct MovieRow: View {
    let movie: MovieEntity
    var body: some View {
        HStack(alignment: .top){
            ImageView(url: movie.imageURL).frame(width: 100,height: 150)
            VStack(alignment: .leading){
                
                Text(movie.title).font(.headline).foregroundColor(Color.black).multilineTextAlignment(.center)
                
                Text(movie.overview)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                HStack{
                    Text(String(movie.genre)).font(.system(size: 12)).foregroundColor(Color.gray).padding(5).border(.gray).cornerRadius(3)
                    
                }
                
                Spacer()
                HStack{
                    Text(String(movie.vote_average)).font(.system(size: 12)).foregroundColor(Color.gray)
                    ForEach(0..<Int(5)) { _ in
                        Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 12))
                    }
                }
                Spacer()
                
                HStack{
                    if let releaseDate = movie.release_date{
                        Text("Release date :").font(.system(size: 12)).foregroundColor(Color.gray)
                        Text(releaseDate)
                            .font(.system(size: 12)).foregroundColor(Color.gray)
                    }
                }
                Divider()
            }
        }.frame(minWidth: 0, maxWidth: .infinity,maxHeight: 180, alignment: .center)
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ForEach(1..<6){_ in
                MovieRow(movie: MovieEntity.getRandomTestMovie)
            }
        }.padding([.leading,.trailing],20)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


struct ImageView: View {
    let url: URL
    
    @StateObject private var image = FireImage()
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
        }
        .onAppear { image.load(url) }
        .onDisappear(perform: image.reset)
        .animation(.default)
    }
}
