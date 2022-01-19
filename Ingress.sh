cd TEMGData

echo "BASE"
BEGIN=$(date +%s%N)
curl -F schema='[{"name":"Id", "type": "SYMBOL"}, {"name":"Ex", "type": "STRING"},{"name":"Descr", "type": "STRING"}, {"name":"SIC", "type": "STRING"}, {"name":"SPR", "type": "STRING"}, {"name":"Cu", "type": "STRING"}, {"name":"CreateDate", "type": "TIMESTAMP", "pattern" : "dd/MM/yyyy", "pattern" : "d/MM/yyyy"}]' -F data=@base-3000-4000.csv "http://localhost:9000/imp?overwrite=true&forceHeader=true"
END=$(date +%s%N)
echo $(($END - $BEGIN))
echo " "

echo "SPLIT"
BEGIN=$(date +%s%N)
curl  -F schema='[{"name":"Id", "type": "STRING"}, {"name":"SplitDate", "type": "TIMESTAMP", "pattern" : "yyyy-MM-dd", "pattern" : "yyyy-MM-d", "pattern" : "yyyy-M-dd", "pattern" : "yyyy-M-d"},{"name":"EntryDate", "type": "TIMESTAMP","pattern" : "yyyy-MM-dd", "pattern" : "yyyy-MM-d", "pattern" : "yyyy-M-dd", "pattern" : "yyyy-M-d"}, {"name":"SplitFactor", "type": "INT"}]'   -F data=@split-3000-4000.csv "http://localhost:9000/imp?overwrite=true&forceHeader=true"
END=$(date +%s%N)
echo $(($END - $BEGIN))
echo " "

echo "PRICE"
BEGIN=$(date +%s%N)
curl  -F schema='[{"name":"Id", "type": "STRING"}, {"name":"TradeDate", "type": "TIMESTAMP", "pattern" : "yyyy-MM-dd", "pattern" : "yyyy-MM-d", "pattern" : "yyyy-M-dd", "pattern" : "yyyy-M-d"},{"name":"HighPrice", "type": "DOUBLE"},{"name":"LowPrice", "type": "DOUBLE"},{"name":"ClosePrice", "type": "DOUBLE"},{"name":"OpenPrice", "type": "DOUBLE"},{"name":"Volume", "type": "DOUBLE"} ]'    -F data=@price-3000-4000.csv "http://localhost:9000/imp?overwrite=true&forceHeader=true"
END=$(date +%s%N)
echo $(($END - $BEGIN))
echo " "



curl -G --data-urlencode 'query=drop table "split";'  http://localhost:9000/exec
curl -G --data-urlencode 'query=drop table "base";'  http://localhost:9000/exec
curl -G --data-urlencode 'query=drop table "price";'  http://localhost:9000/exec
curl -G --data-urlencode 'query=rename table "base-3000-4000.csv" to "base";'  http://localhost:9000/exec
curl -G --data-urlencode 'query=rename table "price-3000-4000.csv" to "price";'  http://localhost:9000/exec
curl -G --data-urlencode 'query=rename table "split-3000-4000.csv" to "split";'  http://localhost:9000/exec
