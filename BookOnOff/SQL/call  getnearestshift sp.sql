declare @Pin AS CHAR(15),	@Site AS CHAR(15),	@SiteName AS CHAR(30) ,
		@StartTime AS DATETIME ,	@Length AS integer ,	@ShiftID AS NUMERIC(18,0),
		@Status As CHAR(10), @CheckPattern AS CHAR(10)
	 

set @pin='1301'
set @site='4002'

exec FingerPGetNearestShift	@Pin,@Site OUTPUT,@SiteName OUTPUT,@StartTime OUTPUT,
				@Length OUTPUT,	@ShiftID  OUTPUT, @Status OUTPUT, @CheckPattern OUTPUT

print @Pin
print @Site 
print @SiteName 
print @StartTime 
print @Length 
print @ShiftID  
print @Status
Print @CheckPattern