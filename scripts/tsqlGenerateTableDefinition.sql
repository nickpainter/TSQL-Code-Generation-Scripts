-- Generate table variable table definition schema for temporary # table in tempdb

declare @tableName nvarchar(max)
set @tableName = '#temp'

use tempdb
declare @tmp table(val nvarchar(max))
insert into @tmp 
select case data_type	
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
    else COLUMN_NAME + ' ' + DATA_TYPE
	end 'dataType'
	 from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like @tableName + '%'declare @tableName nvarchar(max)
set @tableName = '#temp'

use tempdb
declare @tmp table(val nvarchar(max))
insert into @tmp 
select case data_type	
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
    else COLUMN_NAME + ' ' + DATA_TYPE
	end 'dataType'
	 from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like @tableName + '%'

declare @result nvarchar(max)
set @result = ''
select @result = @result + [val] + N','
from @tmp
where val is not null

set @result = substring(@result, 1, (LEN(@result)-1))

select @result

-- The following will replce '-1' with 'max' in order to properly handle nvarchar(max) columns
set @result = REPLACE(@result, '-1', 'max')
select @result

declare @result nvarchar(max)
set @result = ''
select @result = @result + [val] + N','
from @tmp
where val is not null

set @result = substring(@result, 1, (LEN(@result)-1))

select @result

-- The following will replce '-1' with 'max' in order to properly handle nvarchar(max) columns
set @result = REPLACE(@result, '-1', 'max')
select @result