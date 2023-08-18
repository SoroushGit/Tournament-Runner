#!/bin/bash

echo Starting test...
rcssmonitor --auto-reconnect-mode on --auto-reconnect-wait 2 &
for(( i=1; i <= $(wc -l < TestGames.txt); i++)) do
    TEAM=$(sed -n "$i"p TestGames.txt)
    sleep 5
    rcssserver server::penalty_shoot_outs = false  server::fullstate_l = true server::fullstate_r = true server::auto_mode = true server::synch_mode = false server::half_time = 30 server::nr_normal_halfs = 1 server::nr_extra_halfs = 0 server::game_log_dir = `pwd` server::keepaway_log_dir = `pwd` server::text_log_dir = `pwd` & server::penalty_shoot_outs = false
    sleep 1
    server_pid=$!
    sleep 1
    cd Bins/$TEAM && ./localStartAll &
    sleep 6
    cd Bins/Helios2023 && ./localStartAll &
    wait $server_pid
    sleep 1
    ./LogCompressor.sh
    python3 ChangeLogDir.py
done
sleep 7
./KillMonitor.sh
