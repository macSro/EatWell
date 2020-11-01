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
const kIngredientImageUrlBasePath =
    'https://spoonacular.com/cdn/ingredients_100x100/';

//TYPES
enum MealTypes {
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
  MealTypes.Appetizer: 'Appetizer',
  MealTypes.Beverage: 'Beverage',
  MealTypes.Bread: 'Bread',
  MealTypes.Breakfast: 'Breakfast',
  MealTypes.Dessert: 'Dessert',
  MealTypes.Drink: 'Drink',
  MealTypes.Fingerfood: 'Fingerfood',
  MealTypes.MainCourse: 'Main Course',
  MealTypes.Marinade: 'Marinade',
  MealTypes.Salad: 'Salad',
  MealTypes.Sauce: 'Sauce',
  MealTypes.SideDish: 'Side Dish',
  MealTypes.Snack: 'Snack',
  MealTypes.Soup: 'Soup',
};

enum Cuisines {
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
  Cuisines.African: 'African',
  Cuisines.American: 'American',
  Cuisines.British: 'British',
  Cuisines.Cajun: 'Cajun',
  Cuisines.Caribbean: 'Caribbean',
  Cuisines.Chinese: 'Chinese',
  Cuisines.EasternEuropean: 'Eastern Europe',
  Cuisines.European: 'European',
  Cuisines.French: 'French',
  Cuisines.German: 'German',
  Cuisines.Greek: 'Greek',
  Cuisines.Indian: 'Indian',
  Cuisines.Irish: 'Irish',
  Cuisines.Italian: 'Italian',
  Cuisines.Japanese: 'Japanese',
  Cuisines.Jewish: 'Jewish',
  Cuisines.Korean: 'Korean',
  Cuisines.LatinAmerican: 'Latin American',
  Cuisines.Mediterranean: 'Mediterranean',
  Cuisines.Mexican: 'Mexican',
  Cuisines.MiddleEastern: 'Middle Eastern',
  Cuisines.Nordic: 'Nordic',
  Cuisines.Southern: 'Southern',
  Cuisines.Spanish: 'Spanish',
  Cuisines.Thai: 'Thai',
  Cuisines.Vietnamese: 'Vietnamese',
};

enum Diets {
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
  Diets.GlutenFree: 'Gluten Free',
  Diets.Ketogenic: 'Ketogenic',
  Diets.LactoVegetarian: 'Lacto-Vegetarian',
  Diets.OvoVegetarian: 'Ovo-Vegetarian',
  Diets.Paleo: 'Paleo',
  Diets.Pescetarian: 'Pescetarian',
  Diets.Primal: 'Primal',
  Diets.Vegan: 'Vegan',
  Diets.Vegetarian: 'Vegetarian',
  Diets.Whole30: 'Whole30',
};
