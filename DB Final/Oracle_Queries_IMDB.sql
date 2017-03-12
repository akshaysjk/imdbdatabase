-----------------
select Count(g."GenreId")  GenreCount,COUNT(m."MovieId")  MovieCount,m."MovieName", g."GenreName" 
 from "Genre" g  join "Movie_Genre_BT" mg
on mg."GenreId"=g."GenreId" join "Movie" m
on m."MovieId"=mg."MovieId"
GROUP BY Cube(g."GenreName",m."MovieName");

-------------------
select * from ON_TONIGHT;

--------------