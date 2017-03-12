--Selecting Movie and its gross collection across globe
SELECT
    (CASE WHEN GROUPING(MovieName) = 1 THEN 'Total' ELSE MovieName END) AS MOVIENAME,
    SUM(USA) AS USA,
    SUM(INDIA) AS INDIA,
    SUM(UK) AS UK,
    SUM(USA + INDIA + UK) AS Total
    FROM
    (
        SELECT
            MovieName,
-- Selecting Cases based on the CountryName
            (CASE WHEN CountryName = 'USA' THEN TotalCollection ELSE 0 END) AS USA,
            (CASE WHEN CountryName = 'INDIA' THEN TotalCollection ELSE 0 END) AS INDIA,
            (CASE WHEN CountryName = 'UK' THEN TotalCollection ELSE 0 END) AS UK
            
            FROM
            (
                -- Original input of selecting Movie CountryName and TotalCollection
                SELECT
                    MovieName,
                    CountryName,SUM(TotalCollection) AS TotalCollection
                    FROM TOTALCOLLECTIONVIEW GROUP BY MovieName,CountryName
            ) i
    ) j
    GROUP BY MovieName WITH ROLLUP

