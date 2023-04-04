import '../Models/models_library.dart';
import 'package:cloud_functions/cloud_functions.dart';

class ingredients_table_helper
{
  // Simply takes in an ingredient_obj which mirrors a row from the ingredients_table table
  //    and adds it to the database
  Future<void> add_ingredient_row(ingredient_obj ingr_obj) async
  {
    HttpsCallable addIngredient = FirebaseFunctions.instance.httpsCallable('insertIntoIngredientsTable');
    await addIngredient.call({'values': ingr_obj.get_values()});
  }

  Future<void> edit_ingredient_row(int row_id, int new_amount) async
  {
    HttpsCallable editIngredient = FirebaseFunctions.instance.httpsCallable('updateIngredientsTableRow');
    await editIngredient.call({
      'row_id': row_id,
      'new_amount': new_amount
    });
  }

  // Deletes a single row from the ingredients_table table specified by row_id
  Future<void> delete_ingredient_row(int row_id) async
  {
    HttpsCallable deleteIngredient = FirebaseFunctions.instance.httpsCallable('deleteIngredientsTableRow');
    await deleteIngredient.call({'row_id': row_id});
  }
}