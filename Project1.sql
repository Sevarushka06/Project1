create database Banking_Systemss
Use Banking_Systemss

Create database Banking_Systems
Use Banking_Systems

Create table Customers (
CustomerID int PRIMARY KEY IDENTITY (1,1) not null,
FullName varchar(50) not null,
DOB date,
Email nvarchar(50),
PhoneNumber varchar(20) not null,
Address varchar(200),
NationalID varchar(20),
TaxID varchar(20),
EmploymentStatus varchar(50),
AnnualIncome decimal(15,2),
CreatedAt datetime default getdate() not null,
UpdatedAt datetime default getdate()
)


Create table Accounts (
AccountID int Primary key identity(1,1) not null,
CustomerID INT foreign key references Customers(CustomerID),
AccountType varchar(50),
Check (AccountType in( 'Savings', 'Checking', 'Business' )),
Balance Decimal(15, 2),
Currency varchar(5) not null,
Status varchar(20),
BranchID INT,
CreatedDate Datetime default getdate()
)


Create table Transactions (
TransactionID int primary key not null,
AccountID int foreign key references Accounts(AccountID),
TransactionType varchar(50),
check ( TransactionType in('Deposit', 'Withdrawal', 'Transfer', 'Payment')),
Amount Decimal(15, 2),
Currency varchar(5) not null,
Date datetime default getdate(),
Status varchar(20),
ReferenceNo nvarchar(50)
)


Create table Branches (
BranchID int primary key not null,
BranchName varchar(50),
Address nvarchar(50),
City varchar(30),
State varchar(30),
Country varchar(30),
ManagerID INT foreign key references Departments(ManagerID),
ContactNumber varchar(50)
)

Create table Employees (
EmployeeID int primary key not null,
BranchID int foreign key references Branches(BranchID),
FullName varchar(50),
Position varchar(30),
Department varchar(50),
Salary decimal(15, 2),
HireDate datetime default getdate(),
Status varchar(30) not null
)

Create table CreditCards (
CardID int primary key not null,
CustomerID int foreign key references Customers(CustomerID),
CardNumber varchar(50),
CardType varchar(30),
CVV int,
ExpiryDate date,
Limit decimal(15, 2),
Status varchar(30)
)

Create table CreditCardTransactions (
TransactionID int primary key not null,
CardID int foreign key references creditCards(CardID),
Merchant varchar(30),
Amount decimal(15, 2),
Currency varchar(20),
Date date,
Status varchar(30)
)

Create table OnlineBankingUsers (
UserID int primary key not null,
CustomerID int foreign key references Customers(CustomerID),
Username nvarchar(50),
PassswordHash nvarchar(50),
LastLogin datetime
)

Create table BillPayments (
PaymentID int primary key not null,
CustomerID int foreign key references Customers(CustomerID),
BillerName varchar(50),
Amount decimal(15, 2),
Date date,
Status varchar(50)
)

Create table MobileBankingTransactions (
TransactionID int PRIMARY KEY,
CustomerID int foreign key references Customers(CustomerID),
DeviceID varchar(50),
AppVersion varchar(50),
TransactionType varchar(50),
Amount decimal(15, 2),
Date date
)


Create table Loans ( 
LoanID int PRIMARY KEY not null,
CustomerID int foreign key references Customers(CustomerID) not null,
LoanType varchar(50),
check (LoanType in ('Mortgage', 'Personal', 'Auto', 'Business')),
Amount decimal(15, 2) not null,
InterestRate decimal(4,2),
StartDate date not null,
EndDate date,
Status varchar(50)
)

Create table LoanPayments (
PaymentID int Primary key not null,
LoanID int foreign key references Loans(LoanID),
AmountPaid decimal(15, 2),
PaymentDate date,
RemainingBalance decimal(10, 2)
)

Create table CreditScores (
CustomerID int foreign key references Customers(CustomerID),
CreditScore decimal(10, 2),
UpdatedAt datetime
)

