declare @CallTypeDesc AS VARCHAR(20),
	@CallTime AS DATETIME ,
	@ResultCode  AS INTEGER
exec FingerPBookShift 11575992,@CallTypeDesc OUTPUT,@CallTime OUTPUT,@ResultCode output