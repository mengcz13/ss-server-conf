# kill all running precess
ps -ef | grep "ss-server" | grep -v grep | awk '{print $2}' | xargs kill -9

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "$SCRIPT_DIR" )" && pwd )"
CONF_DIR="$BASE_DIR/conf"
LOG_DIR="$BASE_DIR/logs"

for conffilepath in $CONF_DIR/*.json; do
    conffilename=$(basename $conffilepath)
    logpath="$LOG_DIR/${conffilename%.*}.log"
    nohup ss-server -c "$conffilepath" -u > "$logpath" 2>&1 &
done

