//
//  VolunteerEventRegisterView.swift
//  Feedapp
//
//  Created by Gagandeep on 14/06/22.
//

import SwiftUI

struct VolunteerEventRegisterView: View {
    @State var postid: Int = 0
    @State private var showingModal = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var eventdata = events(eventInclusionCount:0, eventData: eventsdata(storyCreatorId:0,feedName:"-", eventLocationId:0,eventDateInstancId:0,eventDate:"-", hideName:0,cityId:0,stateId:0,countryId:0,elocation:"",start_time:"-",locationLag:"-",locationLat:"-"), eventInclusionData:["-"])
    
    var body: some View {
//        NavigationView {
        ZStack{
            VStack(){
                HStack(spacing: 5){
                    Image(uiImage: UIImage(named: "stopwatch-thin")!)
                            .resizable()
                            .foregroundColor(Color.blue)
                    .frame(width: 25, height: 25)
                    
                    Text(eventdata.eventData.feedName)
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.black)
               Spacer()
                }.padding()
                HStack(spacing: 5){
                    Image(uiImage: UIImage(named: "calendar-thin")!)
                            .resizable()
                            .foregroundColor(Color.blue)
                    .frame(width: 25, height: 25)
                    
                    Text(eventdata.eventData.eventDate)
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.black)
               Spacer()
                }.padding()
                HStack(spacing: 5){
                    Image(uiImage: UIImage(named: "clock-ten-thin")!)
                            .resizable()
                            .foregroundColor(Color.blue)
                    .frame(width: 25, height: 25)
                    
                    Text(eventdata.eventData.start_time)
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.black)
               Spacer()
                }.padding()
                HStack(spacing: 5){
                    Image(uiImage: UIImage(named: "hand-heart-thin")!)
                            .resizable()
                            .foregroundColor(Color.blue)
                    .frame(width: 25, height: 25)
                    
                    Text(eventdata.eventData.feedName)
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.black)
               Spacer()
                }.padding()
                HStack(spacing: 5){
                    Image(uiImage: UIImage(named: "thumbs-up-thin")!)
                            .resizable()
                            .foregroundColor(Color.blue)
                    .frame(width: 25, height: 25)
                    
                    Text(eventdata.eventInclusionData[0])
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.black)
                        .onTapGesture{self.showingModal = true}
                    
                    if (eventdata.eventInclusionCount != 1){
                    Text("+ \(eventdata.eventInclusionCount - 1) Inclusions")
                        .font(.custom("Muli-regular", size: 18))
                        .frame(alignment:.leading)
                        .padding(.leading ,5)
                        .foregroundColor(Color.textYellow)
                    }
                    
               Spacer()
                }.padding()
                
          
            Spacer()
                
                HStack(alignment: .bottom,spacing: 30){
                Text("CANCEL")
                    .font(.custom("Muli-regular", size: 15))
                        .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(5)
                    .onTapGesture{self.presentationMode.wrappedValue.dismiss()}
                Text("CONFIRM")
                    .font(.custom("Muli-regular", size: 15))
                        .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(5)
//                    .padding(.horizontal)
//                    .frame(maxWidth: .infinity )
//                    .frame(width: 200)
                }.padding(.bottom ,10)
              

        }.onAppear {
            geteventsdetail().getevents(postId: postid) { (evnt) in
                self.eventdata = evnt
            print(evnt)
            }
        }.background(Color.customGrey.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Confirm Voluneering", displayMode: .inline)
            
            if $showingModal.wrappedValue {
                            // But it will not show unless this variable is true
                            ZStack {
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.vertical)
                                    .onTapGesture{self.showingModal = false}
                                // This VStack is the popup
                                VStack(spacing:0.5) {
                                    ForEach(eventdata.eventInclusionData, id: \.self) { includedata in
                                        Text(includedata)
                                    }
                                  
                                    
                                }.padding()
                                .frame(width: UIScreen.screenWidth * 0.85)
                                .background(Color.white)
                                .cornerRadius(20).shadow(radius: 20)
                            }
            }

            
        }.frame(alignment: .top)
            
            
                        
        
        
    

    }
}




struct VolunteerEventRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerEventRegisterView()
    }
}
