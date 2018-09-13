	/*****************************************************************************************/
	/* This script demonstrates CREATE TABLES, INSERT VALUES, UPDATE RECORDS AND ALTER TABLE */						 
	/*****************************************************************************************/


/* Set context to master */

	USE Master;

/* Drop database */
-- NOTE: This clause is not part of the lesson.  If an old copy of the HR database exists, this statement will clear it out so I can start the demonstration with a fresh slate

	IF EXISTS (SELECT * FROM Master.dbo.sysdatabases WHERE NAME = 'HR_System')
	DROP DATABASE HR_System;
	GO

/* Create the HR Database */

	CREATE DATABASE HR_System;
	GO 


/* Use the HR Database */
	USE HR_System;
	GO

/*Create Table for Departments*/
CREATE TABLE Departments 
(
	Dept_ID Int Primary Key,
	Dept_name varchar(50) unique not null,

);

/*Inserting data in Departments table*/
Insert into Departments
Values
(23,'Sales'),
(12,'IS'),
(10,'Director'),
(17,'HR');

/*Creating Employee table*/
CREATE TABLE Employees 
	(
		EmpID	Int	PRIMARY KEY,
		SSN varchar(11) unique,
		FName	Varchar(128),
		LName	Varchar(128),
		DOB	Date,
		Emp_Address Varchar(128),
		Dept_ID Int References Departments(Dept_ID),
		Emp_start_date Date not null,
		Emp_end_date Date,
		Designation varchar(50),
		STATUS varchar(50) NOT NULL,
		Basic_sal int,
		Incentives int );
	
/* ALtering Employee table to add Manager_ID */		
		Alter Table Employees 
		Add Manager_ID Int References Employees(EmpID);

		select * from Departments
/*Inserting data in employee table*/
Insert into Employees
Values 
(1,373-878-799,'Ted','Jackson','03/12/1990','Carlsbad',23,'01/27/2015',Null,'Salesperson','Employed',2000,1000,Null),
(2,123-765-100,'Amy','Andersson','03/12/1990','LA',12,'03/21/2009','03/23/2017','Consultant','Resigned',3500,1500,Null),
(56,457-324-231,'Kristina','Becker','03/12/1990','Texas',10,'04/06/2003',Null,'Director','Employed',5000,1400,Null),
(5,680-735-876,'Bob','Briggs','03/12/1990','Beaverton',23,'05/13/2000',Null,'Manager','Employed',2000,1000,Null),
(9,321-787-345,'Alex','Jones','03/12/1990','Utah',23,'12/04/2015','05/09/2013','Salesperson','Resigned',4000,1200,Null),
(10,096-137-908,'Jason','Waterman','03/12/1990','Freemont',12,'06/10/2018',Null,'Senior Engineer','In Transition',5000,1400,Null),
(39,547-380-778,'North','Moriarity','03/12/1990','Washington',23,'01/31/2010',Null,'Salesperson','Employed',5000,1400,Null),
(32,124-708-234,'Smith','Web','03/12/1990','Seattle',12,'11/27/2007',Null,'Manager','Employed',5000,1400,Null),
(21,784-257-132,'Ben','Rounds','03/12/1990','Dallas',17,'02/23/2010',Null,'HR Manager','Employed',3500,1500,Null),
(12,543-248-981,'Karl','Feuth','03/12/1990','Carlsbad',17,'01/09/2011',Null,'HR','Employed',3500,1500,Null);

/*Adding Values for Manager_ID*/

Update Employees
SET Manager_ID=5
WHERE DEPT_ID=23;

Update Employees
SET Manager_ID=32
WHERE DEPT_ID=12;

Update Employees
SET Manager_ID=10
WHERE EMPID in (5,32);

Update Employees
SET Manager_ID=21
WHERE Designation='HR'

/*Create the Training table*/
CREATE TABLE Training_Courses
(
	Course_ID int Primary Key,
	Course_name varchar(50) unique not null,
	Course_Description varchar(50),
	Course_Type varchar(50),
	Course_Duration int
);

