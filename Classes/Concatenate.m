clc
clearvars
close all

%%
K = 0;

while true
    answer = questdlg('Would you like to add feature vector?', ...
        'Check', ...
        'Yes','No','Yes');
    % Handle response
    switch answer
        case 'Yes'
            disp('Adding feature vector.')
            K = K+1;
            
            NAME=uigetfile(' .mat' );
            if NAME==0
                break
            end
            load(NAME);
            Feature_HL(K,:)=Feature;
            N{K,:}=NAME(1:end-4);
            NAME(1:end-4)
        case 'No'
            disp('Adding feature vector is finished.')
            break
    end

end

save('Feature_HL.mat','Feature_HL');
save('Name.mat','N');