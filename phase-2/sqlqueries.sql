--average quantity of items sold orders by the discount of said items

SELECT discount, AVG(quantity) FROM sales
WHERE discount in (SELECT distinct discount FROM sales
ORDER BY discount DESC) OR discount is null
GROUP BY discount;



--information of the employee who has sold the biggest amount of seafood.

SELECT count(*) AS numsales, firstname, lastname, birthdate, cityname, zipcode, countryname
FROM sales s 
INNER JOIN products p ON s.productid = p.productid
INNER JOIN categories c ON p.categoryid = c.categoryid
INNER JOIN employes e ON s.salespersonid = e.employeeid
INNER JOIN cities ci ON e.cityid = ci.cityid
INNER JOIN countries co ON ci.countryid = co.countryid
WHERE categoryname = 'Seafood'
GROUP BY firstname, lastname, birthdate, cityname, zipcode, countryname
ORDER BY numsales DESC
LIMIT 1;



--Groups top selling to lowest selling categories for a given city name (Justin)
SELECT ca.categoryname,count(ca.categoryid)
FROM customers cu  
INNER JOIN sales s  ON cu.customerid = s.customerid 
INNER JOIN cities c ON cu.cityid = c.cityid 
INNER JOIN products p ON s.productid = p.productid 
INNER JOIN categories ca ON p.categoryid = ca.categoryid
WHERE c.cityname = 'Tucson' 
GROUP BY ca.categoryid
ORDER BY count(ca.categoryid) DESC

-- Displays amount of chocolate sales per city                  (Justin)
SELECT count(s.salesid), ci.cityname
FROM sales s
INNER JOIN products p ON s.productid = p.productid 
INNER JOIN customers c ON s.customerid = c.customerid 
INNER JOIN cities ci on c.cityid = ci.cityid
WHERE p.productname like '%Chocolate%'
GROUP BY ci.cityname 
ORDER BY count(s.salesid) DESC

-- Displays whether an order is expired or good               (Justin)
SELECT s.salesid,p.productname ,p.modifydate,p.vitalitydays,s.salesdate, (DATE_PART('day', s.salesdate- p.modifydate):: integer) as daydiff,
CASE WHEN s.salesdate > p.modifydate THEN 'Good'
ELSE 'Expired'
END AS FOODSTATUS
FROM products p
INNER JOIN sales s ON s.productid = p.productid 
WHERE s.salesdate IS NOT NULL AND p.vitalitydays IS NOT NULL AND p.vitalitydays IS NOT NULL 
LIMIT 20


--DIsplays amount of customers per city , highest to lowest         (Justin)
SELECT count(c.cityid),c.cityid, ci.cityname
FROM customers c 
INNER JOIN cities ci ON c.cityid = ci.cityid
GROUP BY c.cityid,ci.cityname 
ORDER BY count(c.customerid) DESC


--Top 5 people to have made the most wine purchases         (Justin)
SELECT count(s.productid), c.firstname ,c.middleinitial, c.lastname
FROM sales s
INNER JOIN products p ON s.productid = p.productid 
INNER JOIN customers c ON s.customerid = c.customerid 
WHERE p.productname like '%Wine%'
GROUP BY s.productid,c.firstname,c.middleinitial, c.lastname
ORDER BY count(s.productid) DESC
LIMIT 5


--Millennial Employees                                       (Justin)
SELECT * 
FROM employes e
WHERE e.birthdate BETWEEN '1981-01-01 00:00:00' AND '1996-12-31 23:59:59'

--Gen x Employees                                             (Justin)
SELECT * 
FROM employes e
WHERE e.birthdate BETWEEN '1965-01-01 00:00:00' AND '1980-12-31 23:59:59'

-- Employees hired after 2016 till the current date             (Justin)
SELECT * 
FROM employes e
WHERE e.hiredate BETWEEN '2016-01-01 00:00:00' AND now()



SELECT p.productname ,p.modifydate,p.vitalitydays,s.salesdate,DATEDIFF(D,DATE(p.modifydate),DATE(s.salesdate)) AS days
FROM products p
INNER JOIN sales s ON s.productid = p.productid 
WHERE s.salesdate IS NOT NULL AND p.vitalitydays IS NOT NULL AND p.vitalitydays IS NOT NULL 
LIMIT 5





-- same but in mongo

db.sales.aggregate(
    [
        {
            $group:{
                _id: "$Discount",
                avgAmount:{ $avg: "$Quantity"}
            }
        }
     ]
)


-- A mongo query to return info for a product purchased in a certain month, its quantity, and how much discount was applied to it.
-- Useful for tracking requirements for loyalty rewards in the future
db.sales.find({$and: [{ ProductID : 47},{ Quantity : { $gt : 20 }}, {Discount:{$gte : 0.2}},{SalesDate:{$regex: '^2018-01'}}]})