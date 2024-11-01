import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class AddDoctorsViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    private var db = Firestore.firestore()
    private let storageRef = Storage.storage().reference().child("doctorProfileImages")

    // Fetch doctors from Firestore
    func fetchDoctors() {
        db.collection("doctors").getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting doctors: \(error)")
                return
            }

            guard let documents = querySnapshot?.documents else { return }
            self.doctors = documents.compactMap { doc in
                try? doc.data(as: Doctor.self)
            }
        }
    }

    // Add doctor and upload profile image if available
    func addDoctor(doctor: Doctor, image: UIImage?) {
        Task {
            do {
                // Upload image and get download URL
                let downloadURL = try await uploadProfileImage(image)
                
                // Create user account with email and password
                let userId = try await createUserAccount(email: doctor.email, password: "123456")
                
                // Save doctor to Firestore
                var updatedDoctor = doctor
                updatedDoctor.profileImageURL = downloadURL?.absoluteString ?? ""
                try await saveDoctorToFirestore(doctor: updatedDoctor, userId: userId)
                
                fetchDoctors() // Optionally refresh doctor list after successful addition
                print("Doctor added successfully with user ID: \(userId)")
            } catch {
                print("Failed to add doctor: \(error)")
            }
        }
    }

    // Upload profile image to Firebase Storage
    private func uploadProfileImage(_ image: UIImage?) async throws -> URL? {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return nil }
        let imageRef = storageRef.child("\(UUID().uuidString).jpg")
        
        let _ = try await imageRef.putDataAsync(imageData)
        return try await imageRef.downloadURL()
    }

    // Create Firebase user account with email and password
    private func createUserAccount(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user.uid
    }

    // Save doctor to Firestore with specified user ID
    private func saveDoctorToFirestore(doctor: Doctor, userId: String) async throws {
        try await db.collection("doctors").document(userId).setData(from: doctor)
    }

    // Delete doctor by ID from Firestore and local list
    func deleteDoctor(doctorId: String) {
        db.collection("doctors").document(doctorId).delete { [weak self] error in
            if let error = error {
                print("Error removing doctor: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self?.doctors.removeAll { $0.id == doctorId }
                print("Doctor successfully deleted with ID: \(doctorId)")
            }
        }
    }
}
