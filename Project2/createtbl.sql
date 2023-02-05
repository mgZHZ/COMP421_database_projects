-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
-- CREATE TABLE MYTEST01
-- (
--   id INTEGER NOT NULL
--  ,value INTEGER
--  ,PRIMARY KEY(id)
-- );

CREATE TABLE Mother
( 
  qhcID CHAR(19) NOT NULL,
  name VARCHAR(30) NOT NULL,
  dob DATE NOT NULL,
  phoneNum CHAR(10) NOT NULL,
  email VARCHAR(25) NOT NULL,
  address VARCHAR(20) NOT NULL,
  bloodType VARCHAR(5) NOT NULL,
  lastPeriod DATE NOT NULL,
  expectedbirthTimeFrame DATE NOT NULL,
  profession VARCHAR(20) NOT NULL,
  PRIMARY KEY(qhcID)
);

CREATE TABLE SecondParent
(
  fID CHAR(13) NOT NULL,
  name VARCHAR(30) NOT NULL,
  dob DATE NOT NULL,
  phoneNum CHAR(10) NOT NULL,
  email VARCHAR(25),
  address VARCHAR(20),
  qhcID CHAR(19),
  bloodType VARCHAR(5),
  profession VARCHAR(20) NOT NULL,
  PRIMARY KEY(fID)
);

CREATE TABLE CoupleInSystem
( 
  cID CHAR(11) NOT NULL,
  PRIMARY KEY (cID)
);

CREATE TABLE AsMother
(
  cID CHAR(11) NOT NULL,
  qhcID CHAR(19) NOT NULL,
  PRIMARY KEY(cID),
  FOREIGN KEY(cID) REFERENCES CoupleInSystem,
  FOREIGN KEY(qhcID) REFERENCES Mother
);

CREATE TABLE AsSecondParent
(
  cID CHAR(11) NOT NULL,
  fID CHAR(13) NOT NULL,
  PRIMARY KEY(cID),
  FOREIGN KEY(cID) REFERENCES CoupleInSystem,
  FOREIGN KEY(fID) REFERENCES SecondParent
);

CREATE TABLE PregnancyCouple
(
  pcID CHAR(7) NOT NULL,
  numofPregnancy INTEGER,
  numofFetus INTEGER,
  expDueDate DATE,
  estDueDate DATE,
  UltraDueDate DATE,
  placeGiveBirth VARCHAR(20),
  PRIMARY KEY(pcID)
);

CREATE TABLE isPregnant
(
  pcID CHAR(7) NOT NULL,
  cID CHAR(11) NOT NULL,
  PRIMARY KEY (pcID),
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple,
  FOREIGN KEY (cID) REFERENCES CoupleInSystem
);

CREATE TABLE Fetus
(
  bID INTEGER NOT NULL,
  pcID CHAR(7) NOT NULL,
  sex VARCHAR(10),
  name VARCHAR(10),
  bloodType VARCHAR(5),
  birthDateAndTime TIMESTAMP,
  PRIMARY KEY (pcID, bID),
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple
);

CREATE TABLE Midwife
(
  pID VARCHAR(14) NOT NULL,
  name VARCHAR(30) NOT NULL,
  phoneNum CHAR(10) NOT NULL,
  memail VARCHAR(40) NOT NULL,
  PRIMARY KEY (pID)
);

CREATE TABLE Institution
(
  email VARCHAR(40) NOT NULL,
  name VARCHAR(30) NOT NULL,
  address VARCHAR(20) NOT NULL,
  website VARCHAR(40),
  phoneNum CHAR(10) NOT NULL,
  PRIMARY KEY (email)
);

CREATE TABLE Inst_CommunityClinic
(
  email VARCHAR(40) NOT NULL,
  PRIMARY KEY(email),
  FOREIGN KEY(email) REFERENCES Institution
);

CREATE TABLE Inst_BirthingCenter
(
  email VARCHAR(40) NOT NULL,
  PRIMARY KEY(email),
  FOREIGN KEY(email) REFERENCES Institution
);

