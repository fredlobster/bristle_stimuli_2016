%% 02_08_2016 JCT
function sine_ao_func_02_2016(movement, num_cycles, frequency, length_on, length_off, plot_flag)
micron = 10/60;
amplitude = movement*micron;

s = daq.createSession('ni');
addAnalogOutputChannel(s,'Dev2',0,'Voltage');
s.Rate = 5000;
total_length = num_cycles*(length_on+length_off)+length_off;%% in ms

outputSignal = amplitude*sin(linspace(0,pi*2*(length_on/frequency*2),s.Rate*length_on)');

for ii =1:num_cycles
    outputSignal =  [outputSignal amplitude*ones(1,length_on/1000*s.Rate) zeros(1,length_off/1000*s.Rate)];
end 
    
if plot_flag == 1
plot((1:total_length)/s.Rate, outputSignal);
xlabel('Time');
ylabel('Voltage');
end

queueOutputData(s,[-outputSignal']);
s.startForeground;
clear s;
end