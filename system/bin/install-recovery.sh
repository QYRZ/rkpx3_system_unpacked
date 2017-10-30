#!/system/bin/sh

func_start_kr() {
	/system/xbin/krdem kingroot-dev 100002 1
	/system/xbin/ku.sud -d
	/system/etc/kds --global-daemon 1
}


KR_TMP_FNAME=krperm1

LOG_FILE_TMP=/data/local/tmp/$KR_TMP_FNAME.txt.tmp
LOG_FILE=/data/local/tmp/$KR_TMP_FNAME.txt

/sbin/supolicy --live
/system/xbin/supolicy --live

rm -f $LOG_FILE_TMP
rm -f $LOG_FILE

echo "[$0] begin ..." > $LOG_FILE_TMP
chmod 0777 $LOG_FILE_TMP

id >> $LOG_FILE_TMP  2>&1

func_start_kr >> $LOG_FILE_TMP 2>&1

echo "[$0] end!" >> $LOG_FILE_TMP

chcon u:object_r:shell_data_file:s0 $LOG_FILE_TMP
chown shell.shell $LOG_FILE_TMP
chmod 00644 $LOG_FILE_TMP
mv $LOG_FILE_TMP $LOG_FILE

