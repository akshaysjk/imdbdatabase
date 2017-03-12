--Function to get the date difference from the current date in the format of Year, Months and Days
select * from News;
--Code:

CREATE FUNCTION dbo.GetDateDifference
(
--taking From date and To date as input parameters
  @FromDate DATETIME, @ToDate DATETIME
)
RETURNS NVARCHAR(100)
AS
BEGIN
   DECLARE @Years INT, @Months INT, @Days INT, @tmpFromDate DATETIME
   
   --Storing Difference in Years format in @Years

   SET @Years = DATEDIFF(YEAR, @FromDate, @ToDate)
    - (CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, @FromDate, @ToDate),
             @FromDate) > @ToDate THEN 1 ELSE 0 END) 
   
   --Storing Difference in Months format in @Months

   SET @tmpFromDate = DATEADD(YEAR, @Years , @FromDate)
   SET @Months =  DATEDIFF(MONTH, @tmpFromDate, @ToDate)
    - (CASE WHEN DATEADD(MONTH,DATEDIFF(MONTH, @tmpFromDate, @ToDate),
             @tmpFromDate) > @ToDate THEN 1 ELSE 0 END) 
   
   --Storing Difference in Days format in @Days

   SET @tmpFromDate = DATEADD(MONTH, @Months , @tmpFromDate)
   SET @Days =  DATEDIFF(DAY, @tmpFromDate, @ToDate)
    - (CASE WHEN DATEADD(DAY, DATEDIFF(DAY, @tmpFromDate, @ToDate),
             @tmpFromDate) > @ToDate THEN 1 ELSE 0 END) 
  
  
   RETURN 'Years: ' + CAST(@Years AS VARCHAR(4)) +
           ' Months: ' + CAST(@Months AS VARCHAR(2)) +
           ' Days: ' + CAST(@Days AS VARCHAR(2)) 
END
GO

--Calling Function:

Select dbo.GetDateDifference(news.TimePostedOn,CURRENT_TIMESTAMP) as TimePostedDifference from News;

----------------------------------------------------------------------------
--Celebrities born today---
----------------------------------------------------------------------------

Create function get_Celebs_Born_Today(@currentdate smalldatetime)
returns Table
   as

   return select Celebrity.CelebrityName as Celebrity_Name,Celebrity.DateofBirth as Date_Of_Birth from Celebrity where DAY(Celebrity.DateofBirth)=DAY(@currentdate) AND MONTH(Celebrity.DateofBirth)=MONTH(@currentdate);

--View to get the details of the Celebs born today
create view celebs_born_today as select * from dbo.get_Celebs_Born_Today(GETDATE());

--Calling of view
select * from celebs_born_today;

select * from Celebrity;

--insert into Celebrity values(22,'Siddhant Chandiwal',getDate(),'India','An actor of Indian Origin','Male');

