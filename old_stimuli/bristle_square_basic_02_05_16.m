%% 02_05_2016 JCT

clear all;close all

pause_time = 60; %% pause between trials
num_cycles = 10; %% number of reps per trial
length_on = 250; %%(ms of stimulus on)
length_off = 1250; %%(ms of stimulus off)
movement_amps = [1 2 4 8 16 32]; %% in microns
reps = 5;%% number of times to repeat all trials
plot_flag = 0; %% if 0, don't plot the data;


total_exp_length = reps*(pause_time+length(movement_amps)*num_cycles*((length_on+length_off)/1000));
display(['total exp length is ' num2str(total_exp_length) ' secs']);

%% ascending/descending amplitudes
for ii =1:reps
    
    if mod(ii,2) == 1;movements = fliplr(movement_amps);
    else movements = movement_amps;end
        
    for jj = 1:length(movements)
    pause(pause_time);
    display(['starting rep ' numstr(ii)  , 'trial ' num2str(jj)]);
    simple_square_ao_02_2016(movements(jj), num_cycles, length_on, length_off,plot_flag); 
    end
    
end

% 
% %% randomized amplitude trials
% for ii =1:reps
% rand_movements  = movements(randperm(length(movements)));
% 
% for jj = 1:length(randmovements)
% pause(pause_time);
% display(['starting rep ' numstr(ii)  , 'trial ' num2str(jj)]);
% simple_square_ao_02_2016(rand_movements(jj), num_cycles, length_on, length_off,plot_flag); 
% end
% end