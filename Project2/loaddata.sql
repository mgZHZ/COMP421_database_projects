-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
-- INSERT INTO MYTEST01 (id, value) VALUES(4, 1300);
-- -- A more complex syntax that saves you typing effort.
-- INSERT INTO MYTEST01 (id, value) VALUES
--  (7, 5144)
-- ,(3, 73423)
-- ,(6, -1222)
-- ;

INSERT INTO Mother
(qhcID, name, dob, phoneNum, email, address, bloodType, lastPeriod, expectedbirthTimeFrame, profession) VALUES
('GUTV 0000 1980 0101', 'Victoria Gutierrez', DATE'1980-01-01', '4389210101', 'victoriag@mother.com', 'a1a 1a1', 'A', DATE'2022-01-20', DATE'2022-12-01', 'astronaute'),
('HENA 0000 1987 0726', 'April Henderson', DATE'1987-07-26', '3443134364','aprilh@mother.com','b2b 2b2','B',DATE'2022-01-05',DATE'2022-12-02','broadcaster'),
('POSC 0000 1986 1212', 'Cassy Postma', DATE'1986-12-12', '4389231212','cassyp@mother.com','c3c 3c3','O',DATE'2022-02-02',DATE'2023-02-02','cs teacher'),
('THOD 0000 1985 1231', 'Darla Thomas', DATE'1985-12-31', '9495099733','darlat@mother.com','d4d 4d4','AB',DATE'2022-01-16',DATE'2022-12-01','historian'),
('HOUX 0000 1988 1124', 'Xiaopei Hou', DATE'1988-11-24', '7347940298','xiaopeih@mother.com','e5e 5e5','O',DATE'2022-02-19',DATE'2023-02-04','inventor')
;

INSERT INTO SecondParent
(fID, name, dob, phoneNum, email, address, QHCid, bloodType, profession) VALUES
('F GONA 871112', 'Andrew Gonzale', DATE'1987-11-22', '8302086820', 'andrewg@sp.com', 'f6f 6f6', 'GONA 0000 1987 1122', 'A', 'lighthouse keeper'),
('F JACJ 770712', 'Jonathan Jackson', DATE'1977-07-12', '9254651298', 'jonathanj@sp.com', 'g7g 7g7', 'JACJ 0000 1977 0712', 'A', 'boat builder'),
('F REPW 860612', 'Wan Reportcard', DATE'1986-06-12', '6478698888', 'wanr@sp.com', 'h8h 8h8', 'REPW 0000 1986 0612', 'O', 'designer'),
('F DAVD 840412', 'Derrick Davidson', DATE'1984-04-12', '7703651523', 'derrickd@sp.com', 'i9i 9i9', 'DAVD 0000 1984 0412', 'AB', 'musician'),
('F MENX 880529', 'Xiaoran Meng', DATE'1988-05-29', '6472332333', 'xiaoranm@sp.com', 'k0k 0k0', 'MENX 0000 1988 0529', 'B', 'pilot')
;

INSERT INTO CoupleInSystem
(cID) VALUES
('C GUTV GONA'),
('C GUTV DAVD'),
('C HENA JACJ'),
('C HENA DAVD'),
('C POSC REPW'),
('C HOUX MENX')
;

INSERT INTO AsMother
(cID,qhcID) VALUES
('C GUTV GONA', 'GUTV 0000 1980 0101'),
('C GUTV DAVD', 'GUTV 0000 1980 0101'),
('C HENA JACJ', 'HENA 0000 1987 0726'),
('C HENA DAVD', 'HENA 0000 1987 0726'),
('C POSC REPW', 'POSC 0000 1986 1212'),
('C HOUX MENX', 'HOUX 0000 1988 1124')
;

