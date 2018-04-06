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