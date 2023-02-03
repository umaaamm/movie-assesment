////
////  ImagesViews.swift
////  movie-assesment
////
////  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
////
//
//import SwiftUI
//import FetchImage
//
//struct ImageViewNew: View {
////    let url: URL
////    @StateObject private var image = FireImage()
//    @ObservedObject var image = FireImage()
//
//    let posterSize: PosterStyle.Size
//     init (image: FireImage, posterSize: PosterStyle.Size = .medium){
//       self.image = image
//       self.posterSize = posterSize
//     }
//
//    var body: some View {
//        ZStack {
//            Rectangle().fill(Color.gray).posterStyle(loaded: false, size: posterSize)
//            image.view?
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .clipped()
//        }
//        .onAppear { image.load("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpsw9SAPFMtBpwf-2LMOZdyLFSvzvHeycbkb5nYSmB_dlmUlHEqZG_Lq_Cm7ihcm3pD5M&usqp=CAU") }
//        .onDisappear(perform: image.reset)
//    }
//}
//
//struct PosterStyle: ViewModifier {
//    public enum Size {
//        case small, medium, big, tv
//
//        func width() -> CGFloat {
//            switch self {
//            case .small: return 53
//            case .medium: return 100
//            case .big: return 180
//            case .tv: return 333
//            }
//        }
//        func height() -> CGFloat {
//            switch self {
//            case .small: return 80
//            case .medium: return 150
//            case .big: return 270
//            case .tv: return 500
//            }
//        }
//    }
//
//    let loaded: Bool
//    let size: Size
//
//    func body(content: Content) -> some View {
//        return content
//            .frame(width: size.width(), height: size.height())
//            .cornerRadius(5)
//            .opacity(loaded ? 1 : 0.1)
//            .shadow(radius: 8)
//    }
//}
//
//extension View {
//    func posterStyle(loaded: Bool, size: PosterStyle.Size) -> some View {
//        return ModifiedContent(content: self, modifier: PosterStyle(loaded: loaded, size: size))
//    }
//}