Create table DebCollection (
DebtID int primary key not null,
CustomerID int Foreign key references Customers(CustomerID),
AmountDue decimal(15, 2),
DueDate date,
CollectorAssigned varchar(50)
)

Create table DebtCollection (
DebtID int PRIMARY KEY not null,
CustomerID int FOREIGN KEY references Customers(CustomerID),
AmountDue decimal(10, 2),
DueDate date,
CollectorAssigned varchar(50)
)

Create table KYC (
KYCID int PRIMARY KEY not null,
CustomerID int FOREIGN KEY references Customers(CustomerID),
DocumentType varchar(50),
DocumentNumber int,
VerifiedBy nvarchar(40) 
)

Create table FraudDetection (
FraudID int Primary key not null,
CustomerID int foreign key references customers(CustomerID),
TransactionID int not null,
RiskLevel int,
Check (RiskLevel in (1, 2, 3)),
ReportedDate Date
)

Create table AML (
CaseID int Primary key not null,
CustomerID int foreign key references Customers(CustomerID),
CaseType varchar(50),
Status varchar(50),
InvestigatorID int
)

Create table RegulatoryReports (
ReportID int PRIMARY KEY not null,
ReportType varchar(50),
SubmissionDate date
)

Create table Departments (
DepartmentID int not null,
ManagerID int Primary key not null,
DepartmentName varchar(50)
)

Create table Salaries (
SalaryID decimal(15,2) Primary key not null,
EmployeeID int Foreign key references Employees(EmployeeID),
BaseSalary decimal(10, 2) not null,
Bonus decimal(10,2),
Deductions decimal(10, 2),
PaymentDate date
)

Create table EmployeeAttendance (
AttendanceID int PRIMARY KEY not null,
EmployeeID int foreign key references Employees(EmployeeID),
CheckInTime datetime, 
CheckOutTime datetime,
TotalHours varchar(5)
)

Create table Investments (
InvestmentID int PRIMARY KEY not null,
CustomerID int foreign key references Customers(CustomerID),
InvestmentType varchar(50),
Amount decimal(20, 2),
ROI decimal(15, 2),
MaturityDate date
)

Create table StockTradingAccounts (
AccountID int	PRIMARY KEY,
CustomerID int foreign key references Customers(CustomerID),
BrokerageFirm varchar(50),
TotalInvested decimal(15,2),
CurrentValue decimal(15, 2)
)

Create table ForeignExchange (
FXID int PRIMARY KEY not null,
CustomerID int foreign key references Customers(CustomerID),
CurrencyPair nvarchar(30),
ExchangeRate decimal(6, 2) not null,
AmountExchanged decimal(10, 2) 
)

Create table InsurancePolicies (
PolicyID int Primary key not null,
CustomerID int foreign key references Customers(CustomerID),
InsuranceType varchar(50),
PremiumAmount decimal(10, 2),
CovergeAmount decimal(10, 2)
)

Create table Claims (
ClaimID int Primary key not null,
PolicyID int Foreign key references InsurancePolicies(PolicyID),
ClaimAmount decimal(15, 2),
Status varchar(30),
FiledDate date
)

Create table UserAccessLogs (
LogID int Primary key,
UserID int,
ActionType varchar(30),
TimeStamp datetime
)

Create table CyberSecurityIncidents (
IncidentID int Primary key not null,
AffectedSystem varchar(50),
ReportedDate datetime,
ResolutionStatus varchar(50)
)

Create table Merchants (
MerchantID int Primary key,
MerchantName varchar(50),
Industry varchar(30),
Location varchar(50),
CustomerID int foreign key references Customers(CustomerID)
)

Create table MerchantTransactions (
TransactionID int Primary key not null,
MerchantID int foreign key references Merchants(MerchantID),
Amount decimal(10, 2),
PaymentMethod varchar(30),
Date date
)

