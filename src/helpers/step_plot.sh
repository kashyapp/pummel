#!/bin/sh -e
# expects filename (with output of step) as argument
FILE=$1
[ -f $FILE ] || exit 1

mkdir -p plots
[ -d plots ] || exit 1

gnuplot << EOF
set noautoscale
set autoscale x
set autoscale ymax
set autoscale y2max

# set logscale x

set xlabel 'concurrency'
set ylabel 'latency(ms)'
set y2label 'reqs/sec'
set y2tics auto

set xtics 2

set tics nomirror out
set style data line

set terminal png size 600,400 truecolor font 'Verdana, 8' background '#FFFFDD' 
set output "plots/$FILE.png"

set title "$FILE"

plot "$FILE" using "client":"tp99.0" title 'tp99(ms)', \
    '' using "client":"mean":"stddev" with errorbars title 'mean(ms)', \
    '' using "client":"reqs/sec" axes x1y2 title 'reqs/sec'
EOF

# echo "<img src='$FILE.png' height=400 width=600 />"
