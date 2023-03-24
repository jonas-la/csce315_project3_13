//const functions = require("firebase-functions");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

//exports.listFruit = functions.https.onCall((data, context) => {
//  return ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
//});

const functions = require('firebase-functions');
const { Client } = require('pg');



exports.getTestResult = functions.https.onCall(async (data, context) => {
//async function myAsyncFunction() {
    const client = new Client({
      host: 'csce-315-db.engr.tamu.edu',
      user: 'csce315331_team_13_master',
      password: 'Lucky_13',
      database: 'csce315331_team_13',
      port: 5432,
    });

    client.connect();
    client.query('SELECT * FROM employees', (err, res) => {
      if (err) throw err;
      console.log(res.rows);
      client.end();
    });

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