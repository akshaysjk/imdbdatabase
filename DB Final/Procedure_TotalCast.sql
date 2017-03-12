--Procedure to get the total cast members in a movie
--------------------------------------------------------------
--drop procedure totalcastMembers;

create procedure totalcastMembers (@movieName varchar(50))
as 
declare @totalDirector int,
      @totalWriter int,
       @totalCelebs int,
       @totalCast int 
begin
if Not Exists(Select moviename from movie where MovieName=@movieName )
begin
select 'Movie does not exist'
end
else
begin
-- Total number of Writers
Set @totalWriter=( Select Count(mw.Writerid) from movie m inner join Movie_Bridge_Writer mw on mw.MovieId=m.MovieId where @movieName=m.MovieName
                   Group by m.moviename );
-- Total number of Directors
Set @totalDirector=(Select Count(md.directorid) from movie m inner join Director_Movie_Bridge md on m.MovieId=md.MovieId where @movieName=m.MovieName
                   Group by m.moviename );
-- Total number of Celebrities
Set @totalCelebs=(Select count(mc.celebrityID) from Movie_Bridge_Celebrity mc inner join movie m on mc.MovieId=m.MovieId where @movieName=m.MovieName
               Group by Moviename);
-- Total Cast
Set @totalCast=@totalWriter+@totalDirector+@totalCelebs;
print N'Total Writers: ' + Cast(@totalWriter as varchar(40));
print N'Total Directors: ' + Cast(@totalDirector as varchar(40));
print N'Total Celebrities: ' + Cast(@totalCelebs as varchar(40));
print N'Total Cast: ' +Cast(@totalCast as varchar(40));
end
end

exec totalcastMembers 'The Godfather'