USE SmartClinic;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

SHOW TABLES;

INSERT INTO Departments (DepartmentName, Location)
VALUES
('Cardiology', 'First Floor'),
('Neurology', 'Second Floor'),
('Pediatrics', 'Third Floor'),
('Orthopedics', 'Ground Floor'),
('Dermatology', 'Second Floor');

SELECT * FROM Departments;

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

SHOW TABLES;

INSERT INTO Doctors
(FirstName, LastName, Specialty, Phone, Email, DepartmentID)
VALUES
('Ahmed', 'Al-Harbi', 'Cardiologist', '0501111111', 'ahmed@clinic.com', 1),
('Sara', 'Al-Qahtani', 'Neurologist', '0502222222', 'sara@clinic.com', 2),
('Mona', 'Al-Otaibi', 'Pediatrician', '0503333333', 'mona@clinic.com', 3),
('Faisal', 'Al-Dossari', 'Orthopedic Surgeon', '0504444444', 'faisal@clinic.com', 4),
('Lina', 'Al-Shammari', 'Dermatologist', '0505555555', 'lina@clinic.com', 5);

SELECT * FROM Doctors;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(200)
);

SHOW TABLES;

INSERT INTO Patients
(FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address)
VALUES
('Ali', 'Al-Harbi', '1999-04-15', 'Male', '0551111111', 'ali@example.com', 'Jeddah'),
('Fatimah', 'Al-Qahtani', '2001-08-21', 'Female', '0552222222', 'fatimah@example.com', 'Riyadh'),
('Omar', 'Al-Otaibi', '1995-12-10', 'Male', '0553333333', 'omar@example.com', 'Dammam'),
('Nora', 'Al-Dossari', '2003-03-18', 'Female', '0554444444', 'nora@example.com', 'Jeddah'),
('Yousef', 'Al-Shammari', '1998-09-30', 'Male', '0555555555', 'yousef@example.com', 'Makkah');

SELECT * FROM Patients;

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status VARCHAR(30),
    PatientID INT,
    DoctorID INT,
    FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);

SHOW TABLES;

INSERT INTO Appointments
(AppointmentDate, AppointmentTime, Status, PatientID, DoctorID)
VALUES
('2026-08-01', '09:00:00', 'Scheduled', 1, 1),
('2026-08-01', '10:00:00', 'Completed', 2, 2),
('2026-08-02', '11:30:00', 'Scheduled', 3, 3),
('2026-08-03', '01:00:00', 'Cancelled', 4, 4),
('2026-08-04', '02:30:00', 'Scheduled', 5, 5);

SELECT * FROM Appointments;

CREATE TABLE Medicines (
    MedicineID INT PRIMARY KEY AUTO_INCREMENT,
    MedicineName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50),
    Manufacturer VARCHAR(100)
);

SHOW TABLES;

INSERT INTO Medicines
(MedicineName, Dosage, Manufacturer)
VALUES
('Paracetamol','500 mg','Pfizer'),
('Ibuprofen','400 mg','Abbott'),
('Amoxicillin','250 mg','GSK'),
('Vitamin D','1000 IU','Nature Made'),
('Omeprazole','20 mg','AstraZeneca');

SELECT * FROM Medicines;

CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    MedicineID INT,
    PrescriptionDate DATE,
    FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID),
    FOREIGN KEY (MedicineID)
        REFERENCES Medicines(MedicineID)
);

SHOW TABLES;

INSERT INTO Prescriptions
(PatientID, DoctorID, MedicineID, PrescriptionDate)
VALUES
(1,1,1,'2026-08-01'),
(2,2,2,'2026-08-01'),
(3,3,3,'2026-08-02'),
(4,4,4,'2026-08-03'),
(5,5,5,'2026-08-04');

SHOW TABLES;

SELECT * FROM Prescriptions;

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    TreatmentDescription VARCHAR(200),
    TreatmentDate DATE,
    FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);

SHOW TABLES;

INSERT INTO Treatments
(PatientID, DoctorID, TreatmentDescription, TreatmentDate)
VALUES
(1,1,'Heart Checkup','2026-08-01'),
(2,2,'Brain MRI Review','2026-08-01'),
(3,3,'Vaccination','2026-08-02'),
(4,4,'Knee Examination','2026-08-03'),
(5,5,'Skin Allergy Treatment','2026-08-04');

SELECT * FROM Treatments;

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID)
);

SHOW TABLES;

INSERT INTO Payments
(PatientID, Amount, PaymentDate, PaymentMethod)
VALUES
(1,250.00,'2026-08-01','Cash'),
(2,500.00,'2026-08-01','Credit Card'),
(3,150.00,'2026-08-02','Cash'),
(4,300.00,'2026-08-03','Debit Card'),
(5,450.00,'2026-08-04','Credit Card');

