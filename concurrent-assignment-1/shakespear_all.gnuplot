set datafile separator ','
set ylabel "Seconds" # label for the Y axis
set xlabel 'Run' # label for the X axis
set key autotitle columnhead
set key outside top
plot "shakespear_1tasks-1threads2.csv" using 1:2 with linespoints title "Tasks:1 - Threads:1", '' using 1:3 with lines
replot "shakespear_8tasks-2threads2.csv" using 1:2 with linespoints title "Tasks:8 - Threads:2", '' using 1:3 with lines
replot "shakespear_8tasks-8threads2.csv" using 1:2 with linespoints title "Tasks:8 - Threads:8", '' using 1:3 with lines
replot "shakespear_20tasks-20threads2.csv" using 1:2 with linespoints title "Tasks:20 - Threads:20", '' using 1:3 with lines