-----------------------------------------------------------------------------------------------
 
 -- 1. Top 3 Customers with the highest Total Balance Across all Accounts

INSERT INTO Customers VALUES
('Michael Johnson', '1985-04-12', 'michael.johnson@gmail.com', '998901234567', '12 Park Avenue, Tashkent', 'AA1234567', 'TX10001', 'Employed', 75000.00, 2025-02-21 , 2025-02-27 ),
('Sarah Williams', '1990-08-25', 'sarah.williams@yahoo.com', '998907654321', '45 Amir Temur Street, Tashkent', 'BB2345678', 'TX10002', 'Self-Employed', 68000.00, 2025-03-22 , 2025-03-27),
('David Brown', '1978-02-10', 'david.brown@outlook.com', '998909876543', '78 Chilanzar District, Tashkent', 'CC3456789', 'TX10003', 'Employed', 92000.00, 2025-04-19, 2025-04-27 ),
('Emily Davis', '1995-11-03', 'emily.davis@gmail.com', '998903456789', '22 Yunusabad Street, Tashkent', 'DD4567890', 'TX10004', 'Unemployed', 15000.00, 2025-02-15, 2025-02-27 ),
('James Wilson', '1982-06-18', 'james.wilson@gmail.com', '998908765432', '9 Mustaqillik Avenue, Samarkand', 'EE5678901', 'TX10005', 'Employed', 88000.00, 2025-05-09, 2025-05-15),
('Olivia Martinez', '1993-09-14', 'olivia.martinez@yahoo.com', '998901112233', '17 Registan Street, Samarkand', 'FF6789012', 'TX10006', 'Student', 12000.00, 2025-06-20 , 2025-07-27 ),
('Daniel Anderson', '1987-01-29', 'daniel.anderson@bankmail.com', '998902223344', '33 Navoi Street, Bukhara', 'GG7890123', 'TX10007', 'Employed', 64000.00, 2025-07-21, 2025-07-27 ),
('Sophia Taylor', '1992-03-11', 'sophia.taylor@gmail.com', '998903334455', '18 Mirzo Ulugbek Street, Tashkent', 'HH8901234', 'TX10008', 'Employed', 72000.00, 2025-02-11, 2025-02-12 ),
('William Moore', '1980-07-20', 'william.moore@yahoo.com', '998904445566', '55 Shahrisabz Street, Samarkand', 'II9012345', 'TX10009', 'Self-Employed', 83000.00, 2025-03-18, 2025-03-20 ),
('Isabella Jackson', '1996-05-09', 'isabella.jackson@gmail.com', '998905556677', '12 Old City Road, Bukhara', 'JJ0123456', 'TX10010', 'Student', 10000.00, 2025-04-22, 2025-04-25),
('Liam White', '1988-01-14', 'liam.white@outlook.com', '998906667788', '21 Independence Street, Tashkent', 'KK1239876', 'TX10011', 'Employed', 67000.00, 2025-02-28, 2025-03-01),
('Mia Harris', '1994-06-30', 'mia.harris@gmail.com', '998907778899', '7 Silk Road Avenue, Samarkand', 'LL4566543', 'TX10012', 'Employed', 54000.00, 2025-03-15, 2025-03-20),
('Noah Martin', '1983-09-05', 'noah.martin@yahoo.com', '998908889900', '42 Central Market Street, Bukhara', 'MM7893210', 'TX10013', 'Self-Employed', 91000.00, 2025-04-01, 2025-04-05),
('Charlotte Lee', '1991-12-19', 'charlotte.lee@gmail.com', '998909990011', '16 New City Avenue, Tashkent', 'NN3214567', 'TX10014', 'Employed', 60000.00, 2025-05-04, 2025-05-10 ),
('Benjamin Walker', '1986-04-27', 'ben.walker@outlook.com', '998900111222', '88 Registan Square, Samarkand', 'OO6549873', 'TX10015', 'Employed', 79000.00, 2025-06-02, 2025-06-06),
('Amelia Hall', '1997-08-16', 'amelia.hall@gmail.com', '998901223344', '14 Ark Fortress Road, Bukhara', 'PP9871234', 'TX10016', 'Student', 9000.00, 2025-07-07 , 2025-07-07),
('Lucas Allen', '1984-02-22', 'lucas.allen@yahoo.com', '998902334455', '31 Navoi Avenue, Tashkent', 'QQ7412589', 'TX10017', 'Employed', 71000.00, 2025-03-10, 2025-03-15),
('Harper Young', '1993-10-11', 'harper.young@gmail.com', '998903445566', '27 Silk Road Street, Samarkand', 'RR8523697', 'TX10018', 'Self-Employed', 63000.00, 2025-02-20 , 2025-02-22),
('Henry King', '1981-05-15', 'henry.king@bankmail.com', '998904556677', '40 Historic Center, Bukhara', 'SS9631478', 'TX10019', 'Employed', 85000.00, 2025-05-17, 2025-05-20),
('Evelyn Wright', '1995-01-02', 'evelyn.wright@gmail.com', '998905667788', '10 Amir Temur Avenue, Tashkent', 'TT1597532', 'TX10020', 'Employed', 58000.00, 2025-06-11, 2025-06-15 ),
('Alexander Scott', '1989-07-07', 'alex.scott@yahoo.com', '998906778899', '66 University Street, Samarkand', 'UU4561237', 'TX10021', 'Self-Employed', 72000.00, 2025-07-01, 2025-07-03),
('Abigail Green', '1998-03-29', 'abigail.green@gmail.com', '998907889900', '25 Old Town Road, Bukhara', 'VV9517534', 'TX10022', 'Student', 8000.00, 2025-04-12, 2025-04-15),
('Daniel Adams', '1985-09-17', 'daniel.adams@gmail.com', '998908990011', '71 Independence Avenue, Tashkent', 'WW7531594', 'TX10023', 'Employed', 76000.00, 2025-05-18, 2025-05-22),
('Ella Baker', '1992-11-21', 'ella.baker@yahoo.com', '998909101112', '13 Silk Road Center, Samarkand', 'XX1593574', 'TX10024', 'Employed', 61000.00, 2025-02-05, 2025-02-07),
('Matthew Nelson', '1983-06-08', 'matt.nelson@outlook.com', '998900212223', '91 Historic Plaza, Bukhara', 'YY7532581', 'TX10025', 'Self-Employed', 94000.00, 2025-03-03, 2025-03-05),
('Scarlett Carter', '1996-04-14', 'scarlett.carter@gmail.com', '998901323334', '5 Amir Temur Street, Tashkent', 'ZZ8524569', 'TX10026', 'Student', 11000.00, 2025-06-10, 2025-06-12 ),
('Jack Mitchell', '1987-02-25', 'jack.mitchell@yahoo.com', '998902434445', '19 Registan Road, Samarkand', 'AB9513574', 'TX10027', 'Employed', 69000.00, 2025-04-08, 2025-04-10),
('Victoria Perez', '1994-07-30', 'victoria.perez@gmail.com', '998903545556', '29 Ark Fortress Street, Bukhara', 'BC3571594', 'TX10028', 'Employed', 56000.00, 2025-05-25, 2025-05-28),
('Samuel Roberts', '1981-12-12', 'sam.roberts@bankmail.com', '998904656667', '37 Independence Square, Tashkent', 'CD2587413', 'TX10029', 'Self-Employed', 82000.00,2025-07-02 , 2025-07-05),
('Grace Turner', '1993-05-05', 'grace.turner@gmail.com', '998905767778', '48 Silk Road Avenue, Samarkand', 'DE6547891', 'TX10030', 'Employed', 64000.00, 2025-06-14, 2025-06-18);

