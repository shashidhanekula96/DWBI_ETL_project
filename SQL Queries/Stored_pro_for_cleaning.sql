CREATE PROC test_clean (
    @table NVARCHAR(128)
)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
    -- construct SQL
	--set @table = 'Test_Payment_hospital'
	SET @sql = 'UPDATE '+ @table +
	' SET [Higher_estimate] = 
                        (
                         CASE 
                            WHEN [Higher_estimate] LIKE ''%[^a-zA-Z0-9]%'' 
                                  THEN Replace(REPLACE( [Higher_estimate], SUBSTRING( [Higher_estimate], PATINDEX(''%[$,,]%'', [Higher_estimate]), 1 ),''''),'','','''')
                            ELSE [Higher_estimate]
                          END
                         )'
	--PRINT @sql

    --SET @sql = N'SELECT * FROM ' + @table;
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;


select top 100* from Test_Payment_hospital
