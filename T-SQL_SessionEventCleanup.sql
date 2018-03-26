use <NameOfYourNAVDatabase>;

declare @days int;
set @days = 3; --days for Session Event logs to retain
delete from [Session Event] (nolock) where [Event Datetime] < dateadd(day, -@days, cast(getdate() as date))