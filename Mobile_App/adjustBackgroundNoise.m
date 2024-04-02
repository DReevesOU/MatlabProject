clc;
clear;

%Import

    % Read all sound files
    
    file_path = '0.wav';
    [y0, Fs0] = audioread(file_path);
    
    file_path = '1.wav';
    [y1, Fs1] = audioread(file_path);
    
    file_path = '2.wav';
    [y2, Fs2] = audioread(file_path);
    
    file_path = '3.wav';
    [y3, Fs3] = audioread(file_path);
    
    file_path = '4.wav';
    [y4, Fs4] = audioread(file_path);
    
    file_path = '5.wav';
    [y5, Fs5] = audioread(file_path);
    
    file_path = '6.wav';
    [y6, Fs6] = audioread(file_path);
    
    file_path = '7.wav';
    [y7, Fs7] = audioread(file_path);
    
    file_path = '8.wav';
    [y8, Fs8] = audioread(file_path);
    
    file_path = '9.wav';
    [y9, F9] = audioread(file_path);

    file_path = 'Carrier phrase.wav';
    [c1, FC] = audioread(file_path);

    file_path = 'Setswana_SSN_10s.wav';
    [n1, FN] = audioread(file_path);


    
%     % Calculate the dB level
%     rms_value = rms(y);
%     dB_level = 20 * log10(rms_value);
% 
%     % Length of the file
%     duration_seconds = length(y) / Fs;
% 
%     disp(['Duration of the .wav file is: ' num2str(duration_seconds) ' seconds']);
%     
%     disp(['The dB level of the audio file is: ' num2str(dB_level) ' dB']);
%     
%     disp(['The sampling frequency of the audio file is: ' num2str(Fs) ' Hz']);
%     
%     % Play the adjusted audio file
%     sound(y, Fs);

% Goal 1: Need to create a defined static length before and after the audio
% file (why? to create delay between the words)

    % Duration of silence before and after the original file. [EX: 2 seconds]
    desired_duration_before = 2; 
    desired_duration_after = 2; 
    
    % Calculate the number of samples needed for the silence
    num_samples_before = round(desired_duration_before * Fs);
    num_samples_after = round(desired_duration_after * Fs);
    
    % Create arrays of zeros representing the silence
    silence_before = zeros(num_samples_before, size(y, 2)); 
    silence_after = zeros(num_samples_after, size(y, 2)); 
    
    % Concatenate the silence with the audio signal
    y_with_silence = [silence_before; y; silence_after];
    
    % Write the audio with silence to a new .wav file
    audiowrite('output_file_with_silence.wav', y_with_silence, Fs);
    
    %------------------------
    %sound(y_with_silence, Fs);
    %------------------------


% % %Goal 2: Need to create white noise at the same dB at the in-file
% % 
% %    % The length of the noise needs to be the length of the original .wav
% %    % plus the length of the silence before and after
% % 
% %    % duration_seconds + desired_duration_before + desired_duration_after
% % 
% %     duration = duration_seconds + desired_duration_before + desired_duration_after;
% % 
% %     % Frequency of the white noise will be the same as the imported file Fs
% % 
% %     white_noise = randn(duration * Fs, 1);
% % 
% %     rms_white_noise = rms(white_noise);
% % 
% %     % dB level will be dB_level
% % 
% %     dB_level_white_noise = 20 * log10(rms_white_noise);
% % 
% %     gain = 10^( (dB_level - dB_level_white_noise) / 20);
% % 
% %     wn_corrected = white_noise * gain;
% % 
% %     %------------------------
% %     %sound(wn_corrected, Fs);
% %     %------------------------
% 
% 
% 
%     %Checks
% 
%     wn_rms_corrected = rms(wn_corrected);
%     wn_dB_corrected = 20 * log10(wn_rms_corrected);
%     disp(['Adjusted white noise dB level: ' num2str(wn_dB_corrected) ' dB']);

%Goal 3: Modulate the dB of the voice number file based on success (1) or fail (2)
    
    y_adjusted = y;
    
    while true

        % Adjust the dB level based on user input
        shift_option = input('Enter 1 to decrease dB level by 2, or 2 to increase by 2 (3 to exit): ');
        if shift_option == 3
            disp('Exit Loop');
            break;
        elseif shift_option == 1
            desired_dB = dB_level - 2;
        elseif shift_option == 2
            desired_dB = dB_level + 2;
        else
            disp('Invalid input. No change in dB level.');
            desired_dB = dB_level;
        end
        
        % Gain needed to achieve the desired dB level
        gain = 10^((desired_dB - dB_level) / 20);
        
        % Adjust audio signal
        y_adjusted = y_adjusted * gain;
        
        % Check 
        rms_value_adjusted = rms(y_adjusted);
        dB_level_adjusted = 20 * log10(rms_value_adjusted);
        disp(['Adjusted dB level of the audio file: ' num2str(dB_level_adjusted) ' dB']);
        
        % Play to check
        %------------------------
        %sound(y_adjusted, Fs);
        %------------------------

    end



