clc;
clear;

% Variables

% Import all sound files
% Signals = number_0 - number_9
% Noise = noise
% Carrier phrase = carrier_phrase
% Fs = 44100

file_path = '0.wav';
[number_0, Fs0] = audioread(file_path);

file_path = '1.wav';
[number_1, Fs1] = audioread(file_path);

file_path = '2.wav';
[number_2, Fs2] = audioread(file_path);

file_path = '3.wav';
[number_3, Fs3] = audioread(file_path);

file_path = '4.wav';
[number_4, Fs4] = audioread(file_path);

file_path = '5.wav';
[number_5, Fs5] = audioread(file_path);

file_path = '6.wav';
[number_6, Fs6] = audioread(file_path);

file_path = '7.wav';
[number_7, Fs7] = audioread(file_path);

file_path = '8.wav';
[number_8, Fs8] = audioread(file_path);

file_path = '9.wav';
[number_9, F9] = audioread(file_path);


% The digits
file_path = 'Carrier phrase.wav';
[carrier_phrase, FC] = audioread(file_path);

% Background noise file
file_path = 'Setswana_SSN_10s.wav';
[noise, FN] = audioread(file_path);

% SNR Change in dB - not needed???
snrChange = 2;

% Delays - Creates delays of length 200ms and 500ms at Fs 44100
Fs = 44100;
pause_200 = .2;
pause_500 = .5;

samples_200 = round(pause_200 * Fs);
samples_500 = round(pause_500 * Fs);

silent_200 = zeros(samples_200, 1);
silent_500 = zeros(samples_500, 1);

% Need to calculate the base SNR
snr_0 = 20 * log10(rms(number_0) / rms(noise));
snr_1 = 20 * log10(rms(number_1) / rms(noise));
snr_2 = 20 * log10(rms(number_2) / rms(noise));
snr_3 = 20 * log10(rms(number_3) / rms(noise));
snr_4 = 20 * log10(rms(number_4) / rms(noise));
snr_5 = 20 * log10(rms(number_5) / rms(noise));
snr_6 = 20 * log10(rms(number_6) / rms(noise));
snr_7 = 20 * log10(rms(number_7) / rms(noise));
snr_8 = 20 * log10(rms(number_8) / rms(noise));
snr_9 = 20 * log10(rms(number_9) / rms(noise));
snr_carrier = 20 * log10(rms(carrier_phrase) / rms(noise));

% Need to calculate the gain adjustment 

% Need to correct the signals to be at 10dB SNR

desired_dB = 10;
%Not used - for testing
target_dB = 10^(desired_dB / 20);

scaling_factor_0 = 10^((desired_dB - snr_0) / 20);
scaling_factor_1 = 10^((desired_dB - snr_1) / 20);
scaling_factor_2 = 10^((desired_dB - snr_2) / 20);
scaling_factor_3 = 10^((desired_dB - snr_3) / 20);
scaling_factor_4 = 10^((desired_dB - snr_4) / 20);
scaling_factor_5 = 10^((desired_dB - snr_5) / 20);
scaling_factor_6 = 10^((desired_dB - snr_6) / 20);
scaling_factor_7 = 10^((desired_dB - snr_7) / 20);
scaling_factor_8 = 10^((desired_dB - snr_8) / 20);
scaling_factor_9 = 10^((desired_dB - snr_9) / 20);
scaling_factor_carrier = 10^((desired_dB - snr_carrier) / 20);

% Need to correct the signals to be at 10dB SNR

scaled_number_0 = scaling_factor_0 * number_0;
scaled_number_1 = scaling_factor_1 * number_1;
scaled_number_2 = scaling_factor_2 * number_2;
scaled_number_3 = scaling_factor_3 * number_3;
scaled_number_4 = scaling_factor_4 * number_4;
scaled_number_5 = scaling_factor_5 * number_5;
scaled_number_6 = scaling_factor_6 * number_6;
scaled_number_7 = scaling_factor_7 * number_7;
scaled_number_8 = scaling_factor_8 * number_8;
scaled_number_9 = scaling_factor_9 * number_9;
scaled_carrier_phrase = scaling_factor_carrier * carrier_phrase;

% Final dB values of all sound files (All the same: -22.0412)

dB_0 = 20 * log10(rms(scaled_number_0));
dB_1 = 20 * log10(rms(scaled_number_1));
dB_2 = 20 * log10(rms(scaled_number_2));
dB_3 = 20 * log10(rms(scaled_number_3));
dB_4 = 20 * log10(rms(scaled_number_4));
dB_5 = 20 * log10(rms(scaled_number_5));
dB_6 = 20 * log10(rms(scaled_number_6));
dB_7 = 20 * log10(rms(scaled_number_7));
dB_8 = 20 * log10(rms(scaled_number_8));
dB_9 = 20 * log10(rms(scaled_number_9));

