//
//  ContentView.swift
//  URLShortner
//
//  Created by Utkirjon on 09/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                header()
                
                ForEach(viewModel.models, id: \.self) { model in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("https://1pt.co/"+model.short)
                            Text(model.long)
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        guard let url = URL(string: "https://1pt.co/"+model.short) else {
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                    
            }
            .navigationTitle("SHORT URLs")
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        VStack {
            Text("Enter URL to be shortened")
                .bold()
                .font(.system(size: 26))
                .foregroundColor(Color.white)
                .padding()
            
            TextField("URL...", text: $text)
                .padding()
                .autocapitalization(.none)
                .background(Color.white)
                .cornerRadius(8)
                .padding()
            
            Button(action: {
                // make api call
                guard !text.isEmpty else {
                    return
                }
                viewModel.submit(urlString: text)
                
                text = ""
                
                
            },
                   label: {
                Text("SUBMIT")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 240, height: 50)
                    .background(Color.pink)
                    .cornerRadius(8)
                    .padding()
            })
        
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.width)
        .background(Color.blue)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
