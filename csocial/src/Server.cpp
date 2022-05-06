#include <iostream>
#include <string>
#include <memory>
#include <utility>
#include "crow_all.h"

#include <domain/Student.h>
#include <infrastructure/IdGenerator.h>
#include <infrastructure/IncrementalConcurrentIdGenerator.h>
#include <infrastructure/StudentController.h>

using namespace std;
using namespace crow;

void LinkStudentResourceToStudentControllerAndServer(SimpleApp *server, StudentController *students) {
  SimpleApp &app = *server;
  //crow::response& res1=new crow::response();
  CROW_GET(app, "/api/student")
      ([students]() {

        crow::response r(students->AllStudents());
      //  r.add_header("Content-Type", pick_content_type(path));
      r.add_header("Access-Control-Allow-Origin", "*");
      r.add_header("Access-Control-Allow-Headers", "Content-Type");
        return r;
      });

  CROW_POST(app, "/api/student")
      ([students](const request &req) {

          crow::response r("create student ");
          r.add_header("Access-Control-Allow-Origin", "*");
          r.add_header("Access-Control-Allow-Headers", "Content-Type");



        return students->CreateStudent(req);
      });

  CROW_POST(app, "/api/student/<uint>")
      ([students](const request &req, unsigned int id) {

        return students->UpdateStudent(req, id);
      });

  CROW_DELETE(app, "/api/student/<uint>")
      ([students](unsigned int id) {

        crow::response r(students->DeleteStudent(id));
        r.add_header("Access-Control-Allow-Origin", "*");
        r.add_header("Access-Control-Allow-Headers", "Content-Type");

        return  r;
      });

  CROW_GET(app, "/api/student/<uint>")
      ([students](unsigned int id) {

        crow::response r(students->SingleStudent(id));
        r.add_header("Access-Control-Allow-Origin", "*");
        r.add_header("Access-Control-Allow-Headers", "Content-Type");

        return r;students->SingleStudent(id)
      });
}





/*

struct ExampleMiddleware
{
    std::string message;

    ExampleMiddleware()
    {
        message = "foo";
    }

    void setMessage(std::string newMsg)
    {
        message = newMsg;
    }

    struct context
    {
    };

    void before_handle(crow::request& req, crow::response& res, context& ctx)
    {
      res.add_header("Access-Control-Allow-Origin", "*");
      res.add_header("Access-Control-Allow-Headers", "Content-Type");
    }

    void after_handle(crow::request& req, crow::response& res, context& ctx)
    {
      res.add_header("Access-Control-Allow-Origin", "*");
      res.add_header("Access-Control-Allow-Headers", "Content-Type");
    }
};



*/
void RunServer() {
  //FIXME concurrent access!
  std::vector<Student> students{{102314, "Alojzy", "Motyka", "informatyka", 22, "00000000000"},
                                {564321, "Krzysztof", "Mallory", "astronomia", 19, "00000000000"}};

  unique_ptr<IdGenerator> generator = make_unique<IncrementalConcurrentIdGenerator>(100);

  SimpleApp app;

  //crow::App<ExampleMiddleware> app;

  //app.get_middleware<ExampleMiddleware>().setMessage("hello");

  CROW_GET(app, "/api/hello/<int>")
      ([](int count) {

        if (count > 100)
          return crow::response(400);
        ostringstream os;
        os << count << " bottles of beer!";
      //  crow::response(os.str());
                crow::response r(os.str());
                r.add_header("Access-Control-Allow-Origin", "*");
                r.add_header("Access-Control-Allow-Headers", "Content-Type");

        return r ;
      });

  CROW_GET(app, "/")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/index.html");
      });

  CROW_GET(app, "/object_view.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("object_view.html");
      });

  CROW_GET(app, "/app.js")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/app.js");
      });

  CROW_GET(app, "/object_view_directive.js")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/object_view_directive.js");
      });

  CROW_GET(app, "/object_view_widget.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/object_view_widget.html");
      });

  CROW_GET(app, "/timetable_widget.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/timetable_widget.html");
      });

  CROW_GET(app, "/create_student.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/create_student.html");
      });

  CROW_GET(app, "/create_object.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/create_object.html");
      });

  CROW_GET(app, "/menu.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/menu.html");
      });

  CROW_GET(app, "/timetable.html")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/timetable.html");
      });

  CROW_GET(app, "/assets/timetable.js")
      ([]() {
        mustache::context ctx;
        return mustache::load_text(".//templates/assets/timetable.js");
      });

  CROW_GET(app, "/assets/timetablejs.css")
      ([]() {
        mustache::context ctx;
        return mustache::load_text("./templates/assets/timetablejs.css");
      });


    //   CROW_GET(app, "/api/<std::string>")
    // ([](crow::response& res,std::string path){
    //     //CROW_LOG_INFO << "logs with last " << after;
    //   /*  if (after < (int)msgs.size())
    //     {
    //         crow::json::wvalue x;
    //         for(int i = after; i < (int)msgs.size(); i ++)
    //             x["msgs"][i-after] = msgs[i];
    //         x["last"] = msgs.size();
    //
    //         res.write(crow::json::dump(x));
    //         res.end();
    //     }
    //     else
    //     {
    //         vector<pair<crow::response*, decltype(chrono::steady_clock::now())>> filtered;
    //         for(auto p : ress)
    //         {
    //             if (p.first->is_alive() && chrono::steady_clock::now() - p.second < chrono::seconds(30))
    //                 filtered.push_back(p);
    //             else
    //                 p.first->end();
    //         }
    //         ress.swap(filtered);
    //         ress.push_back({&res, chrono::steady_clock::now()});
    //         CROW_LOG_DEBUG << &res << " stored " << ress.size();
    //     }*/
    //
    //     res.add_header("Access-Control-Allow-Origin", "*");
    //     res.add_header("Access-Control-Allow-Headers", "Content-Type");
    //    return path;
    // });

  unique_ptr<IdGenerator> ids = make_unique<IncrementalConcurrentIdGenerator>(1000);
  unique_ptr<StudentRepository> repository = make_unique<StudentRepository>(std::move(ids));
  unique_ptr<StudentController> controller = make_unique<StudentController>(std::move(repository));

  LinkStudentResourceToStudentControllerAndServer(&app, controller.get());

  logger::setLogLevel(LogLevel::Debug);
  //THIS LINE RUNS INFINITE LOOP THEREFORE ALL unique_ptr ARE ALIVE
  /*
  res.add_header("Access-Control-Allow-Origin", "*");
  res.add_header("Access-Control-Allow-Headers", "Content-Type");
  */
  app.port(9876).multithreaded().run();

}
