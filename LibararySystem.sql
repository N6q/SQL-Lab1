-- Library Management System - DQL & DML Tasks
CREATE DATABASE LibraryManagementSystemDB
USE LibraryManagementSystemDB;

----------------------------------------- CREATE TABLEs -------------------------------------------------
CREATE TABLE Members (
    MemberID INT IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(20),
    MembershipStartDate DATE NOT NULL,
	CONSTRAINT PK_MemberID PRIMARY KEY (MemberID)
);

CREATE TABLE Libraries (
    LibraryID INT IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    ContactNumber NVARCHAR(20),
    EstablishedYear INT CHECK (EstablishedYear >= 1900),
	CONSTRAINT PK_LibraryID PRIMARY KEY (LibraryID)
);

CREATE TABLE Books (
    BookID INT IDENTITY(1,1),
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(255) NOT NULL,
    Genre NVARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Price DECIMAL(10, 2) CHECK (Price > 0),
    IsAvailable BIT DEFAULT 1,
    ShelfLocation NVARCHAR(50),
    LibraryID INT NOT NULL,
	CONSTRAINT PK_BookID PRIMARY KEY (BookID),
    CONSTRAINT FK_LibraryID FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1),
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status NVARCHAR(20) DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
	CONSTRAINT PK_LoanID PRIMARY KEY (LoanID),
    CONSTRAINT FK_MemberID FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_BookID FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) CHECK (Amount > 0),
    PaymentMethod NVARCHAR(50) NOT NULL,
    LoanID INT NOT NULL,
	CONSTRAINT PK_PaymentID PRIMARY KEY (PaymentID),
    CONSTRAINT FK_LoanID FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Staffs (
    StaffID INT IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    ContactNumber NVARCHAR(20),
    LibraryID INT NOT NULL,
	CONSTRAINT PK_StaffID PRIMARY KEY (StaffID),
    CONSTRAINT FK_LibraryID_staff FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(255) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
	CONSTRAINT PK_ReviewID PRIMARY KEY (ReviewID),
    CONSTRAINT FK_MemberID_rev FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_BookID_rev FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE 
);

----------------------------------------- Insert data-------------------------------------------------
-- Insert Members
INSERT INTO Members (FullName, Email, PhoneNumber, MembershipStartDate) VALUES
('John Doe', 'john1@example.com', '555-1010', '2025-01-01'),
('Jane Smith', 'jane1@example.com', '555-2020', '2025-02-15'),
('Tom Brown', 'tom1@example.com', '555-3030', '2025-03-10'),
('Lisa White', 'lisa1@example.com', '555-4040', '2025-04-05'),
('Mark Green', 'mark1@example.com', '555-5050', '2025-05-01'),
('Nancy Blue', 'nancy1@example.com', '555-6060', '2025-06-01');

-- Insert Libraries
INSERT INTO Libraries (Name, Location, ContactNumber, EstablishedYear) VALUES
('Central Library', '123 Main St', '555-1234', 2001),
('East Branch', '456 East Ave', '555-5678', 2010),
('West Branch', '789 West Blvd', '555-9012', 2015);

-- Insert Books
INSERT INTO Books (ISBN, Title, Genre, Price, ShelfLocation, LibraryID) VALUES
('978-1-1111-1111-1', 'The Great Gatsby', 'Fiction', 15.99, 'A1', 1),
('978-1-2222-2222-2', 'Data Structures', 'Reference', 45.00, 'B2', 2),
('978-1-3333-3333-3', 'Children Stories', 'Children', 10.00, 'C3', 3),
('978-1-4444-4444-4', 'Advanced SQL', 'Reference', 55.00, 'D4', 1),
('978-1-5555-5555-5', 'Python Basics', 'Non-fiction', 25.00, 'E5', 2),
('978-1-6666-6666-6', 'Java Programming', 'Non-fiction', 30.00, 'F6', 3);


