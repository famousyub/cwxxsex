
#ifndef Wo_Users_H

#define Wo_Users_H



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

#include <algorithm>
#include <iostream>
#include <memory>

template<typename T>
class Users {

  private :
  T username;
  T email ;
  T gender ;

  public :
   Users();
  virtual ~Users();
  Users(T h);
  std::vector<T>  getUsername () ;
  std::vector<T>  getEmail();
  std::vector<T> getGender();

  void affiche( std::vector<T> &myvector);
  /*struct WoUsers {
    T data;
  };
  typedef WoUsers Wousers;

*/




};














#endif
