#include <stdio.h>
#include<stdlib.h>
#include<iostream>
#include<cstring>
#include <sstream>
#include <stdexcept>
#include<vector>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include "mysql_connection.h"


#include "statement1.h"
using namespace std;



class Mywork {};

int main(int argc,const char *argv[]){
  cout << endl;
  cout << "Running 'SELECT 'Hello World!'";
     //AS _message'..." << endl;
int count = 0;
  try {
    sql::Driver *driver;
    sql::Connection *con;
    sql::Statement *stmt;
    sql::ResultSet *res;

    /* Create a connection */
    driver = get_driver_instance();
    con = driver->connect("tcp://127.0.0.1:3306", "root", "");
    /* Connect to the MySQL test database */
    con->setSchema("famousme");

    stmt = con->createStatement();
    res = stmt->executeQuery("SELECT  * from Wo_Users ");
    while (res->next()) {
      cout << "\t... MySQL replies: ";
      /* Access column data by alias or column name */
      cout << res->getString("username") << endl;
      cout << "\t... MySQL says it again: ";
      /* Access column data by numeric offset, 1 is the first column */
      cout << res->getString(1) << endl;
      count ++;
    }
    delete res;
    delete stmt;
    delete con;

  } catch (sql::SQLException &e) {
    cout << "# ERR: SQLException in " << __FILE__;
    cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
    cout << "# ERR: " << e.what();
    cout << " (MySQL error code: " << e.getErrorCode();
    cout << ", SQLState: " << e.getSQLState() << " )" << endl;
  }

  cout << endl;

  cout <<count<<endl;

  return EXIT_SUCCESS;
  //return 0;
}
