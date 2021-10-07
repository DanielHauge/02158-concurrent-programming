set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
plot "shakespear_10tasks-1threads2.csv" using 1:2 with linespoints title "Tasks: 10", '' using 1:3 with lines
replot "shakespear_15tasks-1threads2.csv" using 1:2 with linespoints title "Tasks: 15", '' using 1:3 with lines
replot "shakespear_20tasks-1threads2.csv" using 1:2 with linespoints title "Tasks: 20", '' using 1:3 with lines
