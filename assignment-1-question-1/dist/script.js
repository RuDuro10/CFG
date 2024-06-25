// Function to get and display the recipe
function getRecipe() {
  
  // Get user input and container element
  const mealInput = document.getElementById('mealInput').value.toLowerCase();
  const recipeContainer = document.getElementById('recipeContainer');

  // Sample recipes
  const recipes = [
    { name: 'pizza', ingredients: 'Dough, Tomato Sauce, Cheese, Toppings of your choice' },
    { name: 'pasta', ingredients: 'Pasta, Tomato Sauce, Olive Oil, Garlic, Parmesan Cheese' },
    { name: 'salad', ingredients: 'Lettuce, Tomatoes, Cucumbers, Olive Oil, Vinegar, Salt, Chicken' }
  ];

  // Use a while loop to iterate over the array of recipes
  let i = 0;
  let recipeFound = false;

  while (i < recipes.length && !recipeFound) {
    const currentRecipe = recipes[i];

    // Check if the user input matches the current recipe
    if (currentRecipe.name === mealInput) {
      // Display the recipe if found
      recipeContainer.innerHTML = `<p>Recipe for ${currentRecipe.name}: ${currentRecipe.ingredients}</p>`;
      console.log(`Recipe for ${mealInput} displayed.`);
      recipeFound = true; // Set flag to exit the loop
    }

    i++; // Move to the next recipe
  }

  // Display a message if the meal is not found
  if (!recipeFound) {
    recipeContainer.innerHTML = '<p>Recipe not found. Please try another meal.</p>';
    console.log('Recipe not found.');
  }
}