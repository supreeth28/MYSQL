use supreeth;
drop table theatres;

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY AUTO_INCREMENT,
    CountryName VARCHAR(100)
);
 
 CREATE TABLE Cities (
    CityID INT PRIMARY KEY AUTO_INCREMENT,
    CityName VARCHAR(100),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Theatres (
    TheatreID INT PRIMARY KEY AUTO_INCREMENT,
    TheatreName VARCHAR(100),
    CityID INT,
    SeatingCapacity INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

INSERT INTO Countries (CountryName)
VALUES 
    ('India'),
    ('United States'),
    ('United Kingdom'),
    ('Australia'),
    ('Canada');
    
    
    
    
    
    INSERT INTO Cities (CityName, CountryID)
VALUES 
    ('Mumbai', 1),
    ('Los Angeles', 1),
    ('New York', 2),
    ('Toronto', 3),
    ('Sydney', 4),
    ('London', 5);
    
    INSERT INTO Theatres (TheatreName, CityID, SeatingCapacity)
VALUES 
    ('Broadway Theatre', 1, 2000),
    ('Dolby Theatre', 2, 3400),
    ('Regal Theatre', 3, 1500),
    ('Royal Opera House', 4, 2300),
    ('Elgin Theatre', 5, 1500),
    ('State Theatre', 6, 2000);
    
    
    #List of Theatres in a Specific Country
    SELECT t.TheatreName, c.CityName, co.CountryName
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
JOIN Countries co ON c.CountryID = co.CountryID
WHERE co.CountryName = 'India';

#Count of Theatres per Country
SELECT co.CountryName, COUNT(t.TheatreID) AS TheatreCount
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
JOIN Countries co ON c.CountryID = co.CountryID
GROUP BY co.CountryName;

# Total Seating Capacity by Country
SELECT co.CountryName, SUM(t.SeatingCapacity) AS TotalSeatingCapacity
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
JOIN Countries co ON c.CountryID = co.CountryID
GROUP BY co.CountryName;
    
    
    #List of Cities with More than a Certain Number of Theatres
    SELECT c.CityName, COUNT(t.TheatreID) AS TheatreCount
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
GROUP BY c.CityName
HAVING TheatreCount > 1;

#Top 3 Countries with the Highest Seating Capacity
SELECT co.CountryName, SUM(t.SeatingCapacity) AS TotalSeatingCapacity
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
JOIN Countries co ON c.CountryID = co.CountryID
GROUP BY co.CountryName
ORDER BY TotalSeatingCapacity DESC
LIMIT 3;

#Average Seating Capacity of Theatres by Country
SELECT co.CountryName, AVG(t.SeatingCapacity) AS AverageSeatingCapacity
FROM Theatres t
JOIN Cities c ON t.CityID = c.CityID
JOIN Countries co ON c.CountryID = co.CountryID
GROUP BY co.CountryName;