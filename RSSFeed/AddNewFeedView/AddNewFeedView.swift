//
//  AddNewFeedView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import SwiftUI

struct AddNewFeedView: View {
    @FocusState private var emailFieldIsFocused: Bool
    @Binding var rssFeedUrl: String
    var doneButtonTapped: ((String?) -> Void)
    
    var body: some View {
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    Text("Add new feed")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Button(action: {
                        if !rssFeedUrl.isEmpty {
                            doneButtonTapped(rssFeedUrl)
                        } else {
                            doneButtonTapped(nil)
                        }
                    }) {
                        Text("Done")
                            .foregroundStyle(.white)
                    }
                }
                .padding(20)
                
                TextField("Enter provider URL", text: $rssFeedUrl)
                    .padding(10)
                    .focused($emailFieldIsFocused)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.cyan)
                    .clipShape(.capsule)
                    .padding(20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
