-- Fixed the CREATE DATABASE typo
CREATE DATABASE StudentRecords;
USE StudentRecords;

CREATE TABLE Departments(
    DepartmentId INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(255) NOT NULL,
    DepartmentCode VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Students(
    StudentId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL, 
    Phone VARCHAR(20),
    DepartmentId INT,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId) ON DELETE SET NULL
);

CREATE TABLE Courses(
    CourseId INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(20) NOT NULL UNIQUE,
    DepartmentId INT, 
    Credits INT NOT NULL CHECK(Credits > 0),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId) ON DELETE SET NULL
);

CREATE TABLE Enrollments(
    EnrollmentId INT PRIMARY KEY AUTO_INCREMENT,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Grade DECIMAL(3,2) CHECK(Grade BETWEEN 0 AND 4.0),
    Semester VARCHAR(20) NOT NULL,
    AcademicYear YEAR NOT NULL,
    Status ENUM('Active','Deferred','Completed') DEFAULT 'Active',
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId) ON DELETE CASCADE,
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId) ON DELETE CASCADE,
    UNIQUE (StudentId, CourseId, Semester, AcademicYear)
);

INSERT INTO Departments(DepartmentName, DepartmentCode) VALUES
('Computer Science', 'CS'),
('Electrical Engineering', 'EE'),
('Business Administration', 'BA'),
('Mathematics', 'MATH'),
('Psychology', 'PSY');
SELECT * FROM Departments;

INSERT INTO Students(FirstName, LastName, DateOfBirth, Gender, Email, Phone, DepartmentId, EnrollmentDate) VALUES
('John', 'Doe', '2000-05-15', 'Male', 'john.doe@example.com', '1234567890', 1, '2020-09-01'),
('Jane', 'Smith', '2001-02-20', 'Female', 'jane.smith@example.com', '9876543210', 2, '2020-09-01'),
('Robert', 'Johnson', '1999-11-10', 'Male', 'robert.j@example.com', '5551234567', 3, '2019-09-01'),
('Emily', 'Williams', '2000-07-25', 'Female', 'emily.w@example.com', '4445678901', 1, '2020-09-01'),
('Michael', 'Brown', '2001-03-30', 'Male', 'michael.b@example.com', '3337890123', 4, '2021-01-15');
SELECT * FROM Students;

INSERT INTO Courses(CourseName, CourseCode, DepartmentId, Credits) VALUES
('Introduction to Programming', 'CS101', 1, 3),
('Database Systems', 'CS201', 1, 4),
('Circuit Theory', 'EE101', 2, 4),
('Financial Accounting', 'BA201', 3, 3),
('Calculus I', 'MATH101', 4, 4),
('General Psychology', 'PSY101', 5, 3);
SELECT * FROM Courses;

INSERT INTO Enrollments(StudentId, CourseId, EnrollmentDate, Grade, Semester, AcademicYear, Status) VALUES
(1, 1, '2020-09-01', 3.5, 'FirstSem', 2020, 'Completed'),
(1, 2, '2021-01-15', 3.7, 'SecondSem', 2021, 'Completed'),
(2, 3, '2020-09-01', 3.2, 'FirstSem', 2020, 'Completed'),
(3, 4, '2020-09-01', 3.9, 'FirstSem', 2020, 'Completed'),
(4, 1, '2020-09-01', 3.8, 'FirstSem', 2020, 'Completed'),
(4, 2, '2021-01-15', 4.0, 'SecondSem', 2021, 'Active'),
(5, 5, '2021-01-15', NULL, 'SecondSem', 2021, 'Active');
SELECT * FROM Enrollments;