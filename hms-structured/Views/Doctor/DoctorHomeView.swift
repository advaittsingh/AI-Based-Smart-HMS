import SwiftUI
import SDWebImageSwiftUI
import Firebase

class Booking: ObservableObject {
    @Published var index: Int = 0
    @Published var date: Date = Date()
}

let booking: Booking = Booking()

struct DoctorHomeView: View {
    @State private var hello: String = "Mon"
    @State private var isDropdownExpanded = false
    @State private var selectedDate = Date()
    @State private var appointments: [Appointments] = []
    @State private var fetchedAppointments: [Appointments] = []
    @AppStorage("user_name") var userName: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @AppStorage("user_profile_url") var userProfileURL: String = ""
    @State var emergencyColor: Color = Color("bg-color1")
    func dateGetter(index: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: index, to: getFirstDayOfWeek(for: selectedDate))!
    }
    @State private var isBlinking: Bool = true
    @State var emergencyTitle: String = ""

    
    func getFirstDayOfWeek(for date: Date) -> Date {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        return startOfWeek
    }
    
    func getDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    
    func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func getMonthAndYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    @ObservedObject var indexDate = booking
    
    var body: some View {
        ZStack {
            NavigationView{
                ScrollView{
                    VStack{
                        VStack{
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .foregroundStyle(emergencyColor)
                                    .frame(height: 260)
                                    .frame(height: UIScreen.main.bounds.size.height * 0.20)
                                    .padding(.top,-130)
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Hello ")
                                            .foregroundColor(.white)
                                            .font(Font.custom("SF Pro Display", size: 30))
                                            .lineSpacing(22)
                                            .foregroundColor(.black)
                                        Text("\(userName)")
                                            .font(Font.custom("SF Pro Display", size: 30).weight(.semibold))
                                            .lineSpacing(22)
                                            .foregroundColor(.white)
                                            .scaleEffect(isBlinking ? 2.0 : 1.0)
                                            .animation(Animation.easeInOut(duration: 0.5).reverse(on: $isBlinking, delay:0.5))
                                    }
                                    .padding()
                                    Spacer()
                                    NavigationLink(destination: DProfile()) {
                                        if let imageUrl = URL(string: userProfileURL) {
                                            WebImage(url: imageUrl)
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding()
                                        } else {
                                            Image(systemName: "person.fill") // Placeholder icon
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .foregroundColor(.gray)
                                                .background(Color(.systemGray5))
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding()
                                        }
                                    }

                                    
                                }
                                
                            }
                        }
                        ScrollView{
                            
                            VStack {
                                HStack {
                                    Text(getMonthAndYear(date: selectedDate))
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Button(action: {
                                        self.isDropdownExpanded.toggle()
                                    }) {
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                    Text(emergencyTitle)
                                        .foregroundStyle(Color.red)
                                }
                                .padding([.horizontal, .top])
                                .cornerRadius(10)
                                
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0..<7) { i in
                                            let date = dateGetter(index: i)
                                            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                                            
                                            Button(action: {
                                                withAnimation {
                                                    indexDate.index = i
                                                    selectedDate = date
                                                    hello = getDay(date: date)
                                                }
                                                print(date)
                                            }) {
                                                VStack {
                                                    Text((getDay(date: date)))
                                                        .font(Font.custom("SF Pro Display Regular", size: 16))
                                                        .foregroundColor(isSelected ? .white : .black)
                                                    
                                                    Text((getDate(date: date)))
                                                        .font(Font.custom("SF Pro Display ", size: 18))
                                                        .foregroundColor(isSelected ? .white : .black)
                                                }
                                                .frame(alignment: .center)
                                                .padding(.leading)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .frame(width: 64, height: 80)
                                                        .foregroundColor(isSelected ? emergencyColor.opacity(01) : .white)
                                                        .padding(.leading)
                                                )
                                                .padding()
                                            }
                                        }
                                        
                                    }
                                    .frame(height: 85)
                                    .padding(.bottom)
                                    .padding(.trailing, 16)
                                    
                                }
                                
                                AppointmentView(temp: hello, appointments: fetchedAppointments,selectedDate: selectedDate, emergencyColor: emergencyColor, fetchAppointments: fetchAppointments, fetchEmergenyColr: fetchEmergencyColor)
                                Spacer()
                            }
                        }
                    }.padding(.top,50)
                }
                .refreshable {
                    fetchEmergencyColor()
                    fetchAppointments()
                }
            }
            
            
            
            if isDropdownExpanded {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isDropdownExpanded.toggle()
                    }
                
                VStack {
                    Spacer()
                    DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
            }
        }
        .background(
            Color(.white)
        )
        .onAppear {
            self.hello = getDay(date: Date())
            fetchAppointments()
            fetchEmergencyColor()
        }
    }
    
    func fetchAppointments() {
        let db = Firestore.firestore()
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        print("user id", userId)
        
        db.collection("appointments").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting appointments: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No appointments found")
                return
            }
        
            fetchedAppointments = []
            
            for document in documents {
                let data = document.data()
                
                for (key, appointmentData) in data {
                    if let appointmentData = appointmentData as? [String: Any] {
                        
                        if let doctorID = appointmentData["doctorID"] as? String, doctorID == userId{
                            
                            if let bookingDateTimestamp = appointmentData["bookingDate"] as? Timestamp {
                                let bookingDate = Date(timeIntervalSince1970: TimeInterval(bookingDateTimestamp.seconds))
                                // Now you can use the ⁠ bookingDate ⁠ in your ⁠ Appointments ⁠ struct
                                let appointment = Appointments(id:  key, bookingDate: bookingDate, timeSlot: appointmentData["timeSlot"] as? String, doctorID: appointmentData["doctorID"] as? String ?? "", doctorName: appointmentData["doctorName"] as? String ?? "", doctorDepartment: appointmentData["doctorDepartment"] as? String ?? "", patientName: appointmentData["patientName"] as? String ?? "", patientID: appointmentData["patientID"] as? String ?? "")
                                userName = appointment.doctorName
                                userUID = appointment.doctorID
                                fetchedAppointments.append(appointment)
//                                print(fetchedAppointments)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func fetchEmergencyColor() {
        let db = Firestore.firestore()
        
        db.collection("emergency_notifications").document("emergencyNotification").getDocument { document, error in
            if let error = error {
                print("Error getting emergency notification: \(error)")
                return
            }
            
            guard let document = document else {
                print("No emergency notification document found")
                return
            }
            
            if let isActive = document["isActive"] as? Int, isActive != 0 {
                print("efekfefepije", document["isActive"])

                if let hexCode = document["hexCode"] as? String {
                    DispatchQueue.main.async {
                        self.emergencyColor = getColorForEmergencyNotification(hexCode: hexCode)
                    }
                }

                if let emergencyTitle = document["body"] as? String {
                    DispatchQueue.main.async {
                        self.emergencyTitle = emergencyTitle
                    }
                }
            } else {
                self.emergencyColor = .bgColor1
                self.emergencyTitle = ""
                print("falseee")
                return
            }

        }
    }

    func getColorForEmergencyNotification(hexCode: String) -> Color {
        // Convert hex string to Color
        if let uiColor = UIColor(hexString: hexCode) {
            return Color(uiColor)
        } else {
            return Color("bg-color1") // Default color if conversion fails
        }
    }

}

struct DoctorHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorHomeView()
    }
}

struct AppointmentView: View {
    var temp: String
    var appointments: [Appointments]
    var selectedDate: Date
    var emergencyColor: Color
    var fetchAppointments:() -> Void
    var fetchEmergenyColr:() -> Void
    var body: some View {
        ScrollView{
            VStack {
                ForEach(0..<4) { i in
                    DisclosureGroup(
                        content: { VStack{
                            ForEach(Array(appointments.enumerated()), id: \.element) { index,appointment in
                                NavigationLink(destination: RecordsView1(patientID: appointment.patientID,patientName: appointment.patientName), label:{
                                    if retrieveDatePortion(from: selectedDate) == retrieveDatePortion(from: appointment.bookingDate) {
                                        if(appointment.timeSlot == "11:00 - 12:00" && i == 1){
                                            HStack() {
                                                VStack(alignment: .leading){
                                                    Text(appointment.patientName)
                                                      .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                                      .tracking(0.16)
                                                      .lineSpacing(21.60)
                                                      .foregroundColor(.black)

                                                }
                                                .padding(.leading)
                                                
                                              Spacer()
                                                
                                            }
                                            .frame(width: 218, height: 84)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .padding([.horizontal,.vertical],5)
                                            
                                        }
                                        else if(appointment.timeSlot == "9:00 - 11:00" && i == 0){
                                            HStack() {
                                                VStack(alignment: .leading){
                                                    Text(appointment.patientName)
                                                      .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                                      .tracking(0.16)
                                                      .lineSpacing(21.60)
                                                      .foregroundColor(.black)

                                                }
                                                .padding(.leading)
                                                
                                              Spacer()
                                                Image(systemName: "arrow.forwardarrow.forward")
                                            }
                                            .frame(width: 218, height: 84)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .padding([.horizontal,.vertical],5)
                                        }
                                        else if(appointment.timeSlot == "12:00 - 2:00" && i == 2){
                                            HStack() {
                                                VStack(alignment: .leading){
                                                    Text(appointment.patientName)
                                                      .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                                      .tracking(0.16)
                                                      .lineSpacing(21.60)
                                                      .foregroundColor(.black)

                                                }
                                                .padding(.leading)
                                                
                                              Spacer()
                                                Image(systemName: "arrow.forwardarrow.forward")
                                            }
                                            .frame(width: 218, height: 84)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .padding([.horizontal,.vertical],5)
                                        }
                                        else if(appointment.timeSlot == "2:00 - 4:00" && i == 3){
                                            HStack() {
                                                VStack(alignment: .leading){
                                                    Text(appointment.patientName)
                                                      .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                                      .tracking(0.16)
                                                      .lineSpacing(21.60)
                                                      .foregroundColor(.black)

                                                }
                                                .padding(.leading)
                                                
                                              Spacer()
                                                Image(systemName: "arrow.forwardarrow.forward")
                                            }
                                            .frame(width: 218, height: 84)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .padding([.horizontal,.vertical],5)
                                        }
                                        
                                        
                                    }
                                })
                                .contextMenu {
                                    Button {
                                        deleteAppointment(appointment: appointment)
                                    } label: {
                                        Label("Cancel Appointment", systemImage: "trash")
                                    }
                                }
                            }
                            
                        }.background(Color.gray.opacity(1))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.leading,100)
                        },
                        label: { HStack{
                            ZStack() {
                              
                                if(i == 0){
                                    Rectangle()
                                      .foregroundColor(.clear)
                                      .frame(width: 86.78, height: 96)
                                      .background(emergencyColor)
                                      .cornerRadius(20)
                                    Text("\(temp)")
                                      .font(Font.custom("SF Pro Display", size: 20).weight(.medium))
                                      .foregroundColor(.white)
                                }
                                
                                
                                
                            }
                            .frame(width: 86.78, height: 96)
                            ZStack() {
                              Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 249.62, height: 96)
                                .background(emergencyColor)
                                .cornerRadius(20)
                                VStack(alignment: .leading){
                                    if(i == 0 || i == 1){
                                        VStack(alignment: .leading){
                                            Text(i == 0 ? "9:00 - 11:00" : "11:00 - 12:00")
                                              .font(Font.custom("SF Pro Display", size: 25).weight(.semibold))
                                              .foregroundColor(.white)
                                              
                                        }.padding()
                                    }
                                    else{
                                        VStack(alignment: .leading){
                                            Text(i == 2 ? "12:00 - 2:00" : "2:00 - 4:00")
                                              .font(Font.custom("SF Pro Display", size: 25).weight(.semibold))
                                              .foregroundColor(.white)
                                        }.padding()
                                    }
                                    
                                     
                                }
                                .offset(x:-30)
                            }
                            .frame(width: 249.62, height: 96)
                        }  }
                    ).padding(.horizontal)
                    
                }
            }.onAppear(){
    //            print("appointments",appointments)
            }
        }
        .refreshable {
            fetchEmergenyColr()
        }
        
    }
    func retrieveDatePortion(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Choose the desired date format
        
        return dateFormatter.string(from: date)
    }
    
    func deleteAppointment(appointment: Appointments) {
        let db = Firestore.firestore()
        let userId = appointment.patientID

        let documentRef = db.collection("appointments").document(userId)
        
        print("apt id",appointment)

        documentRef.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            guard let snapshot = snapshot else {
                print("Document does not exist")
                return
            }

            guard var appointmentsMap = snapshot.data() as? [String: Any] else {
                print("Document data is empty")
                return
            }

            appointmentsMap.removeValue(forKey: appointment.id ?? "")

            documentRef.setData(appointmentsMap) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Appointment successfully deleted")
                    fetchAppointments()
                    
                }
            }
        }
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension Animation {
    func reverse(on: Binding<Bool>, delay: Double) -> Self {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            on.wrappedValue = false /// Switch off after `delay` time
        }
        return self
    }
}