INSERT INTO AsSecondParent
(cID, fID) 
VALUES
('C GUTV GONA', 'F GONA 871112'),
('C GUTV DAVD', 'F DAVD 840412'),
('C HENA JACJ', 'F JACJ 770712'),
('C HENA DAVD', 'F DAVD 840412'),
('C POSC REPW', 'F REPW 860612'),
('C HOUX MENX', 'F MENX 880529')
;


INSERT INTO PregnancyCouple
(pcID, numofPregnancy, numofFetus, expDueDate, estDueDate, UltraDueDate, placeGiveBirth) 
VALUES
('VD 2020', 1, 1, DATE'2020-12-01', DATE'2020-12-10', DATE'2020-12-20', 'birth center'),
('VD 2022', 2, 2, DATE'2022-12-01', DATE'2022-12-11', null, 'home'),
('AJ 2019', 1, 1, DATE'2019-12-02', DATE'2019-12-12', DATE'2019-12-22', 'birth center'),
('AD 2017', 1, 1, DATE'2021-12-03', DATE'2021-12-13', DATE'2021-12-23', 'birth center'),
('CW 2018', 1, 1, DATE'2018-12-04', DATE'2018-12-14', DATE'2018-12-24', 'birth center'),
('CW 2022', 2, 2, DATE'2022-07-05', DATE'2022-07-15', DATE'2022-07-25', 'birth center'),
('XX 2023', 1, 0, DATE'2023-12-06', null, null, 'birth center')
;


INSERT INTO isPregnant
(pcID,cID) 
VALUES
('VD 2020', 'C GUTV DAVD'),
('VD 2022', 'C GUTV DAVD'),
('AJ 2019', 'C HENA JACJ'),
('AD 2017', 'C HENA DAVD'),
('CW 2018', 'C POSC REPW'),
('CW 2022', 'C POSC REPW'),
('XX 2023', 'C HOUX MENX')
;

INSERT INTO Fetus
(bID, pcID, sex, name, bloodType, birthDateAndTime)
VALUES
(1000, 'VD 2020', 'F', 'VD0', 'B', TIMESTAMP'2020-12-21-01.00.00.000000'),
(1001, 'VD 2022', 'F', 'VD1', 'A', null),
(1002, 'VD 2022', 'M', 'VD2', 'A', null),
(1003, 'AJ 2019', 'F', 'AJ1', 'B', TIMESTAMP'2019-12-21-01.00.00.000000'),
(1004, 'AD 2017', 'M', 'AD1', 'O', TIMESTAMP'2017-12-21-01.00.00.000000'),
(1005, 'CW 2018', 'F', 'CW1', 'A', TIMESTAMP'2018-12-21-01.00.00.000000'),
(1006, 'CW 2022', 'M', 'CW2', 'A', null),
(1007, 'CW 2022', 'F', 'CW3', 'AB', TIMESTAMP'2022-12-21-01.00.00.000000')
-- (1008, 'XX 2023', 'M', 'XX1', 'A', null),
-- (1009, 'XX 2023', 'F', 'XX2', 'A', null)
;

INSERT INTO Midwife
(pID, name, phoneNum, memail) 
VALUES
('MW GIRM 0101_1', 'Marion Girard', '1232343456', 'mariong@midwife.com'),
('MW WANL 0712_2', 'Laofeng Wang', '2343454567', 'laofengw@widwife.com'),
('MW CARD 0926_3', 'Dianna Carter', '3565676789', 'diannac@widwife.com'),
('MW WEBB 0617_4', 'Bridgett Webb', '4045679483', 'bridgettw@widwife.com'),
('WM SANE 0810_5', 'Ester Santimario', '5673845757', 'esters@widwife.com')
;

