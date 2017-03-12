--Trigger for User_Movie_Bridge table which will update Average User rating in Movie table once an entry is inserted in User_Movie_Bridge table

CREATE TRIGGER update_avg_rating ON User_Movie_Bridge
AFTER INSERT,UPDATE
AS
BEGIN
DECLARE @movieId int,
@userRating float,
@tempRating float,
@finalRating float,
@countUsers int

--get the values from the inserted table into @movieId and @userRating
Select @movieId=movieId,@userRating=UserRating from inserted;

Select @tempRating = AverageUserRating from Movie where MovieId=@movieId;
Select @countUsers=count(MovieId) from User_Movie_Bridge where MovieId=@movieId;

set @finalRating=((@tempRating*(@countUsers-1))+@userRating)/@countUsers;
--updating the total number of episodes for a particular season in Season table

update Movie set AverageUserRating = @finalRating where MovieId=@movieId;

PRINT N'-------------Movie table has been successfully updated.------------------------';

end;

--Before inserting the data in the User_Movie_Bridge table
select* from Movie where MovieId=16;

--inserting data into User_Movie_Bridge which will update the AverageUserRating in Movie Table
insert into User_Movie_Bridge values(1,16,7.6);

select * from Movie where MovieId=16;

