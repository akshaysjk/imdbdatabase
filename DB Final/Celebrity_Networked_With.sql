SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION get_Co_Celebrity_count 
(
    -- Add the parameters for the function here
    @celebrityId int
)
RETURNS INT
AS
BEGIN
    DECLARE @count int
    DECLARE @finalCount int
select @count= count(TVShowId) from Celebrity_Bridge_TvShow cbt where CelebrityId=@celebrityId;
with c1 as(
Select TVShowId,COUNT(Celebrity_Bridge_TvShow.CelebrityId)
As TotalCelebrity from Celebrity_Bridge_TvShow Group by TVShowId)
,c2 as (select TvShowID from Celebrity_Bridge_TvShow where CelebrityId=@celebrityId)

select @finalCount = sum(c1.TotalCelebrity)-@count from c1 JOIN c2 on c2.TVShowId=c1.TVShowId;

    -- Return the result of the function
    RETURN @finalCount;

END
GO

--Calling the function

USE [IMDB]
GO

SELECT [dbo].[get_Co_Celebrity_count]  (
  5) as Total_Networked_With;
GO 
