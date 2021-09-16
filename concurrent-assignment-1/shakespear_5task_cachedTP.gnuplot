set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
plot "shakespear_5task_cachedTP1.csv" using 1:2 with lines, '' using 1:3 with lines
replot "shakespear_5task_cachedTP2.csv" using 1:2 with lines, '' using 1:3 with lines