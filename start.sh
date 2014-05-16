../play start -DapplyEvolutions.default=true -Dhttp.port=9000 &
sleep 10
FILE=/play/yobi/conf/application.conf
OSIZE=$(wc -c "$FILE" | cut -f 1 -d ' ')
while [ $OSIZE -eq $(wc -c "$FILE" | cut -f 1 -d ' ') ]
do
  sleep 2
done
kill $(cat /play/yobi/RUNNING_PID)
../play start -DapplyEvolutions.default=true -Dhttp.port=9000
