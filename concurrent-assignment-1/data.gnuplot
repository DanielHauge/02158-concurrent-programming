set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
plot "data.csv" using 1:2 with lines, '' using 1:3 with lines