
SET NOCOUNT ON

DROP TABLE arrays

CREATE TABLE arrays (
				ID int,
				Array varchar(max)
				)


INSERT INTO arrays VALUES 
(1, '{"Item1", "Item2", "Item3"}')
,(2, '{"Item3", "Item1", "Item2"}')

--Remove curlys
UPDATE arrays SET
arrays.array = REPLACE(REPLACE(REPLACE(arrays.array,'{',''),'}',''),'"','')

--Split string into rows, remove spaces
DROP TABLE split_arrays

SELECT a.ID, RTRIM(LTRIM(split_array.value)) as ItemValue
INTO split_arrays
FROM arrays a
	CROSS APPLY string_split(a.array, ',') split_array

--Cross join values on ID, count them up
SELECT a.ID, count(*) 
FROM split_arrays a
JOIN split_arrays sa on sa.ID = a.ID

GROUP BY a.ID
				