INSERT INTO Accounts(CustomerID, AccountType, Balance, Currency, Status, BranchID)
VALUES
(1, 'Savings', 12000.50, 'USD', 'Active', 1),
(2, 'Checking', 8500.75, 'USD', 'Active', 2),
(3, 'Business', 45000.00, 'USD', 'Active', 3),
(4, 'Savings', 2300.00, 'USD', 'Active', 4),
(5, 'Checking', 15200.90, 'USD', 'Active', 5),
(6, 'Savings', 980.00, 'USD', 'Active', 6),
(7, 'Business', 22000.00, 'USD', 'Active', 7),
(8, 'Savings', 13400.25, 'USD', 'Active', 1),
(9, 'Checking', 8900.00, 'USD', 'Active', 2),
(10, 'Savings', 1200.00, 'USD', 'Active', 3),
(11, 'Checking', 7600.40, 'USD', 'Active', 4),
(12, 'Savings', 5400.60, 'USD', 'Active', 5),
(13, 'Business', 60000.00, 'USD', 'Active', 6),
(14, 'Savings', 4500.00, 'USD', 'Active', 7),
(15, 'Checking', 9700.10, 'USD', 'Active', 1),
(16, 'Savings', 800.00, 'USD', 'Active', 2),
(17, 'Business', 27000.00, 'USD', 'Active', 3),
(18, 'Savings', 3100.20, 'USD', 'Active', 4),
(19, 'Checking', 14200.00, 'USD', 'Active', 5),
(20, 'Savings', 5200.00, 'USD', 'Active', 6),
(21, 'Business', 35000.00, 'USD', 'Active', 7),
(22, 'Savings', 950.50, 'USD', 'Active', 1),
(23, 'Checking', 11300.00, 'USD', 'Active', 2),
(24, 'Savings', 6400.00, 'USD', 'Active', 3),
(25, 'Business', 72000.00, 'USD', 'Active', 4),
(26, 'Savings', 1800.00, 'USD', 'Active', 5),
(27, 'Checking', 9100.00, 'USD', 'Active', 6),
(28, 'Savings', 4700.00, 'USD', 'Active', 7),
(29, 'Business', 52000.00, 'USD', 'Active', 1),
(30, 'Savings', 6900.00, 'USD', 'Active', 2);


