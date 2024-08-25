//
//  CharacterDetailsView.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    var character: Character
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack(alignment: .topLeading) {
                // Avatar image
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

                // Custom back button
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(Constants.primaryPurpleColor))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(.leading, 16)
                .padding(.top, UIApplication.shared.connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.windows.first?.safeAreaInsets.top }
                    .first ?? 0)
                .accessibilityIdentifier("customBackButton")
            }

            // Name, Species, Gender, ID, and Status section
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(character.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(Constants.primaryPurpleColor))

                    Text(character.species)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)

                    Text("Gender: \(character.gender ?? "Unknown")")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)

                    Text("ID: \(character.id)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .center) {
                    Text(character.status)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(Constants.primaryPurpleColor))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            Color(Constants.statusColors[character.status] ?? .gray)
                        )
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .onDisappear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
                navigationController.isNavigationBarHidden = false
            }
        }
    }
}
