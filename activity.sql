CREATE TABLE activity (
 activity_id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
 activity_type_id     INT UNSIGNED,
 activity_property_id  INT UNSIGNED,
 added_by             VARCHAR(50) DEFAULT NULL,
 updated_by           VARCHAR(50) DEFAULT NULL,
 activity_code        VARCHAR(50),
 activity_description VARCHAR(100),
 start_date           TIMESTAMP NULL,
 end_date             TIMESTAMP NULL,
 start_time           VARCHAR(10),
 end_time             VARCHAR(10),
 added_date           TIMESTAMP NULL,
 updated_date         TIMESTAMP NULL,
 is_available         TINYINT(1),
 PRIMARY KEY (activity_id),
 CONSTRAINT wo_users_activity FOREIGN KEY (added_by) REFERENCES Wo_Users (username),
 CONSTRAINT wo_users_update_activity FOREIGN KEY (updated_by) REFERENCES Wo_Users (username)
)
 ENGINE = InnoDB DEFAULT CHARSET=latin1;


 CREATE TABLE IF NOT EXISTS `scores` (
   `ID` int(11) NOT NULL AUTO_INCREMENT,
   UserId int(11) NOT NULL,
   `NICKNAME` varchar(50) NOT NULL,
   `HIGHSCORE` int(11) NOT NULL,
   PRIMARY KEY (`ID`),
   FOREIGN KEY (UserId) REFERENCES USER(Id)
 );


 CREATE TABLE Wo_book (
  id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  author_id SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT `fk_book_author`
    FOREIGN KEY (author_id) REFERENCES `Wo_Users` (user_id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
) ENGINE = InnoDB;




 CREATE TABLE IF NOT EXISTS `Threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  UserId int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `body` mediumtext,
  PRIMARY KEY (`id`),
  FOREIGN KEY (UserId) REFERENCES Wo_Users(Id)
);
CREATE TABLE IF NOT EXISTS `Replies` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  UserId int(11) NOT NULL,
  ThreadId int(11) NOT NULL,
 `body` mediumtext,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (UserId) REFERENCES Wo_Users(user_id),
  FOREIGN KEY (ThreadId) REFERENCES Threads(ID)
);


CREATE TABLE IF NOT EXISTS `Threads` ( `ID` int(11) NOT NULL AUTO_INCREMENT, UserId int(11) NOT NULL, `title` varchar(50) NOT NULL, `body` mediumtext, PRIMARY KEY (`ID`), FOREIGN KEY (UserId) REFERENCES Wo_Users(user_id) );
CREATE TABLE IF NOT EXISTS `scores` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  UserId int(11) NOT NULL,
  `NICKNAME` varchar(50) NOT NULL,
  `HIGHSCORE` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (UserId) REFERENCES USER(Id)
);
