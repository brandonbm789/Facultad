SELECT city.Name, country.Name, country.Region, country.GovernmentForm FROM city INNER JOIN country ON city.CountryCode = country.Code ORDER BY city.Population DESC LIMIT 10;

SELECT country.Name, city.Name, country.Population FROM country LEFT JOIN city ON city.ID = country.Capital ORDER BY country.Population ASC LIMIT 10;

SELECT country.Name, country.Continent, countrylanguage.Language FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'T';

SELECT country.Name, city.Name FROM country LEFT JOIN city ON city.ID = country.Capital ORDER BY country.Population DESC LIMIT 20;

SELECT city.* , countrylanguage.Language FROM city LEFT JOIN countrylanguage ON countrylanguage.CountryCode  = city.CountryCode AND countrylanguage.IsOfficial = 'T' ORDER BY city.Population  DESC;

(SELECT * FROM country ORDER BY country.Population DESC LIMIT 10) UNION (SELECT * FROM country WHERE country.Population > 100 ORDER BY country.Population ASC LIMIT 10);

(SELECT country.* FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Language = 'English') 
INTERSECT 
(SELECT country.* FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Language = 'French');

(SELECT country.* FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.Language = 'French' AND countrylanguage.Percentage > 0)
EXCEPT
(SELECT country.* FROM country INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.Language = 'Spanish' AND countrylanguage.Percentage > 0);

SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';

SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina';
