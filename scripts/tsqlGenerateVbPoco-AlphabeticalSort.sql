-- TSQL Generate Poco VB.net
-- Order by alphabetical column name


declare @TableName sysname
set @TableName = 'TableName'
declare @prop varchar(max)
PRINT 'Public Class ' + @TableName
declare props cursor for
select distinct ' public property ' + ColumnName + ' AS ' + ColumnType AS prop
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
    from sys.columns col join sys.types typ on col.system_type_id = typ.system_type_id 
    where object_id = object_id(@TableName) 
) t 
order by prop
open props
FETCH NEXT FROM props INTO @prop
WHILE @@FETCH_STATUS = 0
BEGIN
	if @prop <> ''
	begin
    print @prop
	end
    FETCH NEXT FROM props INTO @prop
END
close props
DEALLOCATE props
PRINT 'End Class'