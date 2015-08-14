nohup redis-server > redis.out &
nohup rake environment resque:work QUEUE=fs_updates > fs_updates.out &
nohup rake environment resque:work QUEUE=mailers > mailers.out &
nohup rake environment resque:work QUEUE=notifications > notifications.out &
nohup rake environment resque:scheduler > scheduler.out &
rvmsudo thin -R config.ru -a 192.168.1.6 -p 443 --ssl --ssl-key-file certificates/server.key --ssl-cert-file certificates/server.crt start