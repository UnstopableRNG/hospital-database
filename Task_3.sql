-- HospitalDB Task 3 Queries
-- Q1 Show details of all medical departments
SELECT * FROM Department;

-- Q2 Find contact details of patient “John Bob” with PatientID = 5612
SELECT FirstName, LastName, Address, Phone 
FROM Patient
WHERE PatientID = 5612;

-- Q3 Update contact details of patient with ID = 3456
UPDATE Patient
SET Phone = '085-9001122', Address = '20 New Road, Dublin'
WHERE PatientID = 3456;

-- Q4 Schedule a new medical appointment
INSERT INTO Appointment (AppointmentDate, AppointmentTime, PatientID, StaffID, TreatmentID)
VALUES ('2025-12-10', '11:00:00', 5612, 1, 2);

-- Q5 Find details of all patients who have Diabetes
SELECT * 
FROM Patient
WHERE MedicalHistory LIKE '%Diabetes%';

-- Q6 Display first and last name of all patients under Dr. Kavin Smith
SELECT p.FirstName, p.LastName
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Staff s ON a.StaffID = s.StaffID
WHERE s.FirstName = 'Kavin' AND s.LastName = 'Smith';

-- Q7 Change all patients in Orthopedics to Orthopedic Surgery Department
UPDATE Patient
SET DepartmentID = (SELECT DepartmentID FROM Department WHERE Name = 'Orthopedic Surgery')
WHERE DepartmentID = (SELECT DepartmentID FROM Department WHERE Name = 'Orthopedics');

-- Q8 Display first name, surname, and hire date of all doctors sorted by descending hire date
SELECT FirstName, LastName, HireDate
FROM Staff
WHERE JobTitle = 'Doctor'
ORDER BY HireDate DESC;

-- Q9 Count how many patients are undergoing 'heart Surgery' treatment
SELECT COUNT(*) AS HeartSurgeryPatients
FROM Appointment a
JOIN Treatment t ON a.TreatmentID = t.TreatmentID
WHERE t.Name = 'heart Surgery';

-- Q10 Add one new record to each table
INSERT INTO Department (Name, Phone) VALUES ('Respiratory', '01-5551111');

INSERT INTO Staff (FirstName, LastName, JobTitle, HireDate, DaysOffTaken, DepartmentID)
VALUES ('Sarah', 'Higgins', 'Nurse', '2024-01-01', 0,
        (SELECT DepartmentID FROM Department WHERE Name = 'Respiratory'));

INSERT INTO Patient (FirstName, LastName, Address, Phone, MedicalHistory, DepartmentID)
VALUES ('Conor','Foley','19 York Road, Dublin','085-1239876','None',
        (SELECT DepartmentID FROM Department WHERE Name = 'Respiratory'));

INSERT INTO Treatment (Name, Description)
VALUES ('CT Scan', 'Computed tomography scan');

INSERT INTO Appointment (AppointmentDate, AppointmentTime, PatientID, StaffID, TreatmentID)
VALUES ('2025-12-12','10:00:00', 5612, 1,
        (SELECT TreatmentID FROM Treatment WHERE Name='CT Scan'));

-- Q11 Delete one record from all tables
DELETE FROM Appointment WHERE AppointmentID = 1;
DELETE FROM Patient WHERE PatientID = 5001;
DELETE FROM Staff WHERE StaffID = 12;
DELETE FROM Treatment WHERE TreatmentID = 10;
DELETE FROM Department WHERE DepartmentID = 10;

-- Q12 Find the total number of days off for all staff order by least
SELECT FirstName, LastName, DaysOffTaken
FROM Staff
ORDER BY DaysOffTaken ASC;

-- Q13 Change all staff with job title “Office worker” to “Administrator”
UPDATE Staff
SET JobTitle = 'Administrator'
WHERE JobTitle = 'Office worker';

-- Q14 Set the Orthopedics department phone number to 01-7654321
UPDATE Department
SET Phone = '01-7654321'
WHERE Name = 'Orthopedics';

-- Q15 Change CEO’s name to “Michael Dean”
UPDATE Staff
SET FirstName = 'Michael', LastName = 'Dean'
WHERE JobTitle = 'CEO';

-- Q16 Show all staff working longer than 3 years
SELECT FirstName, LastName, HireDate
FROM Staff
WHERE HireDate <= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Q17 Show patient names, medical history, appointments, dates, times & treatments
SELECT p.FirstName, p.LastName, p.MedicalHistory,
       a.AppointmentDate, a.AppointmentTime,
       t.Name AS Treatment
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Treatment t ON a.TreatmentID = t.TreatmentID;

-- Q18 Count how many patients have the word 'road' in their address
SELECT COUNT(*) AS Road_Count
FROM Patient
WHERE Address LIKE '%road%' OR Address LIKE '%Road%';

-- Q19 Create a view using three tables
CREATE VIEW PatientAppointments AS
SELECT p.FirstName AS PatientFirst, p.LastName AS PatientLast,
       s.FirstName AS StaffFirst, s.LastName AS StaffLast,
       a.AppointmentDate, a.AppointmentTime
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Staff s ON a.StaffID = s.StaffID;

-- Q20 Drop all information from the Appointments table
TRUNCATE TABLE Appointment;