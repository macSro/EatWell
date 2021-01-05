import 'package:flutter/material.dart';

//TEXTS
const kAppName = 'EatWell XO';
const kDefaultUserDisplayName = 'Chef';

//MESSAGES
const kErrorOccurredMessage = 'An error occurred.';
const kUserRegisterFailedMessage = 'Registration failed.';
const kUserAuthenticationFailedMessage = 'Authentication failed.';
const kSignOutFailedMessage = 'Sign out failed.';

//COLOR PALETTE
const kPrimaryColor = Color(0xFF4CAF50);
const kPrimaryColorDark = Color(0xFF388E3C);
const kPrimaryColorLight = Color(0xFFC8E6C9);
const kAccentColor = Color(0xFFCDDC39);
const kTextColorPrimary = Color(0xFF212121);
const kTextColorSecondary = Color(0xFF757575);
const kDividerColor = Color(0xFFBDBDBD);

//PATHS
const kRecipeImageUrlBasePath = 'https://spoonacular.com/recipeImages/';
const kIngredientImageUrlBasePath = 'https://spoonacular.com/cdn/ingredients_100x100/';

//TYPES
enum SortBy {
  AZ,
  ZA,
  Rating,
  PreparationTime,
  Servings,
  PantryProducts,
}

const kSortBy = {
  SortBy.AZ: 'A-Z',
  SortBy.ZA: 'Z-A',
  SortBy.Rating: 'Rating',
  SortBy.PreparationTime: 'Preparation Time',
  SortBy.Servings: 'Servings',
  SortBy.PantryProducts: 'Pantry Products',
};

enum MealType {
  MainCourse,
  SideDish,
  Dessert,
  Appetizer,
  Salad,
  Bread,
  Breakfast,
  Soup,
  Beverage,
  Sauce,
  Marinade,
  Fingerfood,
  Snack,
  Drink,
}

const kMealTypes = {
  MealType.Appetizer: 'appetizer',
  MealType.Beverage: 'beverage',
  MealType.Bread: 'bread',
  MealType.Breakfast: 'breakfast',
  MealType.Dessert: 'dessert',
  MealType.Drink: 'drink',
  MealType.Fingerfood: 'fingerfood',
  MealType.MainCourse: 'main course',
  MealType.Marinade: 'marinade',
  MealType.Salad: 'salad',
  MealType.Sauce: 'sauce',
  MealType.SideDish: 'side dish',
  MealType.Snack: 'snack',
  MealType.Soup: 'soup',
};

enum Cuisine {
  African,
  American,
  British,
  Cajun,
  Caribbean,
  Chinese,
  EasternEuropean,
  European,
  French,
  German,
  Greek,
  Indian,
  Irish,
  Italian,
  Japanese,
  Jewish,
  Korean,
  LatinAmerican,
  Mediterranean,
  Mexican,
  MiddleEastern,
  Nordic,
  Southern,
  Spanish,
  Thai,
  Vietnamese,
}
const kCuisines = {
  Cuisine.African: 'African',
  Cuisine.American: 'American',
  Cuisine.British: 'British',
  Cuisine.Cajun: 'Cajun',
  Cuisine.Caribbean: 'Caribbean',
  Cuisine.Chinese: 'Chinese',
  Cuisine.EasternEuropean: 'Eastern Europe',
  Cuisine.European: 'European',
  Cuisine.French: 'French',
  Cuisine.German: 'German',
  Cuisine.Greek: 'Greek',
  Cuisine.Indian: 'Indian',
  Cuisine.Irish: 'Irish',
  Cuisine.Italian: 'Italian',
  Cuisine.Japanese: 'Japanese',
  Cuisine.Jewish: 'Jewish',
  Cuisine.Korean: 'Korean',
  Cuisine.LatinAmerican: 'Latin American',
  Cuisine.Mediterranean: 'Mediterranean',
  Cuisine.Mexican: 'Mexican',
  Cuisine.MiddleEastern: 'Middle Eastern',
  Cuisine.Nordic: 'Nordic',
  Cuisine.Southern: 'Southern',
  Cuisine.Spanish: 'Spanish',
  Cuisine.Thai: 'Thai',
  Cuisine.Vietnamese: 'Vietnamese',
};

enum Diet {
  GlutenFree,
  Ketogenic,
  LactoVegetarian,
  OvoVegetarian,
  Paleo,
  Pescetarian,
  Primal,
  Vegan,
  Vegetarian,
  Whole30,
}
const kDiets = {
  Diet.GlutenFree: 'Gluten Free',
  Diet.Ketogenic: 'Ketogenic',
  Diet.LactoVegetarian: 'Lacto-Vegetarian',
  Diet.OvoVegetarian: 'Ovo-Vegetarian',
  Diet.Paleo: 'Paleo',
  Diet.Pescetarian: 'Pescetarian',
  Diet.Primal: 'Primal',
  Diet.Vegan: 'Vegan',
  Diet.Vegetarian: 'Vegetarian',
  Diet.Whole30: 'Whole30',
};
