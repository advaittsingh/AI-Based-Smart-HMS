//
//  AddDoctorView.swift
//  hms
//
//  Created by Divyanshu Pabia on 23/04/24.
//

import SwiftUI
import FirebaseAuth

struct AddDoctorView: View {
    
    @State private var showingImagePicker = false
    @State private var profileImageData: Data? = nil
    @State private var profileImage: UIImage? = nil

    // Personal Details
    @State var fullName: String = ""
    @State private var gender = 0
    @State private var dateOfBirth = Date()
    @State var emailTextField: String = ""
    @State var phoneTextField: String = ""
    @State var emergencyContactTextField: String = ""
    
    // Professional Information
    @State var employeeID: String = ""
    @State private var department = 0
    @State var qualification: String = ""
    @State var position: String = ""
    @State var startDate: Date = Date()

    // Professional Licenses
    @State var licenseNumber: String = ""
    @State var issuingOrganization: String = ""
    @State var expiryDate: Date = Date()

    // Description
    @State var description: String = ""
    @State var yearsOfExperience: String = ""
    
    @State var loginEmail : String = ""
    @State var loginPwd : String = ""
    
    let chosenGender = ["Female","Male","Prefer not to disclose"]
    let chosenDept = [
        "Emergency Medicine", "General Physician", "Cardiology", "Obstetrics & Gynecology",
        "Pediatrics", "Oncology", "Neurology", "Orthopedics", "Radiology", "Internal Medicine"
    ]
    
    @State private var isEmailValidFlag = true
    @State private var isPhoneValidFlag = true
    @State private var showAlert = false
    
    @StateObject var addDoctorVM = AddDoctorsViewModel()
    
    var body: some View {
        Form {
            Text("Add Doctor")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Section(header: Text("Profile Image")) {
                Button(action: { showingImagePicker = true }) {
                    VStack {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(selectedImage: $profileImage)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top)
            
            Section(header: Text("Personal Details")) {
                TextField("Full Name", text: $fullName)
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                
                Picker("Gender", selection: $gender) {
                    ForEach(0..<chosenGender.count, id: \.self) { index in
                        Text(self.chosenGender[index]).tag(index)
                    }
                }
                
                HStack {
                    TextField("Email", text: $emailTextField, onEditingChanged: { _ in validateEmail() })
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    Spacer()
                    if !isEmailValidFlag {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                HStack {
                    TextField("Phone Number", text: $phoneTextField, onEditingChanged: { _ in validatePhone() })
                        .keyboardType(.phonePad)
                    Spacer()
                    if !isPhoneValidFlag {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                TextField("Emergency Contact", text: $emergencyContactTextField)
            }

            Section(header: Text("Professional Details")) {
                TextField("Employee ID", text: $employeeID)
                Picker("Department", selection: $department) {
                    ForEach(0..<chosenDept.count, id: \.self) { index in
                        Text(self.chosenDept[index]).tag(index)
                    }
                }
                TextField("Qualification", text: $qualification)
                TextField("Position", text: $position)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            }

            Section(header: Text("Professional Licenses")) {
                TextField("License Number", text: $licenseNumber)
                TextField("Issuing Organization", text: $issuingOrganization)
                DatePicker("Expiry Date", selection: $expiryDate, displayedComponents: .date)
            }

            Section(header: Text("Details")) {
                TextField("Description", text: $description)
                TextField("Years of Experience", text: $yearsOfExperience)
            }
            
            Button(action: { showAlert = true }) {
                Text("Save")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 325, height: 48)
                    .background(isFormValid() ? Color.blue : Color.gray)
                    .cornerRadius(15)
            }
            .disabled(!isFormValid())
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirm Update"),
                    message: Text("Are you sure you want to save these details?"),
                    primaryButton: .default(Text("Confirm")) {
                        let lastThreeChars = licenseNumber.suffix(3)
                        loginEmail = "doctor\(lastThreeChars)@gmail.com"
                        loginPwd = "123456"

                        let newDoctor = Doctor(
                            fullName: fullName,
                            gender: chosenGender[gender],
                            dateOfBirth: dateOfBirth,
                            email: emailTextField,
                            phone: phoneTextField,
                            emergencyContact: emergencyContactTextField,
                            profileImageURL: "",
                            employeeID: employeeID,
                            department: chosenDept[department],
                            qualification: qualification,
                            position: position,
                            startDate: startDate,
                            licenseNumber: licenseNumber,
                            issuingOrganization: issuingOrganization,
                            expiryDate: expiryDate,
                            description: description,
                            yearsOfExperience: yearsOfExperience
                        )

                        addDoctorVM.addDoctor(doctor: newDoctor, image: profileImage)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    // MARK: - Validation Functions
    private func validateEmail() {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isEmailValidFlag = NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: emailTextField)
    }
    
    private func validatePhone() {
        let phonePattern = "^[0-9+]{0,1}+[0-9]{5,16}$"
        isPhoneValidFlag = NSPredicate(format: "SELF MATCHES %@", phonePattern).evaluate(with: phoneTextField)
    }

    private func isFormValid() -> Bool {
        !fullName.isEmpty &&
        isEmailValidFlag &&
        isPhoneValidFlag &&
        !employeeID.isEmpty &&
        !qualification.isEmpty &&
        !position.isEmpty &&
        !licenseNumber.isEmpty &&
        !issuingOrganization.isEmpty &&
        !description.isEmpty &&
        !yearsOfExperience.isEmpty
    }
}

// MARK: - ImagePicker Struct
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Preview
struct AddDoctorView_Previews: PreviewProvider {
    static var previews: some View {
        AddDoctorView()
    }
}
