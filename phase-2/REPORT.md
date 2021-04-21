# SOEN 363 - Phase-2

## Q3 - BigData with SQL

### (a) - Dataset: Grocery Sales

**_You can find the data on Kaggle, at the following address:
<https://www.kaggle.com/codemysteries/salesdb>_**

The data set that was chosen is a reasonably sized sales dataset for groceries
sold in various cities throughout the entire United States of America. There
are 7 files in total in the dataset:

- `categories.csv`
- `cities.csv`
- `countries.csv`
- `customers.csv`
- `employes.csv`
- `products.csv`
- `sales.csv`
- **_TOTAL SIZE: `753.22MB`_**

### (b) - Creating the database: PostgreSQL

#### **_DATABASE:_** `PostgreSQL v13.2`

<br>

#### **_ENTITY RELATION DIAGRAM (ERD):_**

![ERD](./assets/erd.png)

<br />

#### **_DATA DEFINITION (DDL):_**

```sql
-- Countries
CREATE TABLE Countries (
    CountryID INTEGER NOT NULL,
    CountryName VARCHAR(50),
    CountryCode VARCHAR(2),
    PRIMARY KEY (CountryID)
);

-- Cities
CREATE TABLE Cities (
    CityID INTEGER NOT NULL,
    CityName VARCHAR(50),
    Zipcode INTEGER,
    CountryID INTEGER NOT NULL,
    PRIMARY KEY (CityID),
    FOREIGN KEY (CountryID) REFERENCES countries(CountryID)
);

-- Customers
CREATE TABLE Customers (
    CustomerID INTEGER NOT NULL,
    FirstName VARCHAR(50),
    MiddleInitial VARCHAR(1),
    LastName VARCHAR(50),
    CityID INTEGER NOT NULL,
    Address VARCHAR(255),
    PRIMARY KEY (CustomerID),
    FOREIGN KEY (CityID) REFERENCES cities(CityID)
);

-- Categories
CREATE TABLE Categories (
    CategoryID INTEGER NOT NULL,
    CategoryName VARCHAR(50),
    PRIMARY KEY (CategoryID)
);

-- Products
CREATE TABLE Products (
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

-- Employees
CREATE TABLE Employes (
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

-- Sales
CREATE TABLE Sales (
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
```

### (c) - Loading the data

**_Docker Image:_** <https://hub.docker.com/repository/docker/obonobo/soen363-phase-2-postgres>

For reproducability, a Docker image was created containing PostgreSQL v13.2. All
the data has been preloaded into the Docker image. You can pull the image and
examine the database by executing the following in your terminal (requires
`docker` to be installed):

```bash
# Pull the latest docker image
docker pull obonobo/soen363-phase-2-postgres:latest

# Spin up an instance of postgres
docker run -d \
    -p 5432:5432 \
    -e PGDATA=/data \
    -e POSTGRES_DB=soen363 \
    -e POSTGRES_USER=admin \
    -e POSTGRES_PASSWORD=admin123 \
    obonobo/soen363-phase-2-postgres:latest
```

Alternatively, you can use the `docker-compose.yml` file packaged alongside this
report. This will spin up 3 containers (PostgreSQL, PGAdmin, MongoDB):
`docker-compose up -d`

The data required a few steps of processing before it was successfully loaded
into Postgres. All the scripts used for preprocessing and data cleaning have
been included alongside this report. Check out the `scripts/` dir for the source
code.

### (d) - Reports

10 SQL queries were created to extract interesting pieces of information about
grocery sales in the US.

#### 1. How much do discounts effect sales?

This query reports the average quantity of items sold, ordered by the discount
(if any) that has been applied to the item. As expected, items with discounts,
on average, tend to have higher sales.

```sql
SELECT discount, AVG(quantity) FROM Sales
WHERE discount IN (
  SELECT distinct discount
  FROM Sales
  ORDER BY discount DESC)
OR discount IS NULL
GROUP BY discount;
```

#### 2. Which employee has sold the most seafood?

```sql
SELECT
  count(*) AS numsales,
  firstname,
  lastname,
  birthdate,
  cityname,
  zipcode,
  countryname
FROM Sales s
INNER JOIN products p ON s.productid = p.productid
INNER JOIN categories c ON p.categoryid = c.categoryid
INNER JOIN employes e ON s.salespersonid = e.employeeid
INNER JOIN cities ci ON e.cityid = ci.cityid
INNER JOIN countries co ON ci.countryid = co.countryid
WHERE categoryname = 'Seafood'
GROUP BY firstname, lastname, birthdate, cityname, zipcode, countryname
ORDER BY numsales DESC
LIMIT 1;
```

#### 3. What are the top-selling item categories in Tucson, Arizona?

```sql
SELECT ca.categoryname,count(ca.categoryid)
FROM customers cu
INNER JOIN sales s  ON cu.customerid = s.customerid
INNER JOIN cities c ON cu.cityid = c.cityid
INNER JOIN products p ON s.productid = p.productid
INNER JOIN categories ca ON p.categoryid = ca.categoryid
WHERE c.cityname = 'Tucson'
GROUP BY ca.categoryid
ORDER BY count(ca.categoryid) DESC
```

#### 4.

#### 5.

#### 6.

#### 7.

#### 8.

#### 9.

#### 10.

### (e)

## Q4 - NoSQL Databases

### (a)

### (b)

### (c)

### (d)

### (e)

#### 1.

#### 2.

#### 3.

#### 4.

#### 5.

#### 6.

#### 7.

#### 8.

#### 9.

#### 10.

### (f)

### (g)
