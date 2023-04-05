//This imports firebase functions so that we can use it
const functions = require('firebase-functions');

//This imports a postgres library for JavaScript
const { Client } = require('pg');

//This creates an object we can use to connect to our database

// This is a function without parameters, it's very similar to a parameterized function
// If you want to create a new function you should replace getEmployeesTest with the function name
// The rest should be the same for all our functions
// functions is the name we gave to the firebase functions package
// https is the protocol used
// onCall means that it can be invoked on the client side (i.e. from our dart code)
// async means that it will have parts that are waiting for other parts
// data is an an optional parameter that can be used for passing data
// context is an optional parameter that is used for giving the function other types of information
// data and context are auto assigned by system variables if not given so don't stress about them being here
// also we likely won't use context
exports.getEmployeesTest = functions.https.onCall(async (data, context) => {

     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });
// await makes the rest of the function wait until this line completes
// this connects to our database
    await client.connect()

// this creates a const that will store the result of our query
// it also queries the client with the given string argument
    const res = await client.query('SELECT * FROM employees')

//  this closes our connection to our database
    client.end()

//  this returns a list of dictionaries populated with the values of the request
//  e.g. if only Jonas existed it would return this [{employee_id: 2, employee_name: Jonas, employee_role: Server, passcode: 56, hourly_rate: $14.99}]
    return res.rows
});



// this is a function with a parameter
exports.getOneEmployeeByIdTest = functions.https.onCall(async (data, context) => {

     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });

//  this is makes the function have the parameter employee_id
    const {employee_id} = data;

    await client.connect()

//  you can simply add variables to the query
    const res = await client.query('SELECT * FROM employees WHERE employee_id =' + employee_id)

    client.end()

    return res.rows

});


// for getting the user's info after logging in
exports.getEmployeeByUID = functions.https.onCall(async (data, context) => {

    const {employee_uid} = data;

    await client.connect()

    const res = await client.query("SELECT * FROM employees WHERE employee_uid ='" + employee_uid+"'")

    client.end()

    return res.rows

});



// Gets the largest id from the menu_items table, so that it can be used when adding new menu items
exports.getLastMenuItemID = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const res = await client.query('SELECT menu_item_id FROM menu_items ORDER BY menu_item_id DESC LIMIT 1');

    client.end()

    return res.rows

});

// Gets the largest id from the ingredients_table table, so that it can be used when adding an item's ingredients
exports.getLastIngredientsTableID = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const res = await client.query('SELECT row_id FROM ingredients_table ORDER BY row_id DESC LIMIT 1');

    client.end()

    return res.rows

});

// Adds a menu item to the menu_items table
exports.addMenuItem = functions.https.onCall(async (data, context) => {

    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {values} = data

    const res = await client.query('INSERT INTO menu_items (menu_item_id, menu_item, item_price, amount_in_stock, type, status) VALUES(' + values + ')')

    client.end()

    return "Added menu item to database"
});

exports.editItemPrice = functions.https.onCall(async (data, context) => {

     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });

     await client.connect()

     const {menu_item_id} = data
     const {new_price} = data

     const res = await client.query('UPDATE menu_items SET item_price=' + new_price + ' WHERE menu_item_id=' + menu_item_id)

     client.end()

     return "updated menu item price in the database"
 });

exports.deleteMenuItem = functions.https.onCall(async (data, context) => {

     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });

     await client.connect()

     const {menu_item} = data

     const res = await client.query('UPDATE menu_items SET status=\'unavailable\' WHERE menu_item LIKE \'%' + menu_item + '%\'')

     client.end()

     return "deleted menu item from database"
 });

// Adds an ingredient row to the ingredients_table table
exports.insertIntoIngredientsTable = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {values} = data

    const res = await client.query('INSERT INTO ingredients_table (row_id, menu_item_name, ingredient_name, ingredient_amount) VALUES(' + values + ')')

    client.end()

    return "Added ingredient to ingredients_table"
});

exports.getIngredientRowId = functions.https.onCall(async (data, context) => {
     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });

     await client.connect()

     const {menu_item_name} = data
     const {ingredient_name} = data

     const res = await client.query('SELECT row_id FROM ingredients_table WHERE menu_item_name=\'' + menu_item_name + '\' AND ingredient_name=\'' + ingredient_name + '\'')

     client.end()

     return res.rows
 })