INSERT INTO Institution
(email, name, address, website, phoneNum)
VALUES
('LSL@inst.com', 'Lac-Saint-Louis', 'addrLSL', 'www.LSL.com', '1000000001'),
('YYF@inst.com', 'YYF', 'addrYYF', 'www.YYF.com', '1000000002'),
('ABC@inst.com', 'ABC', 'addrABC', 'www.ABC.com', '1000000003'),
('DEF@inst.com', 'DEF', 'addrDEF', 'www.DEF.com', '1000000004'),
('GHI@inst.com', 'GHI', 'addrGHI', 'www.GHI.com', '1000000005'),
('JKL@inst.com', 'JKL', 'addrJKL', 'www.JKL.com', '1000000006'),
('MNO@inst.com', 'MNO', 'addrMNO', 'www.MNQ.com', '1000000005'),
('PQR@inst.com', 'PQR', 'addrPQR', 'www.PQR.com', '1000000005'),
('STU@inst.com', 'STU', 'addrSTU','www.STU.com', '1000000005'),
('VWX@inst.com', 'VWX', 'addrVWX','www.VWX.com', '1000000005')
;

INSERT INTO Inst_BirthingCenter
(email)
VALUES
('LSL@inst.com'),
('YYF@inst.com'),
('ABC@inst.com'),
('DEF@inst.com'),
('GHI@inst.com')
;

INSERT INTO Inst_CommunityClinic
(email)
VALUES
('JKL@inst.com'),
('MNO@inst.com'),
('PQR@inst.com'),
('STU@inst.com'),
('VWX@inst.com')
;

INSERT INTO WorkFor
(pID, email)
VALUES
('MW GIRM 0101_1', 'LSL@inst.com'),
('MW WANL 0712_2', 'YYF@inst.com'),
('MW CARD 0926_3', 'ABC@inst.com'),
('MW WEBB 0617_4', 'DEF@inst.com'),
('WM SANE 0810_5', 'LSL@inst.com')
;

INSERT INTO InfomationSession
(iID, language, DateAndTime)
VALUES
('IF 001', 'English', TIMESTAMP'2010-10-10-01.01.01.000001'), 
('IF 002', 'French', TIMESTAMP'2010-10-11-01.01.01.000001'),
('IF 003', 'English', TIMESTAMP'2010-10-12-01.01.01.000001'),
('IF 004', 'French', TIMESTAMP'2010-10-13-01.01.01.000001'),
('IF 005', 'English', TIMESTAMP'2010-10-14-01.01.01.000001')
;

INSERT INTO Registration
(iID, cID, attendance)
VALUES
('IF 001', 'C GUTV GONA', 'NO'),
('IF 001', 'C GUTV DAVD', 'YES'),
('IF 002', 'C HENA JACJ', 'YES'),
('IF 003', 'C HENA DAVD', 'YES'),
('IF 003', 'C POSC REPW', 'NO'),
('IF 005', 'C POSC REPW', 'YES'),
('IF 005', 'C HOUX MENX', 'YES')
;

INSERT INTO Host
(iID, pID)
VALUES
('IF 001', 'MW GIRM 0101_1'), 
('IF 002', 'WM SANE 0810_5'),
('IF 003', 'MW GIRM 0101_1'),
('IF 004', 'WM SANE 0810_5'),
('IF 005', 'MW CARD 0926_3')
;

INSERT INTO AssignPrimary
(pcID, pID) VALUES
('VD 2020', 'MW GIRM 0101_1'),
('VD 2022', 'MW GIRM 0101_1'),
('AJ 2019', 'WM SANE 0810_5'),
('AD 2017', 'MW GIRM 0101_1'),
('CW 2018', 'MW CARD 0926_3'),
('CW 2022', 'MW GIRM 0101_1'),
('XX 2023', 'MW GIRM 0101_1')
;

INSERT INTO AssignBackup
(pcID, pID) VALUES
('VD 2020', 'WM SANE 0810_5'),
('VD 2022', 'WM SANE 0810_5'),
('AJ 2019', 'MW GIRM 0101_1'),
('AD 2017', 'WM SANE 0810_5'),
('CW 2018', 'MW CARD 0926_3'),
('CW 2022', 'WM SANE 0810_5'),
('XX 2023', 'WM SANE 0810_5')
;



