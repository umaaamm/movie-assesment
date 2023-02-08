//
//  TestMovies.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

extension MovieEntity {
    static var randomId: Int {Int.random(in: 1...99999)}
    private static var test: MovieEntity {
        MovieEntity(id: randomId,
                    original_title: "Puss in Boots: The Last Wish",
                    title: "M3GAN",
                    overview: "A brilliant toy company roboticist uses artificial intelligence to develop M3GAN, a life-like doll programmed to emotionally bond with her newly orphaned niece. But when the doll's programming works too well, she becomes overprotective of her new friend with terrifying results.",
                    popularity: 224548,
                    vote_average: "8.1",
                    vote_count: 3089,
                    poster: "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
                    release_date: "2022-10-16",
                    genre: MoviesGenre.getRandom,
                    backdrop_path: "/faXT8V80JRhnArTAeYXz0Eutpv9.jpg")
    }
    
    private static var test2: MovieEntity {
        MovieEntity(id: randomId,
                    original_title: "Puss in Boots: The Last Wish",
                    title: "M3GAN",
                    overview: "A brilliant toy company roboticist uses artificial intelligence to develop M3GAN, a life-like doll programmed to emotionally bond with her newly orphaned niece. But when the doll's programming works too well, she becomes overprotective of her new friend with terrifying results.",
                    popularity: 224548,
                    vote_average: "8.1",
                    vote_count: 3089,
                    poster: "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
                    release_date: "2022-10-16",
                    genre: MoviesGenre.getRandom,
                    backdrop_path: "/faXT8V80JRhnArTAeYXz0Eutpv9.jpg")
    }
    
    private static var test3: MovieEntity {
        MovieEntity(id: randomId,
                    original_title: "Puss in Boots: The Last Wish",
                    title: "M3GAN",
                    overview: "A brilliant toy company roboticist uses artificial intelligence to develop M3GAN, a life-like doll programmed to emotionally bond with her newly orphaned niece. But when the doll's programming works too well, she becomes overprotective of her new friend with terrifying results.",
                    popularity: 224548,
                    vote_average: "8.1",
                    vote_count: 3089,
                    poster: "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
                    release_date: "2022-10-16",
                    genre: MoviesGenre.getRandom,
                    backdrop_path: "/faXT8V80JRhnArTAeYXz0Eutpv9.jpg")
    }
    
    
    static var getRandomTestMovie: MovieEntity { [test,test2,test3].randomElement()!}
    
    static func fakes(quantity: Int) -> [MovieEntity] {
        var res: [MovieEntity] = [MovieEntity]()
        for _ in 1...quantity{
            res.append(MovieEntity.getRandomTestMovie)
        }
        return res
    }
    static var fakes: [MovieEntity] { fakes(quantity: 5)}
    
}
