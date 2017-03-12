go
create view Upcoming_Movies as
select MovieId,MovieName,MovieShortDescription,MovieDuration,TelevisionContentRatingSystem,
WatchTrailerURL,MovieRating, MovieTotalVotes,AverageUserRating from Movie where ReleaseDate > GETDATE();

go
create view On_Tonight as
select tv.TVShowName,s.SeasonNumber,e.EpisodeNumber,e.EpsiodeName,c.ChannelName,t.StartTime,t.EndTime from TimeSlots t 
JOIN Episode e on e.EpisodeId = t.EpisodeId
JOIN Season s on s.SeasonId=e.SeasonId
JOIN Channel c on t.ChannelId=c.ChannelId
JOIN TVShows tv on s.TVShowId=tv.TVShowId
where Date=convert(date,GETDATE());

select * from On_Tonight;



select * from Upcoming_Movies;

insert into Movie values(16,'The Mummy','The Mummy returns, Again!',GETDATE()+5,'2:15:00','R','http://www.imdb.com',8.8,36000,6.1);
delete from Movie where MovieId=16;



update TimeSlots set Date = Convert(date,getdate()) where EpisodeId%2=0;