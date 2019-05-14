cd $(dirname $0)/server
line=$(cat ../config.txt)
nohup python3 server.py $line &
exit