/*Inserting into Training Table*/
INSERT INTO Training_Courses
Values
(123,'JAVA','Technical Training','Basic Level','2'),
(231,'Softskills','Softskills Training','Basic Level','1'),
(241,'SALES and Marketing','Sales Training','Basic Level','3'),
(121,'Python','Technical Training','Basic Level','2'),
(144,'Softskills-A','Softskills Training','Basic Level','1');

/* Create the Skillset table*/
CREATE TABLE Skills 
(
	Skill_ID int Primary key,
	Skill_Name varchar(50) unique not null,
	Skill_Description varchar(50)
);

/*Inserting in Skillset table*/

INSERT INTO Skills
VALUES
(1,'JAVA','Technical'),
(2,'Selling Insurance','SALES'),
(3,'PYTHON','Technical'),
(4,'Management','Managing People'),
(5,'HR','HR');

/*Create the Reviews table*/

CREATE TABLE Reviews
(
	Review_ID int Primary Key,
	Review_Desc varchar(50),
	Review_Date Date,
	Score Int,
	EmpID Int REFERENCES Employees(EmpID)
);

/*Insert into Review Table*/

INSERT INTO REVIEWS
VALUES
(101,'High Performer','04/27/2018',5,1),
(102,'Needs Improvement','02/12/2018',3,56),
(103,'Low Performer','04/27/2017',5,39),
(104,'Can do Better','04/27/2017',1,9),
(105,'High Performer','04/27/2018',2,2),
(106,'Needs Improvement','02/12/2018',5,5),
(107,'Low Performer','04/27/2017',5,32),
(108,'Can do Better','04/27/2017',3,12),
(109,'Low Performer','04/27/2017',1,10),
(110,'Can do Better','04/27/2017',3,21);


/*Create the Emp_Skillset table*/

CREATE TABLE Emp_Skills
(
	EmpID int references Employees(EmpID),
	Skill_ID int references Skills(Skill_ID),
	Skill_Level int,
	Experience int,
	Certification bit,
	Primary Key(EmpID,Skill_ID)
);


/*Insert into Emp_Skillset table*/
INSERT INTO Emp_Skills
VALUES
(1,2,4,9,4),
(2,4,2,4,1),
(5,2,1,1,0),
(9,2,4,10,2),
(10,3,2,3,1),
(12,4,1,9,1),
(21,4,1,9,1),
(10,1,1,9,1),
(39,2,1,9,1),
(56,4,1,9,1),
(32,4,1,9,1);

/*Create the Emp_Train table*/
CREATE TABLE Trainings_Attended 
(
	EmpID int references Employees(EmpID),
	Course_ID int references Training_Courses(Course_ID),
	Train_start Date not null,
	Train_end Date,
	Primary Key (EmpID,Course_ID)
);

/*Insert into Emp_Train table*/
INSERT INTO Trainings_Attended
VALUES
(1,241,'06/10/2016','09/10/2016'),
(56,144,'01/23/2007','03/24/2007'),
(39,241,'12/10/2016','02/10/2017'),
(9,241,'11/21/2014','01/21/2015'),
(2,121,'06/02/2009','08/02/2009'),
(5,144,'04/15/2011','05/15/2011'),
(32,144,'08/11/2012','09/11/2012'),
(12,144,'04/21/2013','05/21/2013'),
(21,144,'04/05/2008','05/05/2008'),
(10,123,'01/12/2018','03/12/2018');


/*Create the Emp_Salary table*/
CREATE TABLE Salaries 
(
	Salary_ID int Primary Key,
	EmpID int references Employees(EmpID) not null,
	Salary_level varchar(50),
	Salary_Range int ,
	Incentive_Range int);

/*INSERT into Salary table*/
INSERT INTO Salaries
VALUES
(1234,1,'L1',10000,3000),
(2341,2,'L2',10000,3000),
(1243,5,'L4',10000,3000),
(6790,9,'L1',10000,3000),
(3452,10,'L3',10000,3000),
(3920,12,'L4',10000,3000),
(6491,21,'L4',10000,3000),
(4568,32,'L4',10000,3000),
(1212,39,'L2',10000,3000),
(1111,56,'L2',10000,3000);


/**************** Creating Indexex *********************/
create index ndx_skills_name on Skills(Skill_name);
create index ndx_employee_SSN on Employees(SSN);

