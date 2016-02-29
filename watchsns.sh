#!/bin/bash
watch -n1 /home/bash/tail.sh /home/sns/system/tmp/debug/debug_day_`date '+%Y%m%d'`.log $1
