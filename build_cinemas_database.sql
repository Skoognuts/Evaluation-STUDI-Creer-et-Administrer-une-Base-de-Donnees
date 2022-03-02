-- DATABASE CREATION --
CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- TABLES CREATION --
CREATE TABLE roles (
  role_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE users (
  user_id CHAR(36) NOT NULL PRIMARY KEY,
  firstName VARCHAR(50),
  lastName VARCHAR(50),
  email VARCHAR(254),
  password VARCHAR(60),
  birth_year INT(4),
  is_student TINYINT(1),
  role CHAR(36) NOT NULL,
  CONSTRAINT has_role
    FOREIGN KEY (role)
    REFERENCES roles(role_id)
) ENGINE=InnoDB;

CREATE TABLE movies (
  movie_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  genre VARCHAR(50),
  director VARCHAR(50),
  duration INT(3)
) ENGINE=InnoDB;

CREATE TABLE theaters (
  theater_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  manager CHAR(36) NOT NULL,
  CONSTRAINT is_managed_by
    FOREIGN KEY (manager)
    REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE screeningRooms (
  room_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50),
  seats INT(5) NOT NULL,
  theater CHAR(36) NOT NULL,
  CONSTRAINT is_in_theater
    FOREIGN KEY (theater)
    REFERENCES theaters(theater_id)
) ENGINE=InnoDB;

CREATE TABLE screenings (
  screening_id CHAR(36) NOT NULL PRIMARY KEY,
  date DATE NOT NULL,
  time TIME NOT NULL,
  seats_left INT(5) NOT NULL,
  booked_seats INT(5) NOT NULL,
  movie CHAR(36) NOT NULL,
  screening_room CHAR(36) NOT NULL,
  programmed_by CHAR(36) NOT NULL,
  CONSTRAINT shows_movie
    FOREIGN KEY (movie)
    REFERENCES movies(movie_id),
  CONSTRAINT shows_where
    FOREIGN KEY (screening_room)
    REFERENCES screeningRooms(room_id),
  CONSTRAINT is_programmed_by
    FOREIGN KEY (programmed_by)
    REFERENCES theaters(manager)
) ENGINE=InnoDB;

CREATE TABLE paymentModes (
  mode_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE prices (
  price_id CHAR(36) NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(3, 2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE bookings (
  booking_id CHAR(36) NOT NULL PRIMARY KEY,
  client_id CHAR(36) NOT NULL,
  vendor_id CHAR(36) NOT NULL,
  screening CHAR(36) NOT NULL,
  payment_mode CHAR(36) NOT NULL,
  price CHAR(36) NOT NULL,
  CONSTRAINT is_client
    FOREIGN KEY (client_id)
    REFERENCES users(user_id),
  CONSTRAINT is_vendor
    FOREIGN KEY (vendor_id)
    REFERENCES users(user_id),
  CONSTRAINT screening_to_see
    FOREIGN KEY (screening)
    REFERENCES screenings(screening_id),
  CONSTRAINT which_payment_mode
    FOREIGN KEY (payment_mode)
    REFERENCES paymentModes(mode_id),
  CONSTRAINT which_price
    FOREIGN KEY (price)
    REFERENCES prices(price_id)
) ENGINE=InnoDB;

-- PRIVILEGES MANAGEMENT --
GRANT ALL PRIVILEGES ON cinemas.* TO 'admin'@'%';
GRANT SELECT ON cinemas.* TO 'lambda'@'%';

FLUSH PRIVILEGES;

-- TABLES FILLING FUNCTIONS --
-- Table "roles" :
INSERT INTO roles (role_id, name) VALUES ('ea5ed518-995f-11ec-b909-0242ac120002', 'ADMINISTRATOR');
INSERT INTO roles (role_id, name) VALUES ('4435ace2-9960-11ec-b909-0242ac120002', 'MANAGER');
INSERT INTO roles (role_id, name) VALUES ('5ba042ac-9960-11ec-b909-0242ac120002', 'SELLER');
INSERT INTO roles (role_id, name) VALUES ('74f61cae-9960-11ec-b909-0242ac120002', 'CUSTOMER');

-- Table "users" :
-- 1 Administrator :
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('51cc533a-ce29-4fe0-a5f0-65b38b8978c8', 'Shaun', 'Gudgion', 'sgudgion0@miibeian.gov.cn', '$2y$10$3xzSoWWvYKavorfWMruEJOFoBnrMz0ntczgRzZ56pquRkZ66r8wt6', 1979, 0, 'ea5ed518-995f-11ec-b909-0242ac120002');
-- 6 Managers (1 for each Theater) :
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('883070df-3d7b-4f8f-b300-dd1a3abbe858', 'Halley', 'Forsyde', 'hforsyde1@wordpress.com', '$2y$10$GJ2Q7QNBvEru.0pZLsgpt.fOG/mQItku8f8qSgGTFBkDjGlC8oCxa', 1998, 0, '4435ace2-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd', 'Ardyth', 'Degoe', 'adegoe2@cdbaby.com', '$2y$10$WnDHSpkFOTdl6uoE10enXOCCCAyVAVItH88T5.FnO/HQCXueC6Xga', 1984, 0, '4435ace2-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('bc602a68-ad45-48ad-b03b-fddea0668ba0', 'Nerta', 'Hynde', 'nhynde3@msn.com', '$2y$10$uCHew9z9vYKjduMWvmBz6uxtHEqyKAScRZuqC/6R2XPVn81lX8Sqm', 1987, 0, '4435ace2-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('da9b9885-f6a3-4dac-93aa-5d924c120ac4', 'Harley', 'Prestige', 'hprestige0@istockphoto.com', '$2y$10$lF3NOaPA6zrwpEHe9EN1aeXJsrksbKPFqpcVc3w4.SZSBaVVuVI2q', 2001, 0, '4435ace2-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('bb7ea9c0-ddce-4f07-99b2-2c744e187b0e', 'Carmelle', 'Genese', 'cgenese1@msu.edu', '$2y$10$zfoZJkWcKHuZJmw2NYyAjee3SQME5kmYUTHhT498vucsvb7URPs.y', 1995, 0, '4435ace2-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('5a3ca84d-f8a3-48ed-aa17-b12b55a6732c', 'Alvera', 'Espasa', 'aespasa2@amazon.com', '$2y$10$mOiTsHDJgpehW8T5CEyKLe6KPQjdBdxF2zYuojBUtCNaw/4h2pkJ2', 2010, 0, '4435ace2-9960-11ec-b909-0242ac120002');
-- 6 Sellers (1 for each Theater) :
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('571b5724-874e-47fa-8195-14b545304fca', 'Homere', 'Meddows', 'hmeddows4@gravatar.com', '$2y$10$e/z.v2wuUgg4xONRzZOLJ.75st7cSMTNg00fMQfrP7nGGEoQMihLO', 1999, 0, '5ba042ac-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('d4281ac1-a836-4a2d-bb99-5a7a2ca9da66', 'Christoffer', 'Klainer', 'cklainer5@chronoengine.com', '$2y$10$VTeYQXu2zcxlhAc7es4M1OQ1Rp0NRrosUqAmSPDdKBInLtDN9.wUe', 2004, 1, '5ba042ac-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', 'Xerxes', 'Rosensaft', 'xrosensaft6@yellowpages.com', '$2y$10$rarIHruHLGowmI70gWeYu.8TQLoKSGVDHtXpVq8qKPT9uRDbjwuIa', 2006, 1, '5ba042ac-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'Petronilla', 'Dahmke', 'pdahmke7@harvard.edu', '$2y$10$xcMHSZG/mP6zfBX5Z3jTzOZ6wo788y/1yqayG4gKxvErCpaGIoENm', 2001, 0, '5ba042ac-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('1f3b5b38-f003-4b47-a026-af34347d1a4a', 'Geoffrey', 'Kubica', 'gkubica8@reverbnation.com', '$2y$10$cmJLBZs2QKKilYQPq7LyA.WC6IK7fsP5lOqe7guEcIMxxxSx/sMIe', 1984, 0, '5ba042ac-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('e3707487-7537-4ca8-8cf4-544d4b88c641', 'Sheri', 'Dudek', 'sdudek9@free.fr', '$2y$10$Uod22fThfjHezsN0MWuvP.hiw/N6MSouGkGNycvyHYINlE5fi4Poq', 1978, 0, '5ba042ac-9960-11ec-b909-0242ac120002');
-- 10 Customers :
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', 'George', 'Precious', 'gpreciousa@theguardian.com', '$2y$10$E.fykwpfpQnU./L4cfarEO0SAOwkNS07LiXrepTk3pkM3eRP6pPoO', 2005, 0, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('7719d8f1-48ad-490f-8b6b-1d6917fd781e', 'Lennie', 'Thackham', 'lthackhamb@google.cn', '$2y$10$NzgYL8r9ZPeE1qNhnRKISev8jpxkzX6DAwpCdxO8W9yqLXzx9191u', 1995, 0, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', 'Witty', 'Tomasi', 'wtomasic@facebook.com', '$2y$10$8cEFJbNfGkFSwO2QCkxNOuaV9N9a1r8CrYdHgvkwN9dF01dSoafZy', 2001, 1, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('684836ed-cb0a-44ae-a46c-dfe32a0bc52c', 'Dosi', 'Kimberley', 'dkimberleyd@github.com', '$2y$10$CRpaCVEreWUx7KX9q3mQ1uwQasMCFw0Z5UOj7jVlTcaN7Am0SQdIm', 2006, 1, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('a66594d7-f20a-4d06-8d58-11b416ccbb8e', 'Cobb', 'Gossage', 'cgossagee@opera.com', '$2y$10$ipOBnnsqOVwcOOx0nM62teOqUQWU/ZQ.D7gdel2D.ySj.IbyhEMyG', 2012, 0, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('3aab3378-0ffe-4742-bc07-583d86c534f6', 'Katherine', 'Semon', 'ksemonf@smh.com.au', '$2y$10$YBZW2.Oh91TTrGY9fmeVmOU3Rrf3GqAuFfXCsNDwplfZw6TaRp0wS', 2003, 1, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('773946b3-b67e-494c-ad29-d46c7de5c2e1', 'Aileen', 'Brocket', 'abrocketg@squidoo.com', '$2y$10$zizxeOrRCE0mIrkg0e.pR.//h883sVVSg/CDchmcFZEGWRm6MYWky', 2012, 0, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('62cc43d4-17e5-493d-8a35-cb248a0d4d51', 'Pietra', 'Tomlins', 'ptomlinsh@marriott.com', '$2y$10$ITAh876GZVTU7/BmMduhYOi/bxYCe2B5pDQljJapakvAB6r6x3BHq', 2004, 1, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('db513567-48e9-4ae8-8db0-9f48e0004f4e', 'Babbette', 'Brignall', 'bbrignalli@ameblo.jp', '$2y$10$PLN7AZqtP2flj5WdKTE.QOMMpSHJD5ayxYdG1xE9AODFyXEE81xUa', 2014, 0, '74f61cae-9960-11ec-b909-0242ac120002');
INSERT INTO users (user_id, firstName, lastName, email, password, birth_year, is_student, role) VALUES ('3fe01a62-4098-4668-9f0d-09117845000f', 'Rikki', 'Shallow', 'rshallowj@163.com', '$2y$10$i0l8mw.dQYT7AUrYe07a5u02LdT987ynQoAL4JOHO7zivkfu6yh1m', 2001, 0, '74f61cae-9960-11ec-b909-0242ac120002');

-- Table "movies" :
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('298981c8-b03f-471d-89db-cdcf810b41be', 'Mother Night', 'Drama', 'Keith Gordon', 114);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('09111f2e-e8d1-45b2-bf74-a2732b2163f0', 'Planet of the Future, The', 'Action|Adventure|Sci-Fi', 'Mikael Salomon', 90);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('70683ffa-b1cd-4ddf-8a84-0da52ede8941', 'Missing William', 'Drama', 'Kenn MacRae', 90);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('1c8b3703-dd34-4f22-a1de-55fbae4b5352', 'Lion King, The', 'Adventure|Animation|Children|Drama|Musical|IMAX', 'Roger Allers', 89);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('8502cbe8-3477-414d-9e78-6403853375c9', 'Knightriders', 'Action|Adventure|Drama', 'George A. Romero', 146);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('caead4a0-3a30-4245-ab27-a855eb3129e3', 'Carriage to Vienna', 'Drama|War', 'Karel Kachyna', 115);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('d758b8ab-9ebe-4f03-b40c-5eb142ddfa2f', 'Devil''s Own, The', 'Action|Drama|Thriller', 'Alan J. Pakula', 111);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('cdab2762-9967-4495-a725-08d9a2d6d68a', 'Johnny English Reborn', 'Adventure|Comedy|Thriller', 'Oliver Parker', 102);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('26670000-2929-414d-8dbe-43a1299c528a', 'Panama Hattie', 'Comedy|Musical', 'Norman Z. McLeod', 119);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('13bf6114-b0ec-421b-b781-acceabcc3957', 'Golden Earrings', 'Adventure|Romance|War', 'Mitchell Leisen', 95);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('c7e3793b-59b9-4aef-ba75-f3b8d04d221c', '35 Shots of Rum (35 rhums)', 'Drama', 'Claire Denis', 100);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('a03b4c68-80d7-45f3-93ab-e123ea2dbb50', 'Magnetic Monster, The', 'Sci-Fi', 'Herbert L. Strock', 116);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('8370a580-34c1-44cf-ac67-4f32f37986e0', 'Dabangg 2', 'Action|Comedy|Drama|Musical|Romance', 'Arbaaz Khan', 124);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('c5b443bf-ed0d-4bc7-901b-6cfe36cdde03', 'Ned Kelly', 'Action|Crime|Western', 'Gregor Jordan', 110);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('492a11ec-482d-44a8-9a7e-323889ab8a31', 'Bill Hicks: Revelations', 'Comedy', 'Chris Bould', 57);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('0ec3ebd0-e5f6-4289-aea6-8c3d6685471f', 'Oliver Twist', 'Adventure|Crime|Drama', 'Roman Polanski', 130);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('6391d182-8436-42c4-826d-6e5cfd073750', 'Carrie', 'Drama|Horror|Thriller', 'Brian De Palma', 98);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('4f7bacbe-14b5-4106-a478-b36fbf1dcfff', 'Bandit, The (Eskiya)', 'Action|Crime|Romance|Thriller', 'Yavuz Turgul', 128);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('e4eab475-db25-42d9-8a4d-2fb756055fb1', 'Who Is Cletis Tout?', 'Comedy', 'Chris Ver Wiel', 116);
INSERT INTO movies (movie_id, name, genre, director, duration) VALUES ('c4fe6ae6-02ab-4712-aa83-0d0eac1bf546', 'Caine Mutiny Court-Martial, The', 'Drama|War', 'Robert Altman', 100);

-- Table "theaters" :
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('7515ae40-0436-4452-8c86-e6791180016d', 'CGR Abbeville', 'Abbeville', '883070df-3d7b-4f8f-b300-dd1a3abbe858');
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('f4acd9a0-b443-42f0-a04d-fc703b7abb6d', 'CGR Odéon', 'Cherbourg', 'e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd');
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('d1d041fb-bd55-4673-ba99-a7259ca2c7fd', 'CGR Cinecity', 'Troyes', 'bc602a68-ad45-48ad-b03b-fddea0668ba0');
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('00238938-947e-47cf-9de7-e1e8cae6ac6e', 'Mega CGR Torcy', 'Torcy', 'da9b9885-f6a3-4dac-93aa-5d924c120ac4');
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('51fe7abc-6b5f-4025-a9cc-2857c437c53f', 'Mega CGR Niort', 'Niort', 'bb7ea9c0-ddce-4f07-99b2-2c744e187b0e');
INSERT INTO theaters (theater_id, name, city, manager) VALUES ('71fda166-8a93-4500-837b-95042f371564', 'Mega CGR Villenave d''Ornon', 'Villenave d''Ornon', '5a3ca84d-f8a3-48ed-aa17-b12b55a6732c');

-- Table "screeningRooms" :
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('d5ad6d8c-b388-4c3d-8241-35a0b8a7b2b2', 'Humphrey Bogart', 700, '7515ae40-0436-4452-8c86-e6791180016d');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('9e4b54e8-80a5-45cc-9d29-12574c4ddc01', 'Marlon Brando', 350, '7515ae40-0436-4452-8c86-e6791180016d');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('a9737bfa-373a-44ef-b179-4a9420371ed2', 'William Holden', 500, 'f4acd9a0-b443-42f0-a04d-fc703b7abb6d');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('b63aa530-f0b4-4d9f-92ae-7848545e6c6a', 'Henry Fonda', 550, 'f4acd9a0-b443-42f0-a04d-fc703b7abb6d');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('af583662-fb39-4585-a59b-0a3f106f0032', 'James Stewart', 670, 'd1d041fb-bd55-4673-ba99-a7259ca2c7fd');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('b82ef076-99df-4787-af40-37bfdd54fd9a', 'Clint Eastwood', 480, 'd1d041fb-bd55-4673-ba99-a7259ca2c7fd');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('e60ac841-32cf-48d1-ac90-baf8e9effabd', 'Charlie Chaplin', 950, '00238938-947e-47cf-9de7-e1e8cae6ac6e');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('ce1148cc-4d4d-4f87-9c8e-f1a81254354b', 'Audrey Hepburn', 700, '00238938-947e-47cf-9de7-e1e8cae6ac6e');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('6ad8f791-6daa-4fd0-984d-99bf9e4beee5', 'Billy Wilder', 650, '51fe7abc-6b5f-4025-a9cc-2857c437c53f');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('80d17d76-4092-43a2-8bd3-2651412a6b9a', 'Grace Kelly', 400, '51fe7abc-6b5f-4025-a9cc-2857c437c53f');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('456a0196-b459-4201-b585-86c642cd91b6', 'Cary Grant', 730, '71fda166-8a93-4500-837b-95042f371564');
INSERT INTO screeningRooms (room_id, name, seats, theater) VALUES ('d1a2bbf5-eaf1-47fd-a1a4-726f4b420255', 'Alfred Hitchcock', 660, '71fda166-8a93-4500-837b-95042f371564');

-- Table "screenings" :
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('76d7b1c6-fc1d-48d4-b9a6-543e93bcc8b0', '2022-03-14', '20:15', 346, 354, '298981c8-b03f-471d-89db-cdcf810b41be', 'd5ad6d8c-b388-4c3d-8241-35a0b8a7b2b2', '883070df-3d7b-4f8f-b300-dd1a3abbe858');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('40689b2a-3a23-409d-b80f-b19f44bbaed7', '2022-03-19', '10:30', 149, 551, '09111f2e-e8d1-45b2-bf74-a2732b2163f0', 'd5ad6d8c-b388-4c3d-8241-35a0b8a7b2b2', '883070df-3d7b-4f8f-b300-dd1a3abbe858');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('acdb6f85-bf06-436c-b989-d8bf66464247', '2022-03-27', '11:30', 125, 225, '70683ffa-b1cd-4ddf-8a84-0da52ede8941', '9e4b54e8-80a5-45cc-9d29-12574c4ddc01', '883070df-3d7b-4f8f-b300-dd1a3abbe858');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('23dd9f95-2f7a-40bd-85ae-89f2eff55d54', '2022-03-24', '18:15', 237, 113, '1c8b3703-dd34-4f22-a1de-55fbae4b5352', '9e4b54e8-80a5-45cc-9d29-12574c4ddc01', '883070df-3d7b-4f8f-b300-dd1a3abbe858');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('79dda342-a6a0-4375-bcd1-865e01a3f345', '2022-03-06', '17:15', 199, 301, '8502cbe8-3477-414d-9e78-6403853375c9', 'a9737bfa-373a-44ef-b179-4a9420371ed2', 'e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('fdbfed9b-e8e9-476c-8954-87773dc8dbbf', '2022-03-09', '20:30', 243, 257, 'caead4a0-3a30-4245-ab27-a855eb3129e3', 'a9737bfa-373a-44ef-b179-4a9420371ed2', 'e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('3079a518-6bca-43b3-822c-83340eac5a2c', '2022-03-16', '14:45', 412, 138, 'd758b8ab-9ebe-4f03-b40c-5eb142ddfa2f', 'b63aa530-f0b4-4d9f-92ae-7848545e6c6a', 'e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('cba7c337-748e-4acc-94db-2f0becb90cb1', '2022-03-21', '21:15', 127, 423, 'cdab2762-9967-4495-a725-08d9a2d6d68a', 'b63aa530-f0b4-4d9f-92ae-7848545e6c6a', 'e1f10ae2-e8b6-4e6c-b0ce-5bd7fd60e0cd');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('c5070257-f272-4c1c-b329-a0770083a44b', '2022-03-03', '19:15', 499, 171, '26670000-2929-414d-8dbe-43a1299c528a', 'af583662-fb39-4585-a59b-0a3f106f0032', 'bc602a68-ad45-48ad-b03b-fddea0668ba0');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('0f3c8918-acfc-4257-ae74-c0924f8f47ba', '2022-03-04', '19:00', 0, 670, '13bf6114-b0ec-421b-b781-acceabcc3957', 'af583662-fb39-4585-a59b-0a3f106f0032', 'bc602a68-ad45-48ad-b03b-fddea0668ba0');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('e074dcce-d73a-4f90-bec8-94c22ba9c9a8', '2022-03-13', '17:30', 300, 180, 'c7e3793b-59b9-4aef-ba75-f3b8d04d221c', 'b82ef076-99df-4787-af40-37bfdd54fd9a', 'bc602a68-ad45-48ad-b03b-fddea0668ba0');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('6ce9f5f1-8107-402d-8a6d-08ac34760b21', '2022-03-13', '22:15', 215, 265, 'a03b4c68-80d7-45f3-93ab-e123ea2dbb50', 'b82ef076-99df-4787-af40-37bfdd54fd9a', 'bc602a68-ad45-48ad-b03b-fddea0668ba0');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('e0e2d06f-5548-4a0e-b2ca-c9f12d98efb9', '2022-03-28', '20:30', 228, 722, '8370a580-34c1-44cf-ac67-4f32f37986e0', 'e60ac841-32cf-48d1-ac90-baf8e9effabd', 'da9b9885-f6a3-4dac-93aa-5d924c120ac4');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('64c901b9-99df-45a5-be2c-01d2fbbc53ec', '2022-03-21', '15:15', 413, 537, 'c5b443bf-ed0d-4bc7-901b-6cfe36cdde03', 'e60ac841-32cf-48d1-ac90-baf8e9effabd', 'da9b9885-f6a3-4dac-93aa-5d924c120ac4');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('cc6aa25f-0a8a-4d3f-870f-dc5b725f8e80', '2022-03-03', '13:30', 231, 469, '492a11ec-482d-44a8-9a7e-323889ab8a31', 'ce1148cc-4d4d-4f87-9c8e-f1a81254354b', 'da9b9885-f6a3-4dac-93aa-5d924c120ac4');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('b2eb0c46-b6e9-45cd-8855-5e28e0c62928', '2022-03-28', '21:45', 189, 511, '0ec3ebd0-e5f6-4289-aea6-8c3d6685471f', 'ce1148cc-4d4d-4f87-9c8e-f1a81254354b', 'da9b9885-f6a3-4dac-93aa-5d924c120ac4');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('4673d927-d32b-4263-93fc-a65a53e7afb0', '2022-03-23', '14:30', 61, 589, '6391d182-8436-42c4-826d-6e5cfd073750', '6ad8f791-6daa-4fd0-984d-99bf9e4beee5', 'bb7ea9c0-ddce-4f07-99b2-2c744e187b0e');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('b95cdd3f-cebe-4393-a150-37d79900b68d', '2022-03-29', '11:15', 12, 638, '4f7bacbe-14b5-4106-a478-b36fbf1dcfff', '6ad8f791-6daa-4fd0-984d-99bf9e4beee5', 'bb7ea9c0-ddce-4f07-99b2-2c744e187b0e');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('6aabaf0b-4b6d-44bf-98be-e4186ea2ac26', '2022-03-13', '15:45', 222, 178, 'e4eab475-db25-42d9-8a4d-2fb756055fb1', '80d17d76-4092-43a2-8bd3-2651412a6b9a', 'bb7ea9c0-ddce-4f07-99b2-2c744e187b0e');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('62fb4fce-8a66-4e8f-bd1c-8c6a84b5bc8c', '2022-03-04', '17:15', 400, 0, 'c4fe6ae6-02ab-4712-aa83-0d0eac1bf546', '80d17d76-4092-43a2-8bd3-2651412a6b9a', 'bb7ea9c0-ddce-4f07-99b2-2c744e187b0e');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('5a00fd9e-f4a1-4895-b419-56619a921c48', '2022-03-13', '15:45', 151, 579, '298981c8-b03f-471d-89db-cdcf810b41be', '456a0196-b459-4201-b585-86c642cd91b6', '5a3ca84d-f8a3-48ed-aa17-b12b55a6732c');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('a7726abe-5968-49aa-a2a1-1a190b701e65', '2022-03-25', '15:30', 505, 225, '09111f2e-e8d1-45b2-bf74-a2732b2163f0', '456a0196-b459-4201-b585-86c642cd91b6', '5a3ca84d-f8a3-48ed-aa17-b12b55a6732c');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('60080b82-7d52-47a7-883a-b06782ee840c', '2022-03-11', '17:30', 71, 589, '70683ffa-b1cd-4ddf-8a84-0da52ede8941', 'd1a2bbf5-eaf1-47fd-a1a4-726f4b420255', '5a3ca84d-f8a3-48ed-aa17-b12b55a6732c');
INSERT INTO screenings (screening_id, date, time, seats_left, booked_seats, movie, screening_room, programmed_by) VALUES ('254e1dc8-6d12-4900-921a-1c6aba90ada6', '2022-03-13', '22:45', 0, 660, '1c8b3703-dd34-4f22-a1de-55fbae4b5352', 'd1a2bbf5-eaf1-47fd-a1a4-726f4b420255', '5a3ca84d-f8a3-48ed-aa17-b12b55a6732c');

-- Table "paymentModes" :
INSERT INTO paymentModes (mode_id, name) VALUES ('863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'PAY ON THE SPOT');
INSERT INTO paymentModes (mode_id, name) VALUES ('a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'PAY ONLINE');

-- Table "prices" :
INSERT INTO prices (price_id, name, price) VALUES ('e6747bd4-5e60-4f48-b127-d335eabfd3cf', 'FULL PRICE', 9.20);
INSERT INTO prices (price_id, name, price) VALUES ('76811120-112a-411e-8376-16e589d94eae', 'STUDENT', 7.60);
INSERT INTO prices (price_id, name, price) VALUES ('72805b5a-13dd-4b0c-9dcd-a4cf1599846b', 'UNDER 14 YO', 5.90);

-- Table "bookings" :
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('4c037ddf-08fc-4742-8734-2e15b56ac476', 'b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', '571b5724-874e-47fa-8195-14b545304fca', '76d7b1c6-fc1d-48d4-b9a6-543e93bcc8b0', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('b3ab8d86-be61-41e1-bef4-f52c5630153a', '7719d8f1-48ad-490f-8b6b-1d6917fd781e', '571b5724-874e-47fa-8195-14b545304fca', '76d7b1c6-fc1d-48d4-b9a6-543e93bcc8b0', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('97da4e04-c8cc-41b9-a359-7addbd33e6db', '2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', '571b5724-874e-47fa-8195-14b545304fca', '40689b2a-3a23-409d-b80f-b19f44bbaed7', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('66577420-56ee-4a04-acb6-78b3bc28f26d', '684836ed-cb0a-44ae-a46c-dfe32a0bc52c', '571b5724-874e-47fa-8195-14b545304fca', '40689b2a-3a23-409d-b80f-b19f44bbaed7', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('063041ac-a44f-4f4d-9c4d-32b2e275e757', 'a66594d7-f20a-4d06-8d58-11b416ccbb8e', '571b5724-874e-47fa-8195-14b545304fca', 'acdb6f85-bf06-436c-b989-d8bf66464247', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('b88c82e2-e6b0-4e9c-8d19-e03705982fa3', '7719d8f1-48ad-490f-8b6b-1d6917fd781e', '571b5724-874e-47fa-8195-14b545304fca', 'acdb6f85-bf06-436c-b989-d8bf66464247', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('95cb7ea2-494e-470f-8a2a-023fba74ba06', '684836ed-cb0a-44ae-a46c-dfe32a0bc52c', '571b5724-874e-47fa-8195-14b545304fca', '23dd9f95-2f7a-40bd-85ae-89f2eff55d54', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('e0a67c09-c8ec-4f58-bc2b-67414df9fcf4', 'b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', '571b5724-874e-47fa-8195-14b545304fca', '23dd9f95-2f7a-40bd-85ae-89f2eff55d54', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('1a41b8b7-4704-4ac3-b60c-59b7b591d75f', '7719d8f1-48ad-490f-8b6b-1d6917fd781e', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', '79dda342-a6a0-4375-bcd1-865e01a3f345', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('e4458310-f893-4a40-81d4-7c4966f09d5b', 'a66594d7-f20a-4d06-8d58-11b416ccbb8e', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', '79dda342-a6a0-4375-bcd1-865e01a3f345', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('4ffe76ab-568d-44cb-b0e9-ebad42d3aaf0', '3aab3378-0ffe-4742-bc07-583d86c534f6', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', 'fdbfed9b-e8e9-476c-8954-87773dc8dbbf', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('2aa9e106-6fab-4bd2-a01c-b3b0a576a630', '773946b3-b67e-494c-ad29-d46c7de5c2e1', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', 'fdbfed9b-e8e9-476c-8954-87773dc8dbbf', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('358a23f5-75e6-48c7-9bf8-a9585b31848c', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', '3079a518-6bca-43b3-822c-83340eac5a2c', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('940e95cd-2baf-4222-9334-b46c6416d29d', '2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', '3079a518-6bca-43b3-822c-83340eac5a2c', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('25135887-9081-4ab3-9c5f-9e147eee01f7', '2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', 'cba7c337-748e-4acc-94db-2f0becb90cb1', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('232b556b-3525-4026-a4b5-a64d9b135907', '3aab3378-0ffe-4742-bc07-583d86c534f6', 'd4281ac1-a836-4a2d-bb99-5a7a2ca9da66', 'cba7c337-748e-4acc-94db-2f0becb90cb1', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('0f049de0-fe5e-46d4-b233-d55ddae72891', '773946b3-b67e-494c-ad29-d46c7de5c2e1', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', 'c5070257-f272-4c1c-b329-a0770083a44b', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('9efa0cb6-56c7-49db-b4d8-ac082433fb1a', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', 'c5070257-f272-4c1c-b329-a0770083a44b', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('f5c2f971-9a35-4be3-8719-4de2ea8f19a1', 'db513567-48e9-4ae8-8db0-9f48e0004f4e', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', '0f3c8918-acfc-4257-ae74-c0924f8f47ba', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('3461d8ad-e2c2-44ab-9a4b-d41a76b5544b', '684836ed-cb0a-44ae-a46c-dfe32a0bc52c', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', '0f3c8918-acfc-4257-ae74-c0924f8f47ba', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('cad4debf-cfb2-4185-8381-412f2f5c4fd1', 'a66594d7-f20a-4d06-8d58-11b416ccbb8e', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', 'e074dcce-d73a-4f90-bec8-94c22ba9c9a8', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('bda7d43c-0ef1-4ed2-bced-54d2be863148', '773946b3-b67e-494c-ad29-d46c7de5c2e1', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', 'e074dcce-d73a-4f90-bec8-94c22ba9c9a8', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('ceece659-bf76-48eb-8d76-92c5fc22d180', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', '6ce9f5f1-8107-402d-8a6d-08ac34760b21', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('67d50608-0e45-4205-9b5e-c6503528ded2', '3fe01a62-4098-4668-9f0d-09117845000f', '1dd9eefa-5661-4bbb-9ce8-d303e6a4f622', '6ce9f5f1-8107-402d-8a6d-08ac34760b21', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('78ce715a-10e5-48be-913e-3f6c97b93999', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'e0e2d06f-5548-4a0e-b2ca-c9f12d98efb9', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('e91e66e6-118c-403d-bde4-1f1676a5a8ea', 'db513567-48e9-4ae8-8db0-9f48e0004f4e', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'e0e2d06f-5548-4a0e-b2ca-c9f12d98efb9', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('9258379e-9153-42e1-9bc6-214c5e8a63e5', '3fe01a62-4098-4668-9f0d-09117845000f', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', '64c901b9-99df-45a5-be2c-01d2fbbc53ec', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('1a843343-c0d3-478c-9004-a8d2d231c3fa', '684836ed-cb0a-44ae-a46c-dfe32a0bc52c', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', '64c901b9-99df-45a5-be2c-01d2fbbc53ec', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('0dbd4ba5-f74d-4c82-bce4-bce6dcbb46a6', '3aab3378-0ffe-4742-bc07-583d86c534f6', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'cc6aa25f-0a8a-4d3f-870f-dc5b725f8e80', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('b9b34af6-8636-411b-b3a8-012c651bbe85', '773946b3-b67e-494c-ad29-d46c7de5c2e1', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'cc6aa25f-0a8a-4d3f-870f-dc5b725f8e80', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('a4669787-999e-4e16-9b45-a85736d499f9', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'b2eb0c46-b6e9-45cd-8855-5e28e0c62928', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('e79f4871-9ab6-48c9-bf3d-1e46d0edd4f4', 'db513567-48e9-4ae8-8db0-9f48e0004f4e', '5630b662-2094-4b1e-b9d5-4efb36b0fc9f', 'b2eb0c46-b6e9-45cd-8855-5e28e0c62928', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('1509fb59-8d8b-47fc-b1b3-254469caf525', '3fe01a62-4098-4668-9f0d-09117845000f', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '4673d927-d32b-4263-93fc-a65a53e7afb0', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('a43db568-e7f4-4ae4-942a-5f1f12c00aa4', '3aab3378-0ffe-4742-bc07-583d86c534f6', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '4673d927-d32b-4263-93fc-a65a53e7afb0', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('7355643f-061f-40d9-a552-a691170a8726', '7719d8f1-48ad-490f-8b6b-1d6917fd781e', '1f3b5b38-f003-4b47-a026-af34347d1a4a', 'b95cdd3f-cebe-4393-a150-37d79900b68d', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('eecca7bb-7cc0-4651-88ab-535081c6bb25', 'b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', '1f3b5b38-f003-4b47-a026-af34347d1a4a', 'b95cdd3f-cebe-4393-a150-37d79900b68d', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('4e6a7da0-87c2-41d9-b855-9adeccec2e38', 'db513567-48e9-4ae8-8db0-9f48e0004f4e', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '6aabaf0b-4b6d-44bf-98be-e4186ea2ac26', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('f0a5a516-0335-4964-85cc-73e37a266f21', 'b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '6aabaf0b-4b6d-44bf-98be-e4186ea2ac26', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('1a4293c0-a8eb-4039-9e06-2ebdce0b6bb7', 'a66594d7-f20a-4d06-8d58-11b416ccbb8e', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '62fb4fce-8a66-4e8f-bd1c-8c6a84b5bc8c', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('c992e3f1-4b5f-4171-acc2-5f7d9e0d8e71', 'db513567-48e9-4ae8-8db0-9f48e0004f4e', '1f3b5b38-f003-4b47-a026-af34347d1a4a', '62fb4fce-8a66-4e8f-bd1c-8c6a84b5bc8c', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('bdd9604b-7405-4e52-9de8-380b4cebbf39', '2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '5a00fd9e-f4a1-4895-b419-56619a921c48', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('3704f39f-7c08-489d-9c73-a081038db11c', '62cc43d4-17e5-493d-8a35-cb248a0d4d51', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '5a00fd9e-f4a1-4895-b419-56619a921c48', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('bc540c03-dda9-4657-ad45-7e1387298cf5', '773946b3-b67e-494c-ad29-d46c7de5c2e1', 'e3707487-7537-4ca8-8cf4-544d4b88c641', 'a7726abe-5968-49aa-a2a1-1a190b701e65', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('096fb306-da1d-4cc7-89c6-02dc09ecf645', '3aab3378-0ffe-4742-bc07-583d86c534f6', 'e3707487-7537-4ca8-8cf4-544d4b88c641', 'a7726abe-5968-49aa-a2a1-1a190b701e65', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('1cccf015-f3ae-4e2e-b18f-db3b1af75f28', 'a66594d7-f20a-4d06-8d58-11b416ccbb8e', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '60080b82-7d52-47a7-883a-b06782ee840c', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '72805b5a-13dd-4b0c-9dcd-a4cf1599846b');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('67e3e39d-e8ae-4306-9941-7d049a049393', '7719d8f1-48ad-490f-8b6b-1d6917fd781e', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '60080b82-7d52-47a7-883a-b06782ee840c', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('76835199-d7b2-4cf0-a742-aaf9af1f95d5', '2e7f3034-a1b0-4886-afc0-c8c63cb26b3f', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '254e1dc8-6d12-4900-921a-1c6aba90ada6', 'a10e87e8-3a42-4315-be2a-fbc63997f5ab', '76811120-112a-411e-8376-16e589d94eae');
INSERT INTO bookings (booking_id, client_id, vendor_id, screening, payment_mode, price) VALUES ('0d4841ff-0dc5-42b8-8434-33388976582b', 'b4fd93d2-b32c-4013-86a9-5c4fb4d6e4ea', 'e3707487-7537-4ca8-8cf4-544d4b88c641', '254e1dc8-6d12-4900-921a-1c6aba90ada6', '863e2a01-0eb6-4ef9-b749-355a28aee7d6', 'e6747bd4-5e60-4f48-b127-d335eabfd3cf');
