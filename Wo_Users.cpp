#include "Wo_Users.hpp"

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




template <typename T>
 Users<T>:: Users() {

 }

 template <typename T>
 Users<T>:: ~ Users() {

  }
  /*
  template <typename T>
   Users<T>:: Users(T username) {

   }
*/

template <typename T>
vector<T> Users<T>:: getUsername(){


  vector<T> myusers ;
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
      myusers.push_back( string(res->getString(1)));
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
return myusers;


}













template <typename T>
void Users<T>::affiche(std::vector<T> &myvector){
  for (typename std::vector<T>::iterator it = myvector.begin() ; it != myvector.end(); ++it)
  std::cout << ' ' << *it;
  std::cout << '\n';

}
template <typename T>
vector<T> Users<T>:: getEmail(){


  vector<string> myusers ;
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
      cout << res->getString("email") << endl;
      cout << "\t... MySQL says it again: ";
      /* Access column data by numeric offset, 1 is the first column */
      cout << res->getString(1) << endl;
      myusers.push_back( res->getString(1));
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
return myusers;


}






template <typename T>
 vector<T> Users<T>:: getGender(){


  vector<string> myusers ;
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
      cout << res->getString("gender") << endl;
      cout << "\t... MySQL says it again: ";
      /* Access column data by numeric offset, 1 is the first column */
      cout << res->getString(1) << endl;
      myusers.push_back( res->getString(1));
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
return myusers;


}
