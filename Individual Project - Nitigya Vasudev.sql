--Filtering and Sorting
SELECT facility_id, city, postal_code
FROM Facility_Address
WHERE province = 'bc'
ORDER BY city ASC

-- Counting Facilities in Each City:
SELECT fa.city, COUNT(f.facility_id) AS facility_count
FROM Facility f
INNER JOIN Facility_address fa ON f.facility_id = fa.facility_id
GROUP BY fa.city

-- Top 5 Cities with the Most Facilities:
SELECT fa.city, COUNT(fa.city) AS facility_count
FROM Facility_address fa
GROUP BY fa.city
ORDER BY facility_count DESC;

-- Facilities in a Specific City

SELECT facility_name, provider
FROM Facility
WHERE facility_id IN (
    SELECT facility_id
    FROM Facility_Address
    WHERE city = 'whitehorse'
)

-- Facilities in Provinces with Fewer than 5 Facilities:

SELECT f.facility_id, f.facility_name, fa.province
FROM Facility f
JOIN Facility_address fa ON f.facility_id = fa.facility_id
WHERE fa.province IN (
    SELECT fa.province
    FROM Facility_address fa
    GROUP BY fa.province
    HAVING COUNT(fa.facility_id) < 5
)

--Classify Cities Based on Facility Count Using Subquery and CASE:

SELECT 
    f.facility_id,
    f.facility_name,
    f.provider,
    fa.city,
    fa.province,
    CASE 
        WHEN fa.province = 'ab' THEN 'Alberta'
        WHEN fa.province = 'bc' THEN 'British Columbia'
        WHEN fa.province = 'qc' THEN 'Quebec'
        ELSE 'Other Province'
    END AS province_full_name,
    (SELECT COUNT(*) 
     FROM Facility_Address 
     WHERE city = fa.city) AS facilities_in_city
FROM 
    Facility f
JOIN 
    Facility_Address fa ON f.facility_id = fa.facility_id;

-- CREATE VIEW
CREATE VIEW SimpleFacilityView AS
SELECT 
    f.facility_id, 
    f.facility_name, 
    fa.city, 
    fa.province
FROM 
    Facility f
JOIN 
    Facility_Address fa 
ON 
    f.facility_id = fa.facility_id;
                         
SELECT * FROM  SimpleFacilityView;
