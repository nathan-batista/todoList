//
//  LoadingContentView.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 06/02/23.
//

import SwiftUI

struct LoadingContentView<Content>: View where Content: View {
    @Binding var state: ViewModelState
    let content: () -> Content
    
    var loadingView: ProgressView = {
        return ProgressView()
    }()
    
    init(state: Binding<ViewModelState>, @ViewBuilder content: @escaping() -> Content) {
        self._state = state
        self.content = content
    }
    
    var body: some View {
        ZStack {
            if self.state == .loading {
                loadingView
            } else {
                content()
            }
        }
    }
}

struct LoadingContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingContentView<Text>(state: .constant(.idle), content: { Text("Olá") } )
    }
}
