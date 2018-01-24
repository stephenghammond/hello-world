DECLARE @Pin AS CHAR(15),
		@Site AS CHAR(15),
		@StartTime AS DATETIME,-- OUTPUT,
		@ShiftID AS NUMERIC(18,0)-- OUTPUT

SET @Pin='1359'
SET @Site='4002'
		
DECLARE @MaxEarlyMins AS Integer,
		@MaxLateMins AS Integer

SET @MaxEarlyMins=700
SET @MaxLateMins=700

SELECT Top 1 ro_shift_start,ro_shiftid FROM ROSTER 
	WHERE ro_officer=@Pin AND ro_activity=@Site
		AND ro_shift_start > DATEADD(mi,-1* @MaxEarlyMins,GETDATE())
		AND ro_shift_start < DATEADD(mi, @MaxLateMins,GETDATE())
IF @@ROWCOUNT <1 -- if 
BEGIN
	SELECT Top 1 ro_shift_start,ro_shiftid,ro_activity,ac_name 
		FROM ROSTER INNER JOIN activity on ac_pin=ro_activity
	WHERE ro_officer=@Pin 
		AND ro_shift_start > DATEADD(mi,-1* @MaxEarlyMins,GETDATE())
		AND ro_shift_start < DATEADD(mi, @MaxLateMins,GETDATE())

END
