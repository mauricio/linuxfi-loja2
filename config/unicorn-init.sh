#! /bin/sh

### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the unicorn web server
# Description:       starts unicorn
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME="/etc/init.d/unicorn"
PID=/home/deployer/loja/shared/pids/unicorn.pid

start() {
  su deployer -c "/home/deployer/.rvm/bin/rvm-shell 'ruby-1.9.2@loja' -c 'cd /home/deployer/loja/current; bundle exec unicorn_rails -c /home/deployer/loja/current/unicorn.rb -E production -D' ";
}

case "$1" in
  start)
	echo -n "Starting $NAME: "
	start
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $NAME: "
        kill -QUIT `cat $PID`
	echo "$NAME."
	;;
  restart)
	echo -n "Restarting $NAME: "
        kill -QUIT `cat $PID`
	sleep 1
	start
	echo "$NAME."
	;;
  reload)
        echo -n "Reloading $NAME configuration: "
        kill -HUP `cat $PID`
        echo "$NAME."
        ;;
  *)
	echo "Usage: $NAME {start|stop|restart|reload}" >&2
	exit 1
	;;
esac

exit 0