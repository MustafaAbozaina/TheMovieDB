//
//  ImageView+RemoteImages.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 29/12/2023.
//

import SwiftUI
import Kingfisher


struct RemoteImage: View {
    
    var urlPath: String?
    
    var body: some View {
        KFImage(URL(string: urlPath ?? ""))
            .resizable()
    }
}
