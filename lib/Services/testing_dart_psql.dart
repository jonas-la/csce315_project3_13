import 'dart:async';
import 'package:postgres/postgres.dart';

class testing_dart_psql{

  Future<void> connectToPostgreSQL() async {
    // Create a PostgreSQL connection object
    final conn = PostgreSQLConnection(
      'csce-315-db.engr.tamu.edu', // Host
      5432,                        // Port
      'csce315331_team_13',        // Database name
      username: 'csce315331_team_13_master',
      password: 'Lucky_13',
    );

    // Open the connection to the database
    await conn.open();

    // Query the database and retrieve all rows in the employees table
    final results = await conn.query('SELECT * FROM employees');

    // Print the results
    print(results);

    // Close the connection
    await conn.close();
  }



}