import SwiftUI

struct CocktailRecipeCard: View {
    let cocktail: Cocktail

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(cocktail.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            VStack(alignment: .leading, spacing: 8) {
                Text("Ingredients")
                    .font(.headline)
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    Text("• " + ingredient)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Instructions")
                    .font(.headline)
                Text(cocktail.instructions)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    CocktailRecipeCard(cocktail: Cocktail(
        name: "Sample Cocktail",
        ingredients: ["1 oz Something", "2 oz Something Else"],
        instructions: "Mix and enjoy!"
    ))
}
