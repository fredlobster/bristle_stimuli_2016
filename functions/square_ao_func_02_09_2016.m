%% 02_08_2016 JCT
function square_ao_func_02_09_2016(movement, num_cycles, length_on, length_off, cond_sig, plot_flag)
global nisesh;
micron = 10/60;
amplitude = movement*micron;

total_length = num_cycles*(length_on+length_off)+length_off;%% in ms

out_1= [zeros(1,length_off/1000*nisesh.Rate)];

for ii =1:num_cycles
    out_1=  [out_1 amplitude*ones(1,length_on/1000*nisesh.Rate) zeros(1,length_off/1000*nisesh.Rate)];
end 
    
out_2= cond_sig*[ones(1,length(out_1))];
out_2(1:10) = 0;out_2((end-10):end) = 0;

if plot_flag == 1
f9 = figure(9);clf;set(f9, 'Position', [1100, 650, 500, 500]);hold all;
plot((1:length(out_1))/nisesh.Rate, out_1);
plot((1:length(out_1))/nisesh.Rate, out_2);
xlabel('Time');
ylabel('Voltage');
end

queueOutputData(nisesh,[-out_1' -out_1' out_2']);
nisesh.startForeground;
end