-- Insert Loans
INSERT INTO Loans (LoanDate, DueDate, Status, MemberID, BookID) VALUES
('2025-05-01', '2025-05-10', 'Returned', 1, 1),
('2025-05-03', '2025-05-13', 'Overdue', 2, 2),
('2025-05-05', '2025-05-15', 'Issued', 3, 3),
('2025-05-07', '2025-05-17', 'Issued', 4, 4),
('2025-05-09', '2025-05-19', 'Returned', 5, 5),
('2025-05-11', '2025-05-21', 'Overdue', 6, 6);

-- Insert Payments
INSERT INTO Payments (PaymentDate, Amount, PaymentMethod, LoanID) VALUES
('2025-05-12', 5.00, 'Cash', 2),
('2025-05-13', 10.00, 'Credit Card', 3),
('2025-05-14', 7.00, 'Cash', 5),
('2025-05-15', 12.00, 'Credit Card', 6);

-- Insert Staff
INSERT INTO Staffs (FullName, Position, ContactNumber, LibraryID) VALUES
('Alice Johnson', 'Librarian', '555-7070', 1),
('Bob Roberts', 'Assistant', '555-8080', 2),
('Charlie Brown', 'Manager', '555-9090', 3),
('Diana Prince', 'Archivist', '555-1011', 1);

-- Insert Reviews
INSERT INTO Reviews (Rating, Comments, ReviewDate, MemberID, BookID) VALUES
(5, 'Amazing read!', '2025-05-10', 1, 1),
(4, 'Very informative.', '2025-05-11', 2, 2),
(3, 'Good for beginners.', '2025-05-12', 3, 3),
(2, 'Not what I expected.', '2025-05-13', 4, 4),
(4, 'Worth the price.', '2025-05-14', 5, 5),
(5, 'Highly recommended!', '2025-05-15', 6, 6);


-- 1. Display all book records.
SELECT * FROM Books;

-- 2. Show each book’s title, genre, and availability.
SELECT Title, Genre, IsAvailable FROM Books;

-- 3. Display all members' names, email, and membership start date.
SELECT FullName, Email, MembershipStartDate FROM Members;

-- 4. Display each book’s title and price with alias “BookPrice”.
SELECT Title, Price AS BookPrice FROM Books;

-- 5. List books priced above 250 LE.
SELECT Title, Price FROM Books WHERE Price > 250;

-- 6. List members who joined before 2023.
SELECT FullName, MembershipStartDate FROM Members WHERE MembershipStartDate < '2023-01-01';

-- 7. Display names and roles of staff working in 'Zamalek Branch'.
SELECT FullName, Position FROM Staffs INNER JOIN Libraries ON Staffs.LibraryID = Libraries.LibraryID WHERE Libraries.Name = 'Zamalek Branch';

-- 8. Display branch name managed by staff ID = 3008.
SELECT Libraries.Name FROM Libraries INNER JOIN Staffs ON Libraries.LibraryID = Staffs.LibraryID WHERE Staffs.StaffID = 3008;

-- 9. List titles and authors of books available in branch ID = 2.
SELECT Title, ISBN FROM Books WHERE LibraryID = 2 AND IsAvailable = 1;

-- 10. Insert yourself as a member with ID = 405 and register to borrow book ID = 1011.
INSERT INTO Members (MemberID, FullName, Email, PhoneNumber, MembershipStartDate) VALUES (405, 'Your Name', 'you@example.com', '555-9999', GETDATE());
INSERT INTO Loans (LoanDate, DueDate, MemberID, BookID) VALUES (GETDATE(), DATEADD(DAY, 14, GETDATE()), 405, 1011);

-- 11. Insert a member with NULL email and phone.
INSERT INTO Members (FullName, Email, PhoneNumber, MembershipStartDate) VALUES ('No Contact', NULL, NULL, GETDATE());

-- 12. Update the return date of your loan to today.
UPDATE Loans SET ReturnDate = GETDATE() WHERE MemberID = 405 AND BookID = 1011;
