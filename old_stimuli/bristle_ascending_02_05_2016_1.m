clear all;close all

pause_time = 60;

num_cycles = 10;
length_on = 250; %%(in ms)
length_off = 2500; %%(in ms)
plot_flag = 0;

movement = 1;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);

movement = 2;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);

movement = 4;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);

movement = 8;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);

movement = 16;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);

movement = 32;%% in microns
simple_square_ao(movement, num_cycles, length_on, length_off, plot_flag);
pause(pause_time);




