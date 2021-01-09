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
const kUnits = ['', 'g', 'ml', 'cup', 'tbsp', 'tsp', 'oz'];

enum SortBy {
  NameAsc,
  NameDesc,
  PantryProducts,
  Rating,
  PreparationTimeAsc,
  PreparationTimeDesc,
  ServingsAsc,
  ServingsDesc,
}

const kSortBy = {
  SortBy.NameAsc: 'Name (Asc)',
  SortBy.NameDesc: 'Name (Desc)',
  SortBy.PantryProducts: 'Pantry Products (Desc)',
  SortBy.Rating: 'Rating (Desc)',
  SortBy.PreparationTimeAsc: 'Preparation Time (Asc)',
  SortBy.PreparationTimeDesc: 'Preparation Time (Desc)',
  SortBy.ServingsAsc: 'Servings (Asc)',
  SortBy.ServingsDesc: 'Servings (Desc)'
};

const kDefaultSortBy = SortBy.NameAsc;
const kDefaultDishTypeFilters = {
  DishType.Appetizer: false,
  DishType.Beverage: false,
  DishType.Bread: false,
  DishType.Breakfast: false,
  DishType.Dessert: false,
  DishType.Drink: false,
  DishType.Fingerfood: false,
  DishType.MainCourse: false,
  DishType.Marinade: false,
  DishType.Salad: false,
  DishType.Sauce: false,
  DishType.SideDish: false,
  DishType.Snack: false,
  DishType.Soup: false,
};
const kDefaultCuisineFilters = {
  Cuisine.African: false,
  Cuisine.American: false,
  Cuisine.British: false,
  Cuisine.Cajun: false,
  Cuisine.Caribbean: false,
  Cuisine.Chinese: false,
  Cuisine.EasternEuropean: false,
  Cuisine.European: false,
  Cuisine.French: false,
  Cuisine.German: false,
  Cuisine.Greek: false,
  Cuisine.Indian: false,
  Cuisine.Irish: false,
  Cuisine.Italian: false,
  Cuisine.Japanese: false,
  Cuisine.Jewish: false,
  Cuisine.Korean: false,
  Cuisine.LatinAmerican: false,
  Cuisine.Mediterranean: false,
  Cuisine.Mexican: false,
  Cuisine.MiddleEastern: false,
  Cuisine.Nordic: false,
  Cuisine.Southern: false,
  Cuisine.Spanish: false,
  Cuisine.Thai: false,
  Cuisine.Vietnamese: false,
};
const kDefaultDietFilters = {
  Diet.GlutenFree: false,
  Diet.DairyFree: false,
  Diet.Ketogenic: false,
  Diet.LactoVegetarian: false,
  Diet.OvoVegetarian: false,
  Diet.Paleo: false,
  Diet.Pescetarian: false,
  Diet.Primal: false,
  Diet.Vegan: false,
  Diet.Vegetarian: false,
  Diet.Whole30: false,
};

enum DishType {
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

const kDishTypes = {
  DishType.Appetizer: 'appetizer',
  DishType.Beverage: 'beverage',
  DishType.Bread: 'bread',
  DishType.Breakfast: 'breakfast',
  DishType.Dessert: 'dessert',
  DishType.Drink: 'drink',
  DishType.Fingerfood: 'fingerfood',
  DishType.MainCourse: 'main course',
  DishType.Marinade: 'marinade',
  DishType.Salad: 'salad',
  DishType.Sauce: 'sauce',
  DishType.SideDish: 'side dish',
  DishType.Snack: 'snack',
  DishType.Soup: 'soup',
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
  Cuisine.African: 'african',
  Cuisine.American: 'american',
  Cuisine.British: 'british',
  Cuisine.Cajun: 'cajun',
  Cuisine.Caribbean: 'caribbean',
  Cuisine.Chinese: 'chinese',
  Cuisine.EasternEuropean: 'eastern Europe',
  Cuisine.European: 'european',
  Cuisine.French: 'french',
  Cuisine.German: 'german',
  Cuisine.Greek: 'greek',
  Cuisine.Indian: 'indian',
  Cuisine.Irish: 'irish',
  Cuisine.Italian: 'italian',
  Cuisine.Japanese: 'japanese',
  Cuisine.Jewish: 'jewish',
  Cuisine.Korean: 'korean',
  Cuisine.LatinAmerican: 'latin American',
  Cuisine.Mediterranean: 'mediterranean',
  Cuisine.Mexican: 'mexican',
  Cuisine.MiddleEastern: 'middle Eastern',
  Cuisine.Nordic: 'nordic',
  Cuisine.Southern: 'southern',
  Cuisine.Spanish: 'spanish',
  Cuisine.Thai: 'thai',
  Cuisine.Vietnamese: 'vietnamese',
};

enum Diet {
  GlutenFree,
  DairyFree,
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
  Diet.GlutenFree: 'gluten free',
  Diet.DairyFree: 'dairy free',
  Diet.Ketogenic: 'ketogenic',
  Diet.LactoVegetarian: 'lacto-vegetarian',
  Diet.OvoVegetarian: 'ovo-vegetarian',
  Diet.Paleo: 'paleo',
  Diet.Pescetarian: 'pescetarian',
  Diet.Primal: 'primal',
  Diet.Vegan: 'vegan',
  Diet.Vegetarian: 'vegetarian',
  Diet.Whole30: 'whole30',
};
