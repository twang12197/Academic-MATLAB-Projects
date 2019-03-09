%Roomba_Adventure Project
%EF 230
%Tao Wang
clear all, clc, format compact, format long g, close all

r = roomba(24); % roomba robot
Roombakeycontrol(r); % activate key contorl
mode = 1; % 1 = robot on and 0 = robot off
Starting_hp = 100; % starting Hp
r.setLEDCenterColor(0); % set color to green.
health = int2str(Starting_hp); % convert int hp to a string
Hp = 'Hp: ';
Strhp = strcat(Hp,health) % String with current hp
bumper_flag = 0; % A count so hp will only be detucted once if bumper still pressed.
score = 100; % Starting score
speech_check = 0; % check if you died from cliff.
victory = 0; % checks if you clear the course.
%Song text for rockytop
text1 = 'T300,O5,KF#,KC#,A,A,A,A,B,B,A/2,F/2,D,T300,O5,KF#,KC#,D/2,D/2,D,E,E,D*4';

% Finish Adventure Speeches
win1 = 'You clear the journey with great efficency! Nicely done! Score:';
win2 = 'You clear the journey with decent efficency. Great job! Score:';
win3 = 'You barely clear the journey.... Try harder. Score:';
win4 = 'Are you even trying??? Even a monkey can do better than you! Score:';

%Cliff Death speech
cliffd = 'This is not GTA!!!! DRIVE BETTER!!! YOU KILLED EVERYONE! Score:';

while mode == 1
    S = r.getBumpers; % Reads Bumper.
    L = r.getLightBumpers; % Reads Light Bumper.
    C = r.getCliffSensors; % Reads Cliff sensor.
    
    %Read image
    img = r.getImage();
    img2 = img(200:300,150:250,:);
    
    %Analysis the cropped Image
    red_mean = mean(mean(img2(:,:,1)));% reads the mean amount of red pixels
    
    % Bumper code
    if bumper_flag == 0 && (S.front == 1 || S.left == 1 || S.right == 1)
        Starting_hp = Starting_hp - 10; % detuct hp for hitting an object.
        health = int2str(Starting_hp);
        hp = strcat(Hp,health)        
        bumper_flag = 1; % set bumper count to 1
    elseif S.front == 0 && S.left == 0 && S.right == 0 % condition to set bumper count to 0
        bumper_flag = 0; % set bumper count to 0.
    end
  
    % setting color according to hp
    if Starting_hp > 70
        r.setLEDCenterColor(0); % color is green for healthy hp.
    elseif Starting_hp >= 40 && Starting_hp <=70
        r.setLEDCenterColor(15); % color is yellow for low hp.
    elseif Starting_hp < 40
        r.setLEDCenterColor(255); % color is red for critical hp.
    end
    
    % Bumper Light Sensor code
    
    if bumper_flag == 0 && (L.left > 1000 || L.leftFront > 1000 || L.leftCenter > 1000 || L.rightCenter > 1000 || L.rightFront > 1000 || L.right > 1000)
        r.beep;
    end
    
        
    % Cliff Sensor code
    if C.left < 1500 || C.leftFront < 1500 || C.rightFront < 1500 || C.right < 1500
        close(1);
        Starting_hp = 0; % death from falling off the cliff.
        score = 0;
        strscore = int2str(score);
        death = strcat(cliffd,strscore); % Cliff death speech
        disp(death)
        speech_check = 1; % display death speech instead of victory speech.
        mode = 0; % leave while loop
    end
    
        
    % Death code
    if Starting_hp == 0
        close(1); %close robot control.
        score = score + Starting_hp;
        mode = 0; % leave while loop when robot dies.
    end
    
    % Victory code 
    if red_mean > 120
        close(1); %close robot control.
        score = score + Starting_hp;
        victory = 1; % to play the victory song.
        mode = 0; % leave while loop when robot dies.
    end
    score = score - 0.01;
end % end While loop

% play rockytop
if victory == 1
    r.songPlay(text1);
end

% display Gaming ending Speech according to the score
if score >= 186 && speech_check == 0
    strscore = int2str(score);
    win1s = strcat(win1,strscore);
    disp(win1s)
elseif score >= 165 && score < 186 && speech_check == 0
    strscore = int2str(score);
    win2s = strcat(win2,strscore);
    disp(win2s)
elseif score >= 120 && score < 165 && speech_check == 0
    strscore = int2str(score);
    win3s = strcat(win3,strscore);
    disp(win3s)
elseif score < 120 && speech_check == 0
    strscore = int2str(score);
    win4s = strcat(win4,strscore);
    disp(win4s)
end % end if statement