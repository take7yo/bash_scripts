#!/bin/bash
docker rm -f jsylEvaluation
docker run --name=jsylEvaluation -ti -v /data/www/jinseyulin-evaluation/:/home/goProjects -v /data/www/gopath:/go --link mysql_server:mysql -w /home/goProjects/src/cn.jinseyulin.evaluation -p 80:8808 -d golang ./ok.sh
docker exec -it jsylEvaluation ./rs.sh
