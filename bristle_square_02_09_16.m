%% stimulus generation, 02_05_2016 JCT  
clear all;close all

%% initialize params
abf_file = '2016_03_01_0002';
stim_function = 'square_ao_func_02_2016';
lengths_off = [400 1600 4800]; %%(ms of stimulus off)

lengths_on = [100 400]; %%(ms of stimulus on)
movements = [10]; %% in microns
reps = 2;%% number of times to repeat all trials
pause_time = 10; %% pause between trials in sec
num_cycles = 8; %% number of reps per trial
plot_flag = 1; %% if 0, don't plot the data;

num_conditions = length(lengths_on)*length(lengths_off)*length(movements);
cond_sigs = linspace(1,9, num_conditions);%% scale cond sig between 1 and 9 volts
all_lengths = meshgrid(lengths_off, lengths_on)+meshgrid(lengths_on, lengths_off)';
total_length = reps*((pause_time*num_conditions)+length(movements)*num_cycles*sum(all_lengths(:)/1000));%% in secs
display(['total exp length = ' num2str(total_length) ' secs']);

%% make and save conditions matrix
conds_mat = [];cond_num = 1;conds = [];
for ii = 1:length(lengths_on)
  for  kk = 1:length(lengths_off)
    for jj = 1:length(movements)
        conds(cond_num).cond= cond_num;
        conds(cond_num).on = lengths_on(ii);
        conds(cond_num).off = lengths_off(kk);
        conds(cond_num).move = movements(jj);
        conds(cond_num).reps = reps;
        conds(cond_num).pause = pause_time;
        conds(cond_num).cycles = num_cycles;
        conds(cond_num).cs = cond_sigs(cond_num);
        conds(cond_num).func = stim_function;
        conds(cond_num).time = datestr(datetime('now','TimeZone','local'), 'yy_MM_dd_HH_mm_ss');
        conds(cond_num).abf = abf_file;
        cond_num= cond_num+1;
    end 
  end
end

%% check to see if a condition table for this abf file has already been written
cond_num = [];
if exist(['C:\Data\stim_metadata\' abf_file '.txt'], 'file');
   overwrite_it = input('file already exists, hit y and enter to overwrite, or c to continue:  ','s');
end
if ~exist('overwrite_it','var') || overwrite_it == 'y'
writetable(struct2table(conds),['C:\Data\stim_metadata\' abf_file],'Delimiter', '\t');
elseif ~exist('overwrite_it','var') || overwrite_it ~= 'c'
return;
  
end

%% initialize ao and set all channels to zero
global nisesh;
nisesh = daq.createSession('ni');
addAnalogOutputChannel(nisesh,'cDAQ1Mod1',[0:2],'Voltage');
queueOutputData(nisesh,[0 0 0]);%% first 2 channels are AO to the piezo and the daq; third is condition signal
nisesh.Rate = 5000;
nisesh.startForeground;

%% play stimuli in a randomized order
for ii = 1:reps
  rand_conds = randperm(length(conds));

  for jj = 1:length(conds)
      
    cond_num = rand_conds(jj);
    pause(conds(cond_num).pause);
    
    display(['starting trial ' num2str(jj) ' of ' num2str(length(conds)) ', rep ' num2str(ii)...
    ' of ' num2str(reps) '; condition = ' num2str(cond_num)]);

    square_ao_func_02_09_2016(conds(cond_num).move, conds(cond_num).cycles, conds(cond_num).on, ...
    conds(cond_num).off, conds(cond_num).cs ,plot_flag); 

  end
end

display('all done'); beep;