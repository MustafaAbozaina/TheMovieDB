//
//  MainNavigtionStack.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 30/12/2023.
//

import SwiftUI

struct RootNavigationStack<SubView: View>: View {
    let rootView: SubView
    @ObservedObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.navPath, root: {
            rootView
                .environmentObject(router)
                .navigationDestination(for: Int.self) { movieId in
                    ModuleFactory().createMovieDetailsSwiftUIScene(movieId: movieId)
                }
        })
    }
}

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    
    func navigate(from destination: NavigationSource) {
        switch destination {
        case .moviesList(let movieId):
            navPath.append(movieId)
        }
    }
    
    func navigateBack() {
        guard navPath.count > 0 else {return}
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    public enum NavigationSource: Hashable {
        case moviesList(_ movieId: Int)
    }
}
