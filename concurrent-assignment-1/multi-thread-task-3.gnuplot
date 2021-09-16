set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
plot "multi-thread-task-31.csv" using 1:2 with lines, '' using 1:3 with lines
replot "multi-thread-task-32.csv" using 1:2 with lines, '' using 1:3 with lines