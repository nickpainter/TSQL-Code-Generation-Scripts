-- Generate TSQL Params lists from a given table
-- Used to quickly generate insert, update, delete statements

declare @tableName nvarchar(max)
set @tableName = 'TableName'

select
case ordinal_position 
	 when 1 then ' @'
	 else ',@'
 end
+ COLUMN_NAME + ' ' +  
case data_type
	when 'nvarchar' then cast(DATA_TYPE as nvarchar(max)) + '(' + cast(CHARACTER_MAXIMUM_LENGTH as nvarchar(max)) + ')'
	when 'varchar' then cast(DATA_TYPE as nvarchar(max)) + '(' + cast(CHARACTER_MAXIMUM_LENGTH as nvarchar(max)) + ')'
	when 'char' then cast(DATA_TYPE as nvarchar(max)) + '(' + cast(CHARACTER_MAXIMUM_LENGTH as nvarchar(max)) + ')'
	when 'binary' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	when 'char' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	when 'datetime2' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + CAST(DATETIME_PRECISION as nvarchar(max)) + ')'
	when 'datetimeoffset' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + CAST(DATETIME_PRECISION as nvarchar(max)) + ')'
	when 'decimal' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(NUMERIC_PRECISION as nvarchar(max)) + ',' + cast(NUMERIC_SCALE as nvarchar(max)) + ')'
	when 'nchar' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	when 'numeric' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(NUMERIC_PRECISION as nvarchar(max)) + ',' + cast(NUMERIC_SCALE as nvarchar(max)) + ')'
	when 'nvarchar' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	when 'time' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + CAST(DATETIME_PRECISION as nvarchar(max)) + ')'
	when 'varbinary' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	when 'varchar' then COLUMN_NAME + ' ' + DATA_TYPE + '(' + cast(CHARACTER_MAXIMUM_LENGTH AS nvarchar(max)) + ')'
	-- Most standard data types follow the pattern in the other section.  
    -- Non-standard datatypes include: binary, char, datetime2, datetimeoffset, decimal, nvchar, numeric, nvarchar, time, varbinary, and varchar
	else
	cast(DATA_TYPE as nvarchar(max))
	end 'dub'
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @tableName
order by ORDINAL_POSITION asc


select 
case ordinal_position 
	 when 1 then ' '
	 else ','
 end
+ COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @tableName
order by ORDINAL_POSITION asc


select
case ordinal_position 
	 when 1 then ' @'
	 else ',@'
 end
+ COLUMN_NAME 
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @tableName
order by ORDINAL_POSITION asc


select
case ordinal_position 
	 when 1 then COLUMN_NAME + ' = @'
	 else ',' + column_name + ' = @'
 end
+ COLUMN_NAME 

from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @tableName
order by ORDINAL_POSITION asc