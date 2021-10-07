set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
plot "shakespear_10tasks-1threads1.csv" using 1:2 with lines, '' using 1:3 with lines
replot "shakespear_10tasks-1threads2.csv" using 1:2 with lines, '' using 1:3 with lines