Select top 3 c.CustomerID, c.FullName, Sum(a.Balance) as TotalBalance
from Customers c
Join Accounts a 
on a.customerID = c.CustomerID
Group by c.CustomerID, c.FullName
Order by TotalBalance Desc
----------------------------------------------------------------------------------------------------------------------------------

--Customers who have more than 1 active Loan  



INSERT INTO Loans VALUES
(1, 1, 'Mortgage', 150000.00, 6.50, '2025-01-10', '2045-01-10', 'Active'),
(2, 2, 'Personal', 20000.00, 11.00, '2025-02-15', '2027-02-15', 'Active'),
(3, 3, 'Auto', 35000.00, 8.50, '2025-03-12', '2030-03-12', 'Active'),
(4, 4, 'Business', 120000.00, 7.20, '2025-04-01', '2035-04-01', 'Active'),
(5, 5, 'Personal', 15000.00, 10.50, '2025-02-20', '2027-02-20', 'Closed'),
(6, 6, 'Auto', 28000.00, 9.00, '2025-03-05', '2029-03-05', 'Active'),
(7, 7, 'Mortgage', 200000.00, 6.80, '2025-05-10', '2045-05-10', 'Active'),
(8, 8, 'Business', 95000.00, 7.10, '2025-01-18', '2032-01-18', 'Active'),
(9, 9, 'Personal', 18000.00, 12.00, '2025-02-25', '2026-02-25', 'Closed'),
(10, 10, 'Auto', 40000.00, 8.90, '2025-03-22', '2031-03-22', 'Active'),
(11, 11, 'Business', 110000.00, 7.40, '2025-04-15', '2033-04-15', 'Active'),
(12, 12, 'Mortgage', 175000.00, 6.60, '2025-06-01', '2045-06-01', 'Active'),
(13, 13, 'Personal', 22000.00, 11.50, '2025-02-02', '2027-02-02', 'Active'),
(14, 14, 'Auto', 30000.00, 8.30, '2025-03-14', '2029-03-14', 'Closed'),
(15, 15, 'Business', 130000.00, 7.00, '2025-05-20', '2034-05-20', 'Active'),
(16, 16, 'Personal', 12000.00, 10.80, '2025-01-30', '2026-01-30', 'Active'),
(17, 17, 'Mortgage', 210000.00, 6.75, '2025-04-11', '2045-04-11', 'Active'),
(18, 18, 'Auto', 33000.00, 8.70, '2025-02-19', '2030-02-19', 'Active'),
(19, 19, 'Business', 105000.00, 7.35, '2025-03-27', '2033-03-27', 'Closed'),
(20, 20, 'Personal', 17000.00, 11.20, '2025-05-03', '2027-05-03', 'Active'),
(21, 21, 'Mortgage', 190000.00, 6.55, '2025-06-18', '2045-06-18', 'Active'),
(22, 22, 'Auto', 26000.00, 8.40, '2025-01-09', '2029-01-09', 'Active'),
(23, 23, 'Business', 98000.00, 7.25, '2025-02-11', '2032-02-11', 'Active'),
(24, 24, 'Personal', 14000.00, 10.90, '2025-03-06', '2026-03-06', 'Closed'),
(25, 25, 'Mortgage', 230000.00, 6.70, '2025-04-30', '2045-04-30', 'Active'),
(26, 26, 'Auto', 36000.00, 8.60, '2025-05-21', '2031-05-21', 'Active'),
(27, 27, 'Business', 125000.00, 7.15, '2025-06-14', '2034-06-14', 'Active'),
(28, 28, 'Personal', 16000.00, 11.30, '2025-02-08', '2027-02-08', 'Active'),
(29, 29, 'Mortgage', 205000.00, 6.65, '2025-03-19', '2045-03-19', 'Active'),
(30, 30, 'Auto', 31000.00, 8.80, '2025-04-25', '2030-04-25', 'Closed');