SELECT * FROM Payments;

SELECT
Patients.FirstName,
Patients.LastName,
Doctors.FirstName AS DoctorFirstName,
Doctors.LastName AS DoctorLastName,
Appointments.AppointmentDate
FROM Appointments
JOIN Patients
ON Appointments.PatientID = Patients.PatientID
JOIN Doctors
ON Appointments.DoctorID = Doctors.DoctorID;

SELECT FirstName, LastName
FROM Patients
WHERE PatientID IN
(
SELECT PatientID
FROM Appointments
WHERE DoctorID = 1
);

SELECT PaymentMethod,
COUNT(*) AS TotalPayments
FROM Payments
GROUP BY PaymentMethod;

UPDATE Patients
SET Phone='0559999999'
WHERE PatientID=1;

SELECT * FROM Patients;

DELETE FROM Medicines
WHERE MedicineID=5;

SELECT * FROM Medicines;

CREATE VIEW AppointmentDetails AS
SELECT
Appointments.AppointmentID,
Patients.FirstName,
Patients.LastName,
Doctors.FirstName AS DoctorFirstName,
Doctors.LastName AS DoctorLastName,
Appointments.AppointmentDate
FROM Appointments
JOIN Patients
ON Appointments.PatientID=Patients.PatientID
JOIN Doctors
ON Appointments.DoctorID=Doctors.DoctorID;

SELECT * FROM AppointmentDetails;

DELIMITER $$

CREATE TRIGGER CheckPaymentAmount
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
IF NEW.Amount < 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Payment amount cannot be negative';
END IF;
END$$

DELIMITER ;

SELECT COUNT(*) AS TotalDepartments FROM Departments;

USE SmartClinic;

SELECT COUNT(*) AS TotalDepartments FROM Departments;

SELECT COUNT(*) AS TotalDoctors FROM Doctors;

SELECT COUNT(*) AS TotalPatients FROM Patients;

SELECT COUNT(*) AS TotalAppointments FROM Appointments;

SELECT COUNT(*) AS TotalMedicines FROM Medicines;

SELECT COUNT(*) AS TotalPrescriptions FROM Prescriptions;

SELECT COUNT(*) AS TotalTreatments FROM Treatments;

SELECT COUNT(*) AS TotalPayments FROM Payments;

USE SmartClinic;

SHOW TABLES;

SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Medicines;
SELECT * FROM Prescriptions;
SELECT * FROM Treatments;
SELECT * FROM Payments;

DESCRIBE Departments;
DESCRIBE Doctors;
DESCRIBE Patients;
DESCRIBE Appointments;
DESCRIBE Medicines;
DESCRIBE Prescriptions;
DESCRIBE Treatments;
DESCRIBE Payments;

USE SmartClinic;

SELECT PatientID, FirstName, LastName, Gender
FROM Patients;

SELECT
    Appointments.AppointmentID,
    Patients.FirstName,
    Patients.LastName,
    Doctors.FirstName AS DoctorFirstName,
    Doctors.LastName AS DoctorLastName,
    Appointments.AppointmentDate
FROM Appointments
JOIN Patients
    ON Appointments.PatientID = Patients.PatientID
JOIN Doctors
    ON Appointments.DoctorID = Doctors.DoctorID;
    
    SELECT FirstName, LastName
FROM Patients
WHERE PatientID IN (
    SELECT PatientID
    FROM Appointments
);

SELECT DoctorID, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID;

UPDATE Patients
SET Phone = '0501234567'
WHERE PatientID = 1;

SELECT PatientID, FirstName, LastName, Phone
FROM Patients
WHERE PatientID = 1;

DELETE FROM Medicines
WHERE MedicineID = 5;

INSERT INTO Medicines (MedicineID, MedicineName, Manufacturer, Price)
VALUES (5, 'Paracetamol', 'Saudi Pharma', 15.00);

SELECT * FROM Medicines;

SELECT COUNT(*) AS TotalMedicines
FROM Medicines;

CREATE OR REPLACE VIEW AppointmentDetails AS
SELECT
    Appointments.AppointmentID,
    Patients.FirstName AS PatientFirstName,
    Patients.LastName AS PatientLastName,
    Doctors.FirstName AS DoctorFirstName,
    Doctors.LastName AS DoctorLastName,
    Appointments.AppointmentDate
FROM Appointments
JOIN Patients
    ON Appointments.PatientID = Patients.PatientID
JOIN Doctors
    ON Appointments.DoctorID = Doctors.DoctorID;
    
    SELECT * FROM AppointmentDetails;
    
    DELIMITER //

CREATE TRIGGER CheckPaymentAmount
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.Amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount must be greater than zero';
    END IF;
END//

DELIMITER ;

SHOW TRIGGERS;

SELECT COUNT(*) AS TotalMedicines
FROM Medicines;