CREATE TABLE WorkFor
(
  pID VARCHAR(14) NOT NULL,
  email VARCHAR(40) NOT NULL,
  PRIMARY KEY(pID),
  FOREIGN KEY(pID) REFERENCES Midwife,
  FOREIGN KEY(email) REFERENCES Institution
);

CREATE TABLE InfomationSession
(
  iID VARCHAR(6) NOT NULL,
  language VARCHAR(20) NOT NULL,
  DateAndTime TIMESTAMP NOT NULL,
  PRIMARY KEY(iID)
);

CREATE TABLE Registration
(
  iID VARCHAR(6) NOT NULL,
  cID CHAR(11) NOT NULL,
  attendance VARCHAR(5) NOT NULL,
  PRIMARY KEY(iID, cID),
  FOREIGN KEY(iID) REFERENCES InfomationSession,
  FOREIGN KEY(cID) REFERENCES CoupleInSystem
);

CREATE TABLE Host
(
  iID VARCHAR(6) NOT NULL,
  pID VARCHAR(14) NOT NULL,
  PRIMARY KEY (iID),
  FOREIGN KEY (iID) REFERENCES InfomationSession,
  FOREIGN KEY (pID) REFERENCES Midwife
);


CREATE TABLE AssignPrimary
(
  pcID CHAR(7) NOT NULL,
  pID VARCHAR(14) NOT NULL,
  PRIMARY KEY (pcID), 
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple,
  FOREIGN KEY (pID) REFERENCES Midwife
);

CREATE TABLE AssignBackup
(
  pcID CHAR(7) NOT NULL,
  pID VARCHAR(14) NOT NULL,
  PRIMARY KEY (pcID), 
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple,
  FOREIGN KEY (pID) REFERENCES Midwife
);


CREATE TABLE GiveBirthAtCenter
(
  pcID CHAR(7) NOT NULL,
  email VARCHAR(40) NOT NULL,
  PRIMARY KEY (pcID, email), 
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple,
  FOREIGN KEY (email) REFERENCES Inst_BirthingCenter
);



CREATE TABLE Appointment
(
  aID VARCHAR(5) NOT NULL,
  DateAndTime TIMESTAMP NOT NULL,
  PRIMARY KEY (aID)
);

CREATE TABLE Note
(
  aID VARCHAR(5) NOT NULL,
  nTime TIMESTAMP NOT NULL,
  content VARCHAR(25) NOT NULL,
  PRIMARY KEY (aID, nTime),
  FOREIGN KEY (aID) REFERENCES Appointment
);


CREATE TABLE MedicalTest
(
  tID VARCHAR(10) NOT NULL,
  testType VARCHAR(15) NOT NULL,
  testName VARCHAR(20) NOT NULL,
  prescribedDate DATE NOT NULL,
  labDate DATE,
  sampleDate DATE,
  result VARCHAR(15),
  PRIMARY KEY (tID)
);


CREATE TABLE LabTechnician
(
  techID VARCHAR(7) NOT NULL,
  name VARCHAR(20) NOT NULL,
  phoneNum VARCHAR(10) NOT NULL,
  PRIMARY KEY (techID)
);



CREATE TABLE SetupAppointment
(
  aID VARCHAR(5) NOT NULL,
  pcID CHAR(7) NOT NULL,
  pID VARCHAR(14) NOT NULL,
  PRIMARY KEY (aID), 
  FOREIGN KEY (aID) REFERENCES Appointment,
  FOREIGN KEY (pcID) REFERENCES PregnancyCouple,
  FOREIGN KEY (pID) REFERENCES Midwife
);


CREATE TABLE Prescribtion
(
  aID VARCHAR(5) NOT NULL,
  tID VARCHAR(10) NOT NULL,
  PRIMARY KEY (aID, tID), 
  FOREIGN KEY (aID) REFERENCES Appointment,
  FOREIGN KEY (tID) REFERENCES MedicalTest
);

CREATE TABLE ConductBy
(
  tID VARCHAR(10) NOT NULL,
  techID VARCHAR(7) NOT NULL,
  PRIMARY KEY (tID, techID), 
  FOREIGN KEY (tID) REFERENCES MedicalTest,
  FOREIGN KEY (techID) REFERENCES LabTechnician
);




