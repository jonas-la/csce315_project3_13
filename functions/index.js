//This imports firebase functions so that we can use it
const functions = require('firebase-functions');

//This imports a postgres library for JavaScript
const { Client } = require('pg');

//This creates an object we can use to connect to our database
const client = new Client({
      host: 'csce-315-db.engr.tamu.edu',
      user: 'csce315331_team_13_master',
      password: 'Lucky_13',
      database: 'csce315331_team_13',
      port: 5432,
    });

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

//  this is makes the function have the parameter employee_id
    const {employee_id} = data;

    await client.connect()

//  you can simply add variables to the query
    const res = await client.query('SELECT * FROM employees WHERE employee_id =' + employee_id)

    client.end()

    return res.rows

});













//}

//myAsyncFunction();




//// Firebase Cloud Function
//exports.getEmployees = functions.https.onCall(async (data, context) => {
//  try {
//    // Connect to PostgreSQL database
//    const client = new Client({
//      host: 'csce-315-db.engr.tamu.edu',
//      user: 'csce315331_team_13_master',
//      password: 'Lucky_13',
//      database: 'csce315331_team_13',
//      port: 5432,
//    });
//    await client.connect();
//
//    // Execute query
//    const result = await client.query('SELECT * FROM employees;');
//
//    // Close database connection
//    await client.end();
//
//    return result.rows;
//  } catch (error) {
//    console.error(error);
//    throw new functions.https.HttpsError('internal', 'Error retrieving employees');
//  }
//});
//
//
//
//
//// Firebase Cloud Function
//exports.testConnection = functions.https.onCall(async (data, context) => {
//  try {
//    // Connect to PostgreSQL database
//    const client = new Client({
//      host: 'csce-315-db.engr.tamu.edu',
//      user: 'csce315331_team_13_master',
//      password: 'Lucky_13',
//      database: 'csce315331_team_13',
//    });
//    await client.connect();
//
//    // Execute query
////    const result = await client.query('SELECT * FROM employees;');
////
////    // Close database connection
////    await client.end();
//
////    return result.rows;
//  } catch (error) {
//    console.error(error);
//    throw new functions.https.HttpsError('internal', 'Error retrieving connecting to database');
//  }
//});
//
////getEmployees();