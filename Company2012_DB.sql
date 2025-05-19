-- 1. Display all the employees Data.
SELECT * FROM Employee;

-- 2. Display the employee First name, last name, Salary and Department number.
SELECT Fname, Lname, Salary, Dno FROM Employee;

-- 3. Display all the projects names, locations and the department which is responsible about it.
SELECT Pname, Plocation, Dnum FROM Project;

-- 4. Display each employee full name and his annual commission in an ANNUAL COMM column.
SELECT Fname + ' ' + Lname AS FullName, (Salary * 12) * 0.1 AS [ANNUAL COMM] FROM Employee;

-- 5. Display the employees Id, name who earns more than 1000 LE monthly.
SELECT SSN, Fname + ' ' + Lname AS FullName FROM Employee WHERE Salary > 1000;

-- 6. Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, Fname + ' ' + Lname AS FullName FROM Employee WHERE Salary * 12 > 10000;

-- 7. Display the names and salaries of the female employees.
SELECT Fname + ' ' + Lname AS FullName, Salary FROM Employee WHERE Sex = 'Female';

-- 8. Display each department id, name which managed by a manager with id equals 968574.
SELECT Dnum, Dname FROM Departments WHERE MGRSSN = 968574;

-- 9. Display the ids, names and locations of the projects which controlled with department 10.
SELECT Pnumber, Pname, Plocation FROM Project WHERE Dnum = 10;

-- 10. Insert your personal data to the employee table as a new employee in department number 30.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES ('Samir', 'AlBulushi', 911111, '2001-08-17', 'Seeb', 'Male', 1000000000, 112233, 30);

-- 11. Insert another employee with personal data your friend in department 30 without salary or supervisor number.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Dno)
VALUES ('Ishaq', 'AlBulushi', 12345, '2000-02-02', 'AlAmarat', 'Male', 30);

-- 12. Upgrade your salary by 20 % of its last value.
UPDATE Employee SET Salary = Salary * 1.2 WHERE SSN = 102672;