Update Loans
Set CustomerID = 7
where LoanID = 8

Update Loans
Set CustomerID = 21
where LoanID = 25

Select c.CustomerID, c.FullName, count(l.loanID) as ActiveLoans
From Customers c
Join Loans l
on c.CustomerID = l.CustomerID
Where l.Status = 'Active'
Group by c.CustomerID, c.FullName
Having Count(l.LoanID) > 1
---------------------------------------------------------------------------------------------------------------------------
--  Transactions That Were Flagged as Fraudulent                                                                                                 

INSERT INTO Transactions VALUES
(1, 1, 'Deposit', 5000.00, 'USD', 2025-02-22, 'Completed', 'REF001'),
(2, 1, 'Withdrawal', 2000.00, 'USD', 2025-02-23, 'Completed', 'REF002'),
(3, 2, 'Deposit', 7000.00, 'USD', 2025-03-23, 'Completed', 'REF003'),
(4, 2, 'Transfer', 3000.00, 'USD', 2025-03-24, 'Completed', 'REF004'),
(5, 3, 'Deposit', 15000.00, 'USD', 2025-04-20, 'Completed', 'REF005'),
(6, 3, 'Withdrawal', 5000.00, 'USD', 2025-04-21, 'Completed', 'REF006'),
(7, 4, 'Deposit', 2500.00, 'USD', 2025-02-16, 'Completed', 'REF007'),
(8, 4, 'Payment', 1200.00, 'USD', 2025-02-17, 'Completed', 'REF008'),
(9, 5, 'Deposit', 21000.00, 'USD', 2025-05-10, 'Completed', 'REF009'),
(10, 5, 'Transfer', 5000.00, 'USD', 2025-05-11, 'Completed', 'REF010'),
(11, 6, 'Deposit', 1200.00, 'USD', 2025-06-21, 'Completed', 'REF011'),
(12, 6, 'Payment', 500.00, 'USD', 2025-06-22, 'Completed', 'REF012'),
(13, 7, 'Deposit', 27000.00, 'USD', 2025-07-22, 'Completed', 'REF013'),
(14, 7, 'Withdrawal', 7000.00, 'USD', 2025-07-23, 'Completed', 'REF014'),
(15, 8, 'Deposit', 18000.00, 'USD', 2025-02-12, 'Completed', 'REF015'),
(16, 8, 'Payment', 4000.00, 'USD', 2025-02-13, 'Completed', 'REF016'),
(17, 9, 'Deposit', 30000.00, 'USD', 2025-03-19, 'Completed', 'REF017'),
(18, 9, 'Transfer', 10000.00, 'USD', 2025-03-20, 'Completed', 'REF018'),
(19, 10, 'Deposit', 2500.00, 'USD', 2025-04-23, 'Completed', 'REF019'),
(20, 10, 'Withdrawal', 1000.00, 'USD', 2025-04-24, 'Completed', 'REF020'),
(21, 11, 'Deposit', 19500.00, 'USD', 2025-03-01, 'Completed', 'REF021'),
(22, 11, 'Transfer', 5000.00, 'USD', 2025-03-02, 'Completed', 'REF022'),
(23, 12, 'Deposit', 21000.00, 'USD', 2025-03-16, 'Completed', 'REF023'),
(24, 12, 'Withdrawal', 8000.00, 'USD', 2025-03-17, 'Completed', 'REF024'),
(25, 13, 'Deposit', 44000.00, 'USD', 2025-04-02, 'Completed', 'REF025'),
(26, 13, 'Payment', 10000.00, 'USD', 2025-04-03, 'Completed', 'REF026'),
(27, 14, 'Deposit', 26000.00, 'USD', 2025-05-05, 'Completed', 'REF027'),
(28, 14, 'Withdrawal', 5000.00, 'USD', 2025-05-06, 'Completed', 'REF028'),
(29, 15, 'Deposit', 37000.00, 'USD', 2025-06-03, 'Completed', 'REF029'),
(30, 15, 'Transfer', 15000.00, 'USD', 2025-06-04, 'Completed', 'REF030'),
(31, 16, 'Deposit', 1200.00, 'USD', 2025-01-30, 'Completed', 'REF031'),
(32, 16, 'Payment', 500.00, 'USD', 2025-01-31, 'Completed', 'REF032'),
(33, 17, 'Deposit', 210000.00, 'USD', 2025-04-11, 'Completed', 'REF033'),
(34, 17, 'Withdrawal', 50000.00, 'USD', 2025-04-12, 'Completed', 'REF034'),
(35, 18, 'Deposit', 33000.00, 'USD', 2025-02-19, 'Completed', 'REF035');


