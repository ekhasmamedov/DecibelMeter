//
//  MainView.swift
//  DecibelMeter
//
//  Created by Eldar Khasmamedov on 2021-12-01.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var recordingService: RecordingService
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            Text(viewModel.decibelText)
                .font(Font.system(size: 46))
        }
        .onAppear() {
            viewModel.onAppear(recordingService: recordingService)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
            .environmentObject(RecordingService())
    }
}
