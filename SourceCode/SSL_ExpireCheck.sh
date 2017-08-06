#!/bin/sh

_URL1=(id.ogplanet.com io.ogplanet.com astros.ogplanet.com)
_URL2="callback.ogplanet.com"
_I=0
_TODAY=`date +'%Y-%m-%d'`

#function EMAIL_ {
#  echo ${ARRY[0]}
#  echo ${ARRY[1]}
#  echo ${ARRY[2]}
#  echo ${ARRY[99]}
#}


#dday ??
date2stamp () {

    date --utc --date "$1" +%s

}

stamp2date (){

    date --utc --date "1970-01-01 $1 sec" "+%Y-%m-%d %T"

}

dateDiff (){

    case $1 in

        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;

    esac

    dte1=$(date2stamp $1)
    dte2=$(date2stamp $2)
    diffSec=$((dte2-dte1))
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))

}


#IFS=$'\n'
for x in ${_URL1[@]}
do
        #declare -a ARRY[$_I]=$((echo | openssl s_client -servername $ -connect $x:443 2>/dev/null | openssl x509 -noout -dates | xargs echo "URL: $x" ))
        ARRY[$_I]=$(echo | openssl s_client -servername $x -connect $x:443 2>/dev/null | openssl x509 -noout -dates | xargs)
        BURL[$_I]="echo $x"
        DDAY[$_I]=$(echo ${ARRY[$_I]} | awk -F "GMT" '{gsub("notAfter=","",$2); print $2}')
        DATE[$_I]=`date -d"${DDAY[$_I]}" +%Y-%m-%d`
        #date -d'Aug 12 20:39:38 2017' +%Y-%m-%d
    if [ "$(dateDiff -d $_TODAY ${DATE[$_I]})" -le 30 ] ; then
                echo "$x ???? ????????$(dateDiff -d $_TODAY ${DATE[$_I]})? ?????" | mail -s "[Certificate] alert" eric.kwak@ogplanet.com
        fi
        ((_I++))
done

ARRY[99]=$(echo | openssl s_client -servername $_URL2 -connect $_URL2:444 2>/dev/null | openssl x509 -noout -dates | xargs)
DDAY[99]=$(echo ${ARRY[99]} | awk -F "GMT" '{gsub("notAfter=","",$2); print $2}')
DATE[99]=`date -d"${DDAY[99]}" +%Y-%m-%d`
if [ "$(dateDiff -d $_TODAY ${DATE[99]})" -le 30 ] ; then
        echo "$_URL2 ???? ????????$(dateDiff -d $_TODAY ${DATE[99]})? ?????" | mail -s "[Certificate] alert" eric.kwak@ogplanet.com
fi


#if [ "$(dateDiff -d $TODAY $EXPIRE_DAY)" -le 30 ] ; then
#    echo "expire ????? $(dateDiff -d "$TODAY" "$EXPIRE_DAY")? ?????!!!"
#fi


----------------------- Dday ?? ?? ???? -------------------
#!/bin/bash

date2stamp () {

    date --utc --date "$1" +%s

}

stamp2date (){

    date --utc --date "1970-01-01 $1 sec" "+%Y-%m-%d %T"

}

dateDiff (){

    case $1 in

        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;

    esac

    dte1=$(date2stamp $1)
    dte2=$(date2stamp $2)
    diffSec=$((dte2-dte1))
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))

}

## USAGE # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## convert a date into a UNIX timestamp
#    stamp=$(date2stamp "2006-10-01 15:00")
#    echo $stamp
#
## from timestamp to date
#    stamp2date $stamp
#
## calculate the number of days between 2 dates
#    # -s in sec. | -m in min. | -h in hours  | -d in days (default)
#    dateDiff -s "2006-10-01" "2006-10-32"
#    dateDiff -m "2006-10-01" "2006-10-32"
#    dateDiff -h "2006-10-01" "2006-10-32"
#    dateDiff -d "2006-10-01" "2006-10-32"
#    dateDiff  "2006-10-01" "2006-10-32"
#
## number of seconds between two times
#    dateDiff -s "17:55" "23:15:07"
#    dateDiff -m "17:55" "23:15:07"
#    dateDiff -h "17:55" "23:15:07"
#
## number of minutes from now until the end of the year
#    dateDiff -m "now" "2006-12-31 24:00:00 CEST"
#
## Other standard goodies from GNU date not too well documented in the man pages
#    # assign a value to the variable dte for the examples below
#    dte="2006-10-01 06:55:55"
#    echo $dte
#
#    # add 2 days, one hour and 5 sec to any date
#    date --date "$dte  2 days 1 hour 5 sec"
#
#    # substract from any date
#    date --date "$dte 3 days 5 hours 10 sec ago"
#    date --date "$dte -3 days -5 hours -10 sec"
#
#    # or any mix of +/-. What will be the date in 3 months less 5 days
#    date --date "now +3 months -5 days"
#
#    # time conversions into ISO-8601 format (RFC-3339 internet recommended format)
#    date --date "sun oct 1 5:45:02PM" +%FT%T%z
#    date --iso-8601=seconds --date "sun oct 1 5:45:02PM"
#    date --iso-8601=minutes
#
#    # time conversions into RFC-822 format
#    date --rfc-822 --date "sun oct 1 5:45:02PM"


#EXPIRE_DAY=`date -d "$(chage -l centos | grep 'Password expires' | awk -F: '{print $2}')"  +'%Y-%m-%d'`
EXPIRE_DAY="2017-08-12"

TODAY=`date +'%Y-%m-%d'`


if [ "$(dateDiff -d $TODAY $EXPIRE_DAY)" -le 30 ] ; then
        echo "expire ????? $(dateDiff -d "$TODAY" "$EXPIRE_DAY")? ?????!!!"
fi