INSERT INTO GiveBirthAtCenter
(pcID, email) VALUES
('VD 2020', 'LSL@inst.com'),
('AJ 2019', 'LSL@inst.com'),
('AD 2017', 'LSL@inst.com'),
('CW 2018', 'ABC@inst.com'),
('CW 2022', 'DEF@inst.com'),
('XX 2023', 'LSL@inst.com')
;


INSERT INTO Appointment
(aID, DateAndTime) VALUES
('A 001', TIMESTAMP'2020-03-21-07.00.00.000000'),
('A 002', TIMESTAMP'2022-03-21-08.00.00.000000'),
('A 003', TIMESTAMP'2022-03-21-09.00.00.000000'),
('A 004', TIMESTAMP'2022-03-22-10.00.00.000000'),
('A 005', TIMESTAMP'2022-03-25-11.00.00.000000')
;

INSERT INTO Note
(aID, nTime, content) VALUES
('A 004', TIMESTAMP'2022-03-22-10.04.01.000000', 'content 4-1.'),
('A 004', TIMESTAMP'2022-03-22-10.04.02.000000', 'content 4-2.'),
('A 004', TIMESTAMP'2022-03-22-10.04.03.000000', 'content 4-3.'),
('A 005', TIMESTAMP'2022-03-25-10.05.01.000000', 'content 5-1.'),
('A 005', TIMESTAMP'2022-03-25-10.05.02.000000', 'content 5-2.')
;


INSERT INTO MedicalTest
(tID, testType, testName, prescribedDate, labDate, sampleDate, result)
VALUES
('T-X W 001', 'X-ray', 'whole body x-ray', DATE'2020-03-21', DATE'2020-03-22', NULL, NULL),
('T-B C 001', 'Blood test', 'common', DATE'2022-02-22', DATE'2022-2-28', NULL, 'ok'),
('T-B I 001', 'Blood test', 'blood iron', DATE'2020-03-21', DATE'2020-03-23', NULL, 'iron --'),
('T-B I 002', 'Blood test', 'blood iron', DATE'2022-03-21', DATE'2022-03-23', NULL, 'iron -'),
('T-B I 003', 'Blood test', 'blood iron', DATE'2022-03-21', NULL, NULL, 'iron +'),
('T-U C 001', 'Urine', 'common', DATE'2022-03-25', DATE'2022-03-26', NULL, NULL)
;


INSERT INTO LabTechnician
(techID, name, phoneNum)
VALUES
('Tech tA', 'tech A', '6470000001'),
('Tech tB', 'tech B', '6470000002'),
('Tech tC', 'tech C', '6470000003'),
('Tech tD', 'tech D', '6470000004'),
('Tech tE', 'tech E', '6470000005')
;



INSERT INTO SetupAppointment
(aID, pcID, pID)
VALUES
('A 001', 'VD 2020', 'MW GIRM 0101_1'),
('A 002', 'VD 2022', 'MW GIRM 0101_1'),
('A 003', 'VD 2022', 'MW GIRM 0101_1'),

('A 004', 'CW 2022', 'MW GIRM 0101_1'),
('A 005', 'XX 2023', 'MW GIRM 0101_1')
;




INSERT INTO Prescribtion
(aID,tID)
VALUES
('A 001', 'T-X W 001'),
('A 001', 'T-B I 001'),
('A 002', 'T-B I 002'),
('A 003', 'T-B I 003'),

('A 004', 'T-X W 001'),
('A 005', 'T-U C 001')
;




INSERT INTO ConductBy
(tID, techID)
VALUES
('T-X W 001', 'Tech tA'),
('T-B C 001', 'Tech tB'),
('T-B I 001', 'Tech tB'),
('T-B I 002', 'Tech tB'),
('T-B I 003', 'Tech tB'),
('T-U C 001', 'Tech tC')
;