// Takes a row_id and a new_amount, updates the ingredients_table at row_id and changes the quantity to new_amount
exports.updateIngredientsTableRow = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {row_id} = data
    const {new_amount} = data

    const res = await client.query('UPDATE ingredients_table SET ingredient_amount=' + new_amount + ' WHERE row_id=' + row_id)

    client.end()

    return "Successfully updated ingredients_table row"
});

// Deletes an individual row from the ingredients_table
exports.deleteIngredientsTableRow = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {row_id} = data

    const res = await client.query('DELETE FROM ingredients_table WHERE row_id=' + row_id)

    client.end()

    return "Successfully deleted ingredients_table row"
});

exports.getMenuItemName = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {menu_item_id} = data

    const res = await client.query('SELECT menu_item FROM menu_items WHERE menu_item_id=' + menu_item_id)

    client.end()

    return res.rows
});

exports.getMenuItemType = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {menu_item_id} = data

    const res = await client.query('SELECT type FROM menu_items WHERE menu_item_id=' + menu_item_id)

    client.end()

    return res.rows
});


exports.getItemPrice = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {menu_item_name} = data

    const res = await client.query('SELECT item_price FROM menu_items WHERE menu_item=\'' + menu_item_name + '\'')

    client.end()

    return res.rows
});

exports.getItemID = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {menu_item_name} = data

    const res = await client.query('SELECT menu_item_id FROM menu_items WHERE menu_item=\'' + menu_item_name + '\'')

    client.end()

    return res.rows
});


exports.getMenuItemIngredients = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {menu_item_name} = data

    const res = await client.query('SELECT ingredient_name, ingredient_amount FROM ingredients_table WHERE menu_item_name=\'' + menu_item_name + '\'')

    client.end()

    return res.rows
});

exports.getAmountInvStock = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {ingredient} = data

    const res = await client.query('SELECT inv_order_id, amount_inv_stock FROM inventory WHERE ingredient=\'' + ingredient + '\' ORDER BY expiration_date DESC, date_ordered');

    client.end()

    return res.rows
});

exports.updateInventoryRow = functions.https.onCall(async (data, context) => {
    const client = new Client({
          host: 'csce-315-db.engr.tamu.edu',
          user: 'csce315331_team_13_master',
          password: 'Lucky_13',
          database: 'csce315331_team_13',
          port: 5432,
    });

    await client.connect()

    const {inv_order_id} = data
    const {new_amount} = data

    const res = await client.query('UPDATE inventory SET amount_inv_stock=' + new_amount + 'WHERE inv_order_id=' + inv_order_id)

    client.end()

    return "Successfully updated inventory row"

});

exports.insertIntoOrderHistory = functions.https.onCall(async (data, context) => {
     const client = new Client({
           host: 'csce-315-db.engr.tamu.edu',
           user: 'csce315331_team_13_master',
           password: 'Lucky_13',
           database: 'csce315331_team_13',
           port: 5432,
     });

     await client.connect()

     const {values} = data

     const res = await client.query('INSERT INTO order_history (transaction_id, order_taker_id, item_ids_in_order, total_price, customer_name, date_of_order, status) VALUES(' + values + ')')

     client.end()

     return "Successfully added order to the order history"
});

exports.getSmoothieNames = functions.https.onCall(async (data, context) => {
    const client = new Client({
        host: 'csce-315-db.engr.tamu.edu',
        user: 'csce315331_team_13_master',
        password: 'Lucky_13',
        database: 'csce315331_team_13',
        port: 5432,
    });

    await client.connect()

    const res = await client.query("SELECT menu_item FROM menu_items WHERE type='smoothie'");

    client.end()

    return res.rows
});

exports.getSnackNames = functions.https.onCall(async (data, context) => {
    const client = new Client({
        host: 'csce-315-db.engr.tamu.edu',
        user: 'csce315331_team_13_master',
        password: 'Lucky_13',
        database: 'csce315331_team_13',
        port: 5432,
    });

    await client.connect()

    const res = await client.query("SELECT menu_item FROM menu_items WHERE type='snack'");

    client.end()

    return res.rows
});

exports.getAddonNames = functions.https.onCall(async (data, context) => {
    const client = new Client({
        host: 'csce-315-db.engr.tamu.edu',
        user: 'csce315331_team_13_master',
        password: 'Lucky_13',
        database: 'csce315331_team_13',
        port: 5432,
    });

    await client.connect()

    const res = await client.query("SELECT menu_item FROM menu_items WHERE type='addon'");

    client.end()

    return res.rows
});






