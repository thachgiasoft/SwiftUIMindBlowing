//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftUI

struct ExampleView<Content>: View where Content: View {

    @ObservedObject var store = WKWebViewStore.shared
    @State private var viewIndex = 0

    private var title: String
    private var demoContentView: () -> Content
    private let remoteSourcePath: String

    public init(title: String = "", demoContentView: @autoclosure @escaping () -> Content, remoteSourcePath: String) {
        self.title = title
        self.demoContentView = demoContentView
        self.remoteSourcePath = remoteSourcePath
    }

    var body: some View {
        VStack {
            Picker(selection: self.$viewIndex, label: Text("Demo")) {
                Text("Demo").tag(0)
                Text("Source").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())

            if self.viewIndex == 0 {
                GeometryReader { geometry in
                    VStack {
                        self.demoContentView()
                    }
                }
            } else if self.viewIndex == 1 {
                VStack {
                    Toggle(isOn: $store.shouldWrapWord) {
                        Text("Wrap text")
                    }
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                    WKWebViewUI(remoteSourcePath: self.remoteSourcePath, shouldWrapWord: store.shouldWrapWord)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .navigationBarTitle(title)
    }
}

#if DEBUG
struct BaseExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView(
            demoContentView: Text("Demo"),
            remoteSourcePath: "https://raw.githubusercontent.com/peacemoon/SwiftUIMindBlowing/master/SwiftUIMindBlowing/Scenes/Basic/ViewsAndControls/Text/TextExampleView.swift"
        )
    }
}
#endif