%{
%Testing
new_snr_0 = 20 * log10(rms(scaled_number_0) / rms(noise));
new_snr_1 = 20 * log10(rms(scaled_number_1) / rms(noise));
new_snr_2 = 20 * log10(rms(scaled_number_2) / rms(noise));
new_snr_3 = 20 * log10(rms(scaled_number_3) / rms(noise));
new_snr_4 = 20 * log10(rms(scaled_number_4) / rms(noise));
new_snr_5 = 20 * log10(rms(scaled_number_5) / rms(noise));
new_snr_6 = 20 * log10(rms(scaled_number_6) / rms(noise));
new_snr_7 = 20 * log10(rms(scaled_number_7) / rms(noise));
new_snr_8 = 20 * log10(rms(scaled_number_8) / rms(noise));
new_snr_9 = 20 * log10(rms(scaled_number_9) / rms(noise));
new_carrier_phrase = 20 * log10(rms(scaled_carrier_phrase) / rms(noise));
%}

% Variables for the testing loop
minimum_Presentations = 27;
reversals = 8;
% if == 2 (fail) if == -2 (pass)
previous_Result = 0;
% Modulates from initial dB of -22.0412
dB_all = -22.0412;
dB_modulated = -22.0412;

while minimum_Presentations ~= 0 && reversals ~= 0

    % Modulate all sound files 
    gain_all = 10^((dB_modulated - dB_all) / 20);
    % Prevent deleting the audio when traversing around the initial dB
    if gain_all == 0
        loop_scaled_number_0 = scaled_number_0;
        loop_scaled_number_1 = scaled_number_1;
        loop_scaled_number_2 = scaled_number_2;
        loop_scaled_number_3 = scaled_number_3;
        loop_scaled_number_4 = scaled_number_4;
        loop_scaled_number_5 = scaled_number_5;
        loop_scaled_number_6 = scaled_number_6;
        loop_scaled_number_7 = scaled_number_7;
        loop_scaled_number_8 = scaled_number_8;
        loop_scaled_number_9 = scaled_number_9;  
    else
        loop_scaled_number_0 = gain_all * scaled_number_0;
        loop_scaled_number_1 = gain_all * scaled_number_1;
        loop_scaled_number_2 = gain_all * scaled_number_2;
        loop_scaled_number_3 = gain_all * scaled_number_3;
        loop_scaled_number_4 = gain_all * scaled_number_4;
        loop_scaled_number_5 = gain_all * scaled_number_5;
        loop_scaled_number_6 = gain_all * scaled_number_6;
        loop_scaled_number_7 = gain_all * scaled_number_7;
        loop_scaled_number_8 = gain_all * scaled_number_8;
        loop_scaled_number_9 = gain_all * scaled_number_9;
    end
    
    % TEST
    %{
    disp(20*log10(rms(loop_scaled_number_0)));
    disp(20*log10(rms(loop_scaled_number_1)));
    disp(20*log10(rms(loop_scaled_number_2)));
    disp(20*log10(rms(loop_scaled_number_3)));
    disp(20*log10(rms(loop_scaled_number_4)));
    disp(20*log10(rms(loop_scaled_number_5)));
    disp(20*log10(rms(loop_scaled_number_6)));
    disp(20*log10(rms(loop_scaled_number_7)));
    disp(20*log10(rms(loop_scaled_number_8)));
    disp(20*log10(rms(loop_scaled_number_9)));
    disp(dB_modulated);
    disp(reversals);
    disp(minimum_Presentations);
    %}

    
    % Allows for the program to load all of the variables before output
    pause(1.5);
   
    % Randomly select 3 of the numbers
    potential_Numbers = {loop_scaled_number_0, loop_scaled_number_1, loop_scaled_number_2, loop_scaled_number_3, loop_scaled_number_4, loop_scaled_number_5, loop_scaled_number_6, loop_scaled_number_7, loop_scaled_number_8, loop_scaled_number_9};
    
    % Randomly select 3 filenames
    selected_Indices = randperm(10, 3);
    selected_Files = potential_Numbers(selected_Indices);
    
    first_Number = selected_Files{1};
    second_Number = selected_Files{2};
    third_Number = selected_Files{3};
    
    % Putting together the desired sound files
    test = [silent_500; scaled_carrier_phrase; silent_200; first_Number; silent_200; second_Number; silent_200; third_Number; silent_500];
    
    % Adjust the noise to the above length
    noise_adjusted = noise(1:length(test));
    
    % Add the noise to the numbers
    test_final = test + noise_adjusted;
    
    % Play it
    sound(test_final, Fs)

    % TESTING
    %
    disp('Selected: ');
    disp((selected_Indices-1));
    %

    % Prompt user for input
    user_Entry = input('Enter the three numbers that you heard (e.g. 1 2 3): ', 's');
    % Convert to number array
    user_Numbers = str2num(user_Entry);


    if isequal((selected_Indices-1), user_Numbers)
        disp('Correct, modulate -2');
        minimum_Presentations = minimum_Presentations - 1;

        %Check for reversal
        if previous_Result == +2
            reversals = reversals - 1;
        %else
            %reversals = 8;
        end

        previous_Result = -2;
        dB_modulated = dB_modulated - 2;
        

    else
        disp('Incorrect, modulate +2');
        minimum_Presentations = minimum_Presentations - 1;

        %Check for reversal
        if previous_Result == -2
            reversals = reversals - 1;
        %else
            %reversals = 8;
        end

        previous_Result = 2;
        dB_modulated = dB_modulated + 2;

    end


end






    