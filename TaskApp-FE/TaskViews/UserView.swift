import SwiftUI

struct UserProfileSheet: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // User Icon
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
            
            // User Email
            if let user = viewModel.currentUser {
                Text(user.email)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            } else if viewModel.isLoading {
                ProgressView()
            }
            // Sign Out Button
            Button(action: {
                Task {
                    await viewModel.signOut()
                    dismiss()
                }
            }) {
                Text("Sign Out")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .frame(height: 227)
        .background(Color.white)
        .task {
//            if viewModel.isAuthenticated && viewModel.user == nil {
//                await viewModel.fetchUser()
            }
        }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileSheet()
    }
}
