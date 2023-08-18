#!/bin/bash

echo Starting a starter tournament...
for(( i=1; i <= $(wc -l < Games.txt); i++)) do
    TEAM=$(sed -n "$i"p Games.txt)
        if [ "$TEAM" = -------------------- ]; then
            continue
    fi
    sleep 5
    rcssserver server::fullstate_l = true server::fullstate_r = true server::auto_mode = true server::synch_mode = false server::gam>
    sleep 1
    server_pid=$!
    sleep 1
    cd Bins/$TEAM && ./localStartAll &
    sleep 6
    i=$((i+1))
    TEAM=$(sed -n "$i"p Games.txt)
    cd Bins/$TEAM && ./localStartAll &
    wait $server_pid
    sleep 1
    ./LogCompressor.sh
    python3 ChangeLogDir.py
done
sleep 7
./KillMonitor.sh
./Analyze.sh

