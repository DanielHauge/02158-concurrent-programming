set style data histograms
set style fill solid
set ylabel "Speedup" # label for the Y axis
set xlabel '(Tasks, Threads)' # label for the X axis
plot './speedup2.data' using 2:xtic(1) title ""