INSERT INTO FraudDetection VALUES
(1, 1, 1, 1, '2025-02-23'),
(2, 1, 2, 2, '2025-02-24'),
(3, 2, 3, 1, '2025-03-24'),
(4, 2, 4, 2, '2025-03-25'),
(5, 3, 5, 3, '2025-04-21'),
(6, 3, 6, 2, '2025-04-22'),
(7, 4, 7, 1, '2025-02-17'),
(8, 4, 8, 3, '2025-02-18'),
(9, 5, 9, 2, '2025-05-11'),
(10, 5, 10, 1, '2025-05-12'),
(11, 6, 11, 1, '2025-06-22'),
(12, 6, 12, 2, '2025-06-23'),
(13, 7, 13, 3, '2025-07-23'),
(14, 7, 14, 2, '2025-07-24'),
(15, 8, 15, 1, '2025-02-13'),
(16, 8, 16, 2, '2025-02-14'),
(17, 9, 17, 3, '2025-03-20'),
(18, 9, 18, 3, '2025-03-21'),
(19, 10, 19, 2, '2025-04-24'),
(20, 10, 20, 1, '2025-04-25'),
(21, 11, 21, 2, '2025-03-02'),
(22, 11, 22, 3, '2025-03-03'),
(23, 12, 23, 1, '2025-03-17'),
(24, 12, 24, 2, '2025-03-18'),
(25, 13, 25, 3, '2025-04-03'),
(26, 13, 26, 2, '2025-04-04'),
(27, 14, 27, 1, '2025-05-06'),
(28, 14, 28, 2, '2025-05-07'),
(29, 15, 29, 3, '2025-06-04'),
(30, 15, 30, 2, '2025-06-05')

