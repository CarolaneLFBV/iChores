import SwiftUI

//struct FloatingLabel: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("UserTesting")
//                .font(.headline)
//                .padding(.leading, 15)
//            
//            ForEach(userData.rooms, id: \.self) { room in
//                VStack(alignment: .leading) {
//                    Text(room.name)
//                        .font(.subheadline)
//                        .padding(.leading, 30) // Décaler le nom de la pièce vers la droite
//                    
//                    ForEach(room.tasks, id: \.self) { task in
//                        HStack {
//                            Circle()
//                                .frame(width: 5, height: 5)
//                                .foregroundColor(.black)
//                            Text(task)
//                        }
//                        .padding(.leading, 45) // Décaler la tâche plus à droite
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(lineWidth: 2)
//                .foregroundColor(.black)
//        )
//        .padding() // Pour ne pas toucher les bords de l'écran
//    }
//}

