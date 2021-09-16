set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
plot "shakespear_8tasks-2threads1.csv" using 1:2 with lines, '' using 1:3 with lines
replot "shakespear_8tasks-2threads2.csv" using 1:2 with lines, '' using 1:3 with lines