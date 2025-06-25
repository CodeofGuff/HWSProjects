import SwiftUI

struct Cocktail: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [String]
    let instructions: String
}

struct ContentView: View {
    let cocktails = [
        Cocktail(
            name: "Margarita",
            ingredients: ["2 oz Tequila", "1 oz Lime juice", "1 oz Cointreau", "Salt for rim"],
            instructions: "1. Rim the glass with salt.\n2. Shake all ingredients with ice.\n3. Strain into the glass over fresh ice."
        ),
        Cocktail(
            name: "Negroni",
            ingredients: ["1 oz Gin", "1 oz Campari", "1 oz Sweet Vermouth", "Orange peel for garnish"],
            instructions: "1. Stir gin, Campari, and vermouth with ice.\n2. Strain into a glass with ice.\n3. Garnish with orange peel."
        ),
        Cocktail(
            name: "Old Fashioned",
            ingredients: ["2 oz Bourbon", "1 sugar cube", "2 dashes Angostura bitters", "Orange twist"],
            instructions: "1. Muddle sugar and bitters.\n2. Add bourbon and ice, stir.\n3. Garnish with orange twist."
        )
    ]

    var body: some View {
        NavigationStack {
            List(cocktails) { cocktail in
                NavigationLink(destination: CocktailRecipeCard(cocktail: cocktail)) {
                    Text(cocktail.name)
                }
            }
            .navigationTitle("Cocktails")
        }
    }
}
