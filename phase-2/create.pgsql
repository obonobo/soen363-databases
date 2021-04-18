CREATE TABLE IF NOT EXISTS countries(
    CountryID INTEGER NOT NULL,
    CountryName VARCHAR(50),
    CountryCode VARCHAR(2),
    PRIMARY KEY (CountryID)
);

CREATE TABLE IF NOT EXISTS cities(
    CityID INTEGER NOT NULL,
    CityName VARCHAR(50),
    Zipcode INTEGER,
    CountryID INTEGER NOT NULL,
    PRIMARY KEY (CityID),
    FOREIGN KEY (CountryID) REFERENCES countries(CountryID)
);

CREATE TABLE IF NOT EXISTS customers(
    CustomerID INTEGER NOT NULL,
    FirstName VARCHAR(50),
    MiddleInitial VARCHAR(1),
    LastName VARCHAR(50),
    CityID INTEGER NOT NULL,
    Address VARCHAR(255),
    PRIMARY KEY (CustomerID),
    FOREIGN KEY (CityID) REFERENCES cities(CityID)
);

CREATE TABLE IF NOT EXISTS categories(
    CategoryID INTEGER NOT NULL,
    CategoryName VARCHAR(50),
    PRIMARY KEY (CategoryID)
);

CREATE TABLE IF NOT EXISTS products(
    ProductID INTEGER NOT NULL,
    ProductName VARCHAR(255),
    Price REAL,
    CategoryID INTEGER NOT NULL,
    Class VARCHAR(50),
    ModifyDate TIMESTAMP,
    Resistant VARCHAR(20),
    IsAllergic VARCHAR(10),
    VitalityDays INTEGER,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID)
);

CREATE TABLE IF NOT EXISTS employes(
    EmployeeID INTEGER NOT NULL,
    FirstName VARCHAR(50),
    MiddleInitial VARCHAR(1),
    LastName VARCHAR(50),
    BirthDate TIMESTAMP,
    Gender VARCHAR(1),
    CityID INTEGER NOT NULL,
    HireDate TIMESTAMP,
    Address VARCHAR(255),
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (CityID) REFERENCES cities(CityID)
);

CREATE TABLE IF NOT EXISTS sales(
    SalesID INTEGER NOT NULL,
    SalesPersonID INTEGER NOT NULL,
    CustomerID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER,
    Discount REAL,
    TotalPrice REAL,
    SalesDate TIMESTAMP,
    TransactionNumber VARCHAR(20),
    PRIMARY KEY (SalesID),
    FOREIGN KEY (SalesPersonID) REFERENCES employes(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
