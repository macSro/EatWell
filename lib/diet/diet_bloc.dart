// import 'package:bloc/bloc.dart';
// import 'package:eat_well_v1/repositories/diet_repository.dart';

// class DietBloc extends Bloc<DietEvent, DietState> {
//   DietRepository _dietRepository;

//   DietBloc({@required DietRepository dietRepository})
//       : super(DietInitial()) {
//     _dietRepository = dietRepository;
//   }

//   @override
//   Stream<DietState> mapEventToState(DietEvent event) async* {
//     if (event is FetchBannedProducts)
//       yield* _fetchPantry();
//     else if (event is AddProductToBanned)
//       yield* _addProductToPantry(
//         event.currentProducts,
//         event.productId,
//         event.amount,
//         event.unit,
//         event.expDate,
//       );
//   }

//   Stream<PantryState> _fetchPantry() async* {
//     yield PantryLoading();

//     final List<ExtendedIngredient> products =
//         await _pantryRepository.fetchPantry();
//     yield PantryFetched(products: products);
//   }

//   Stream<PantryState> _addProductToPantry(
//     List<ExtendedIngredient> currentProducts,
//     String productId,
//     double amount,
//     String unit,
//     DateTime expDate,
//   ) async* {
//     yield PantryLoading();

//     final ExtendedIngredient newProduct = ExtendedIngredient(
//       product: await _pantryRepository
//           .addProductToPantry(productId, amount, unit, expDate)
//           .then(
//             (_) => _pantryRepository.getProduct(productId),
//           ),
//       amount: amount,
//       unit: unit,
//       expDate: expDate,
//     );

//     List<ExtendedIngredient> newProducts = currentProducts;

//     newProducts.add(newProduct);

//     yield PantryFetched(products: newProducts);
//   }
// }
