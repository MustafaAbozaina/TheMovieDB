//
//  MainNavigtionStack.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 30/12/2023.
//

import SwiftUI

struct RootNavigationStack<SubView: View>: View {
    var rootView: SubView
    var body: some View {
        NavigationStack(root: buildRootView)
    }
    
    func buildRootView() -> some View {
        return rootView
    }
}
