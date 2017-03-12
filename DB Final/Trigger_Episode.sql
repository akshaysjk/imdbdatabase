--drop trigger add_time_slot;
CREATE TRIGGER add_time_slot ON Episode
AFTER INSERT
AS
BEGIN
DECLARE @episodeId int,
@seasonId int,
@channel varchar(50),
@temp_episodeId int

--get the values from the inserted table into @episodeId and @seasonId
Select @episodeId=EpisodeId,@seasonId=SeasonId from inserted;


--updating the total number of episodes for a particular season in Season table
update Season set Totalepisodes = Totalepisodes+1 where SeasonId=@seasonId;

PRINT N'-------------Total number of TV shows has been updated in the Season Table.------------------------';

--Retriving other Episode's Id of the same season
Select TOP 1 @temp_episodeId=EpisodeId from Episode where SeasonId=@seasonId and EpisodeId!=@episodeId;

--Retriving Channel id of that episode to find the channel on which the telecast would happen
select @channel=ChannelId from TimeSlots where EpisodeId=@temp_episodeId;

-- inserting into timeslot table with the channel id retrived above and randomly generated time slots and Date =date_of_insertion + 5 days
insert into TimeSlots values(@episodeId,@channel,dateadd(millisecond, cast(3600000 * RAND() as int), convert(time, '08:00')),DATEADD(MINUTE,30,dateadd(millisecond, cast(3600000 * RAND() as int), convert(time, '08:00'))),GETDATE()+5);

PRINT N'------------TimeSlot table has been updated with the schedule for this TV Episode---------------------';

end;


select * from Episode;

insert into Episode values(86,6,'The Iron Throne','Will Mother of Dragon rule the Iron Throne',14);

select * from Season where SeasonId=14;

select * from TimeSlots where EpisodeId = 86;