Select t.TransactionID, t.AccountID, t.Amount, t.Date, f.risklevel
from transactions t
join FraudDetection f on t.transactionID = f.transactionID
where f.risklevel in (3, 2)

------------------------------------------------------------------------------------------------------

--Total Loan Amount Issuead Per Branch


INSERT INTO Departments VALUES
(1, 101, 'Retail Banking'),
(2, 102, 'Corporate Banking'),
(3, 103, 'Loans & Credit'),
(4, 104, 'Digital Banking'),
(5, 105, 'Risk & Compliance'),
(6, 106, 'Investments & Treasury'),
(7, 107, 'Insurance'),
(8, 108, 'HR & Payroll'),
(9, 109, 'Customer Service'),
(10, 110, 'IT & Cybersecurity');


INSERT INTO Branches VALUES
(1, 'Tashkent Central', '12 Park Avenue', 'Tashkent', 'Tashkent', 'Uzbekistan', 101, '998901234567'),
(2, 'Amir Temur Branch', '45 Amir Temur Street', 'Tashkent', 'Tashkent', 'Uzbekistan', 102, '998907654321'),
(3, 'Chilanzar Branch', '78 Chilanzar District', 'Tashkent', 'Tashkent', 'Uzbekistan', 103, '998909876543'),
(4, 'Yunusabad Branch', '22 Yunusabad Street', 'Tashkent', 'Tashkent', 'Uzbekistan', 104, '998903456789'),
(5, 'Samarkand Main', '9 Mustaqillik Avenue', 'Samarkand', 'Samarkand', 'Uzbekistan', 105, '998908765432'),
(6, 'Registan Branch', '17 Registan Street', 'Samarkand', 'Samarkand', 'Uzbekistan', 106, '998901112233'),
(7, 'Navoi Branch', '33 Navoi Street', 'Bukhara', 'Bukhara', 'Uzbekistan', 107, '998902223344'),
(8, 'Bukhara Central', '21 Bukhara Avenue', 'Bukhara', 'Bukhara', 'Uzbekistan', 108, '998903334455'),
(9, 'Fergana Main', '10 Fergana Street', 'Fergana', 'Fergana', 'Uzbekistan', 109, '998904445566'),
(10, 'Andijan Branch', '7 Andijan Lane', 'Andijan', 'Andijan', 'Uzbekistan', 110, '998905556677');


Select b.BranchID, b.BranchName, Sum(l.Amount) as TotalAmount
From loans l
Join Accounts a
on l.CustomerID = a.CustomerID
Join Branches b
on a.BranchID = b.BranchID
Group by b.BranchID, b.BranchName

-------------------------------------------------------------------------------------------------------------------------

-- Customers Making Transactions from Different Countries Within 10 Minutes

SELECT t1.AccountID
FROM Transactions t1
JOIN Transactions t2 ON t1.AccountID = t2.AccountID
   AND t1.TransactionID <> t2.TransactionID
   AND t1.Currency <> t2.Currency
   AND ABS(DATEDIFF(MINUTE, t1.Date, t2.Date)) <= 10
GROUP BY t1.AccountID;




