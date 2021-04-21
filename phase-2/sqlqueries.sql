--average quantity of items sold orders by the discount of said items

SELECT discount, AVG(quantity) FROM sales
WHERE discount in (SELECT distinct discount FROM sales
ORDER BY discount DESC) OR discount is null
GROUP BY discount;

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



--Groups top selling to lowest selling categories for a given city id (Justin )

SELECT ca.categoryid,ca.categoryname,count(ca.categoryid)
FROM customers cu  
INNER JOIN sales s  ON cu.customerid = s.customerid 
INNER JOIN cities c ON cu.cityid = c.cityid 
INNER JOIN products p ON s.productid = p.productid 
INNER JOIN categories ca ON p.categoryid = ca.categoryid
WHERE c.cityid = 32 
GROUP BY ca.categoryid 
ORDER BY count(ca.categoryid) DESC

