-- TSQL Generate vb poco
-- Order by ordinal position

declare @TableName sysname
set @TableName = 'TableNameHere'
declare @prop varchar(max)
declare @ordinal_position varchar(max)
PRINT 'Public Class ' + @TableName
declare props cursor for
select distinct ' public property ' + ColumnName + ' AS ' + ColumnType AS prop
,ORDINAL_POSITION
from ( 
    select  
        replace(col.name, ' ', '_') ColumnName,  column_id, 
        case typ.name  
            when 'bigint' then 'long' 
            when 'binary' then 'byte[]' 
            when 'bit' then 'boolean' 
            when 'char' then 'string' 
            when 'date' then 'DateTime' 
            when 'datetime' then 'DateTime' 
            when 'datetime2' then 'DateTime' 
            when 'datetimeoffset' then 'DateTimeOffset' 
            when 'decimal' then 'decimal' 
            when 'float' then 'float' 
            when 'image' then 'byte[]' 
            when 'int' then 'integer' 
            when 'money' then 'decimal' 
            when 'nchar' then 'char' 
            when 'ntext' then 'string' 
            when 'numeric' then 'decimal' 
            when 'nvarchar' then 'string' 
            when 'real' then 'double' 
            when 'smalldatetime' then 'DateTime' 
            when 'smallint' then 'short' 
            when 'smallmoney' then 'decimal' 
            when 'text' then 'string' 
            when 'time' then 'TimeSpan' 
            when 'timestamp' then 'DateTime' 
            when 'tinyint' then 'byte' 
            when 'uniqueidentifier' then 'Guid' 
            when 'varbinary' then 'byte[]' 
            when 'varchar' then 'string' 
        end ColumnType 
		,ORDINAL_POSITION
    from sys.columns col join sys.types typ on col.system_type_id = typ.system_type_id 
	left outer join INFORMATION_SCHEMA.COLUMNS isc on col.name = isc.COLUMN_NAME and @TableName = isc.TABLE_NAME
    where object_id = object_id(@TableName) 
) t 
--order by prop
order by ORDINAL_POSITION
open props
FETCH NEXT FROM props INTO @prop, @ordinal_position
WHILE @@FETCH_STATUS = 0
BEGIN
	if @prop <> ''
	begin
    print @prop
	end
    FETCH NEXT FROM props INTO @prop, @ordinal_position
END
close props
DEALLOCATE props
PRINT 'End Class'