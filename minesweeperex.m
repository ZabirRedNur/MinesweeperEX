% Minesweeper EX
% Date Started: 2/16/2016
% Date Completed: 2/24/2016
% Zabir Red Nur
% Created on Matlab 2015a

function minesweeperex

% Setting the default difficulty

global diffindex
diffindex = 1;


%The figure window

f1 = figure('units','normalized',...
    'position',[0 0 0.95 0.85],...
    'menubar','none',...
    'name','Minesweeper',...
    'resize','off',...
    'color','white',...
    'numbertitle','off');

movegui(f1,'center')

% The next 4 uicontrols create the main menu

% The game title

t1 = uicontrol('style','text',...
    'units','normalized',...
    'position',[0.35 0.798 0.25 0.1],...
    'string','MINESWEEPER',...
    'fontsize',32,...
    'backgroundcolor','white',...
    'visible','off');

tex = uicontrol('style','text',...
    'units','normalized',...
    'position',[0.594 0.818 0.044 0.08],...
    'string','EX',...
    'fontsize',32,...
    'backgroundcolor','red',...
    'foregroundcolor','white');

tcred = uicontrol('style','text',...
    'units','normalized',...
    'position',[0.25 0.7 0.5 0.05],...
    'string','By Zabir Red Nur',...
    'fontsize',12,...
    'backgroundcolor','white',...
    'visible','off');


% The Play button. Calls the cfplay function
% Creates the minefield playing area

b1 = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.4 0.50 0.2 0.05],...
    'string','Play',...
    'fontsize',12,...
    'visible','off',...
    'callback',@cfplay);

% The Options button. Calls the cfoptions function
% Opens an options menu that allows adjusting game properties

b2 = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.4 0.42 0.2 0.05],...
    'string','Options',...
    'fontsize',12,...
    'visible','off',...
    'callback',@cfoptions);

% The How to Play button. Calls the cfhowto function
% Gives player information about the game and how to play it

b3 = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.4 0.34 0.2 0.05],...
    'string','How To Play',...
    'fontsize',12,...
    'visible','off',...
    'callback',@cfhowto);

bex = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.4 0.26 0.2 0.05],...
    'string','EX Abilities',...
    'fontsize',12,...
    'visible','off',...
    'callback',@cfex);

% The quit button. Calls the cfquit button.
% Quits the game. (Ends the function)

b4 = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.4 0.10 0.2 0.05],...
    'string','Quit',...
    'fontsize',12,...
    'visible','off',...
    'callback',@cfquit);

% All buttons and texts in the main menu now set to visible-on

set(t1,'visible','on')
set(tcred,'visible','on')
set(b1,'visible','on')
set(b2,'visible','on')
set(b3,'visible','on')
set(bex,'visible','on')
set(b4,'visible','on')

try
    set(t1,'fontname','Century Gothic')
    set(tex,'fontname','Century Gothic')
    set(b1,'fontname','Century Gothic')
    set(b2,'fontname','Century Gothic')
    set(b3,'fontname','Century Gothic')
    set(bex,'fontname','Century Gothic')
    set(b4,'fontname','Century Gothic')
end

difficulties = [5 6 7 9 11 17];

% The function triggered by the Play button

    function cfplay(source,eventdata)
        
        % Shuffling random number generator with every new game
        rng('shuffle')
        
        %Turns everthing except the playing area invisible
        
        set(tcred,'visible','off')
        set(b1,'visible','off')
        set(b2,'visible','off')
        set(b3,'visible','off')
        set(bex,'visible','off')
        set(b4,'visible','off')
        
        % The back button. Returns to the main menu
        
        b12 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.4 0.10 0.2 0.05],...
            'string','Back',...
            'fontsize',12,...
            'visible','off',...
            'callback',@cfback12);
        
        try
            set(b12,'fontname','Century Gothic')
        end
        
        set(b12,'visible','on')
        
        
        % Starting of mineboard creation and play area setup
        
        % for testing
        %         n = inputdlg('Enter a difficulty (3-10)','Board Size',[1 40]);
        %         n = floor(str2double(n{1}));
        
        
        n = difficulties(diffindex);
        
        brdsz = round(n)^2;
        
        bmat = zeros(n);
        
        % Choosing number of bombs (nbs). 0.3 (30%) is the limit of nbs as boardsize
        % increases and can be changed here but not recommended. Number of
        % safe tiles (nst) also calculated
        
        nbs = floor(0.3*brdsz);
        nst = brdsz-nbs;
        
        
        % Placing bombs and markers. Locations chosen randomly and repititions
        % avoided in the next section
        
        rr = randi([1 n]);
        rc = randi([1 n]);
        bmat(rr,rc) = 255;
        
        for i = 2:nbs
            rr = randi([1 n]);
            rc = randi([1 n]);
            
            % Repetition is avoided *here*. If location is already a bomb, new random
            % numbers generated
            
            while (bmat(rr,rc) == 255)
                rr = randi([1 n]);
                rc = randi([1 n]);
            end
            bmat(rr,rc) = 255;
        end
        
        % Edge-of-board errors avoided with try statements
        
        for i = 1:n
            for j = 1:n
                try
                    if bmat(i+1,j) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                try
                    if bmat(i,j+1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                try
                    if bmat(i-1,j) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                try
                    if bmat(i,j-1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                try
                    if bmat(i+1,j+1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                try
                    if bmat(i-1,j-1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                
                try
                    if bmat(i+1,j-1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
                
                
                try
                    if bmat(i-1,j+1) >= 255
                        bmat(i,j) = bmat(i,j) + 1;
                    end
                end
            end
        end
        
        % Bomb locations also obtained surrounding bomb information. Bomb values
        % reset here. Display of bomb field for debugging and testing
        
        bmat(bmat>255) = 255;
        
        % disp(bmat)
        
        
        
        % The box positions are set up with reference to one large overall
        % playing area. The bottom corner of a box is defined along with
        % its width and height. Then, the width and height are set to
        % decrease with an increasing number of boxes. Variables are also
        % created to keep track of the number of rows and columns being
        % created. The pushbottons are contained in the UICELL cell and the
        % textboxes underneath them contain the minefield information and
        % are contained in the TXTCELL cell. Both are generated through two
        % dimensional looping
        
        posx = 0.35;
        posy = 0.25;
        bxw = 0.3/n;
        bxh = 0.5/n;
        rincr = 0;
        uicell = cell(n);
        txtcell = cell(n);
        alreadylost = 0;
        alreadywon = 0;
        
        % Text boxes get data from the board matrix (bmat) and print out
        % X if mine
        
        for i = n:-1:1
            cincr = 0;
            for j = 1:n
                mfnum = bmat(i,j);
                colr = [0 0 0];
                if isequal(mfnum,255)
                    mfnum = sprintf('X');
                    colr = [0.85 0 0];
                end
                
                
                txtcell{i,j} = uicontrol('style','text',...
                    'units','normalized',...
                    'foregroundcolor',colr,...
                    'string',mfnum,...
                    'fontsize',180/n,...
                    'position',[posx+cincr posy+rincr bxw bxh],...
                    'visible','on',...
                    'backgroundcolor',[0.96 0.96 0.96]);
                
                % Pushbuttons have two callback functions. Clicking turns
                % visibility off therefore revealing the textbox
                % underneath. Right clicking turns box orange.
                % Left click functionality achieved by cfmf function.
                % Right click functionality achieved by chngclr function.
                
                % bxnm = sprintf('%d,%d',i,j);
                uicell{i,j} = uicontrol('units','normalized',...
                    'position',[posx+cincr posy+rincr bxw bxh],...
                    'visible','on',...
                    'callback',@cfmf,...
                    'buttondownfcn',@chngclr,...
                    'userdata',[bmat(i,j),i,j]);
                
                try
                    set(txtcell{i,j},'fontname','Century Gothic')
%                     set(uicell{i,j},'fontname','Century Gothic')  
                end
                
                cincr = cincr+bxw;
            end
            rincr = rincr+bxh;
        end
        
        %Safe block marker
        
        sbr = randi([1 n]);
        sbc = randi([1 n]);
        
        while (uicell{sbr,sbc}.UserData(1) == 255)
        sbr = randi([1 n]);
        sbc = randi([1 n]);
        end
        
        set(uicell{sbr,sbc},'backgroundcolor',[0 0.74 0])
        
        
        % Game end messages, loss and win
        
%         gloss = sprintf('You Triggered a Mine\n  XX  Game Over  XX');
%         gwin = sprintf('You Cleared the Minefield\n     !! You Win !!');

          gloss = sprintf('DEFEAT');
          gwin = sprintf('VICTORY');
          

%         diff1 = 'Beginner';
%         diff2 = 'Experienced';
%         diff3 = 'Challenging';
%         diff4 = 'Hard';
%         diff5 = 'Very Hard';
%         diff6 = 'Impossible';

switch diffindex
    case 1
        diffnm = ' Beginner';
    case 2
        diffnm = 'Experienced';
    case 3
        diffnm = 'Challenging';
    case 4
        diffnm = '  Hard';
    case 5
        diffnm = 'Very Hard';
    case 6
        diffnm = 'Impossible';
end
        gdiff = sprintf('Difficulty:\n%s',diffnm);
        
        
        % Win or Loss message
        
        t2 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.73 0.37 0.18 0.1],...
            'fontsize',34,...
            'backgroundcolor','white',...
            'visible','off');
        
        % Difficulty Indicator
        
        tdiff = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.77 0.64 0.1 0.1],...
            'string',gdiff,...
            'fontsize',12,...
            'backgroundcolor','white',...
            'visible','on');
        
        % EX Ability Heading
        
        texind1 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.136 0.70 0.02 0.034],...
            'string','EX',...
            'fontsize',12,...
            'backgroundcolor','red',...
            'foregroundcolor','white',...
            'visible','on');
        texind2 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.158 0.70 0.05 0.034],...
            'string','Abilities',...
            'fontsize',12,...
            'backgroundcolor','white',...
            'visible','on');
        
        
        % Detect Ability pushbutton
        
        a1 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.13 0.55 0.08 0.06],...
            'string','Detect',...
            'fontsize',10,...
            'foregroundcolor',[0.6 0.6 0.6],...
            'visible','on',...
            'enable','inactive',...
            'callback',@cfdet);
        
        % Diffuse Ability pushbutton
        
        a2 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.13 0.4 0.08 0.06],...
            'backgroundcolor',[0.94 0.94 0.94],...
            'string','Diffuse',...
            'fontsize',10,...
            'visible','on',...
            'callback',@cfdfs);
       
        try
            set(t2,'fontname','Century Gothic')
            set(tdiff,'fontname','Century Gothic')
            set(texind1,'fontname','Century Gothic')
            set(texind2,'fontname','Century Gothic')
            set(a1,'fontname','Century Gothic')
            set(a2,'fontname','Century Gothic')
        end
        
                
        % Setting the counter for presses until detect
        pud = 0;
        
        % Callback function for Detect button
        function cfdet(source,eventdata)
            set(source,'enable','inactive','foregroundcolor',[0.6 0.6 0.6])
            
            % Randomly Selected Safe block marker
            
            sbr = randi([1 n]);
            sbc = randi([1 n]);
            srchcount = 1;
            
            while ((uicell{sbr,sbc}.UserData(1) == 255) || (strcmpi(uicell{sbr,sbc}.Visible,'off'))) && srchcount<=1000
                sbr = randi([1 n]);
                sbc = randi([1 n]);
                srchcount = srchcount+1;
            end
            
            if srchcount > 1000
                ertxt = uicontrol('style','text',...
                    'units','normalized',...
                    'position',[0.08 0.48 0.2 0.06],...
                    'string','No Safe Blocks Detected...',...
                    'fontsize',14,...
                    'backgroundcolor','white',...
                    'visible','on')
                try
                    set(ertxt,'fontname','Century Gothic')
                end
                
                pause(2)
                set(ertxt,'visible','off')
            end
            
            set(uicell{sbr,sbc},'backgroundcolor',[0 0.74 0])
            
            pud = 0;
        end
        
        % Setting counter for presses until Diffuse
        pudfs = 0;
        
        %Callback function for Diffuse button
        function cfdfs(source,eventdata)
            if isequal(source.BackgroundColor,[0.94 0.94 0.94])
                set(source,'backgroundcolor',[0.45 1 0],'foregroundcolor','black')
                pudfs = 0;
            else
                set(source,'backgroundcolor',[0.94 0.94 0.94])
            end
        end
        
        % Function to turn minefield pushbutton invisible
        % Also decrements number of safe tiles by 1 (nst)
        
        function cfmf(source,eventdata)
            blockdata = get(source,'userdata');
            minestatus = blockdata(1);
            
            if isequal(a2.BackgroundColor,[0.45 1 0]) && (minestatus==255)
                set(source,'backgroundcolor',[1 0.23 0])
                set(a2,'backgroundcolor',[0.94 0.94 0.94],'foregroundcolor',[0.6 0.6 0.6])
                set(a2,'enable','inactive')
            else
                
                if isequal(a2.BackgroundColor,[0.45 1 0])
                    set(a2,'backgroundcolor',[0.94 0.94 0.94],'foregroundcolor',[0.6 0.6 0.6])
                    set(a2,'enable','inactive')
                end
                
                set(source,'visible','off')
                nst = nst - 1;
                pud = pud + 1;
                pudfs = pudfs + 1;
                if (minestatus == 255) && (alreadywon ~= 1)
                    set(t2,'string',gloss,'visible','on','backgroundcolor','black','foregroundcolor','white')
                    alreadylost = 1;
                elseif (nst == 0) && (alreadylost ~= 1)
                    set(t2,'string',gwin,'visible','on','backgroundcolor',[0 0.74 0],'foregroundcolor','white')
                    alreadywon = 1;
                end
                
                if (strcmpi(a1.Enable,'inactive')) & (pud>=6)
                    set(a1,'foregroundcolor',[0 0 0],'enable','on')
                    pud = 0;
                end
                
                if (strcmpi(a2.Enable,'inactive')) & (pudfs>=10)
                    set(a2,'foregroundcolor',[0 0 0],'enable','on')
                    pudfs = 0;
                end
                
            end
        end
        
        % Function to change color of minefield pushbutton
        
        function chngclr(source,eventdata)
            bxclr = get(source,'backgroundcolor');
            if isequal(bxclr,[0.94 0.94 0.94])
                set(source,'backgroundcolor',[1 0.23 0])
            elseif isequal(bxclr,[1 0.23 0])
                set(source,'backgroundcolor',[0.94 0.94 0.94])
            end
        end
        
        
        % End of mineboard creation and play area setup
        
        % Defining back button's function inside the playing area. Two
        % dimensional looping used to turn all mine texts and pushbuttons
        % invisible
        
        function cfback12(source,eventdata)
            set(b12,'visible','off')
            set(t2,'visible','off')
            set(tdiff,'visible','off')
            set(texind1,'visible','off')
            set(texind2,'visible','off')
            set(a1,'visible','off')
            set(a2,'visible','off')
            set(tcred,'visible','on')
            set(b1,'visible','on')
            set(b2,'visible','on')
            set(b3,'visible','on')
            set(bex,'visible','on')
            set(b4,'visible','on')
            for ci = 1:n
                for cj = 1:n
                    set(uicell{ci,cj},'visible','off')
                    set(txtcell{ci,cj},'visible','off')
                end
            end
            
        end
        
    end


% Function for options menu functionality

    function cfoptions(source,eventdata)
        
        % Turn main menu invisible
        
        set(tcred,'visible','off')
        set(b1,'visible','off')
        set(b2,'visible','off')
        set(b3,'visible','off')
        set(bex,'visible','off')
        set(b4,'visible','off')
        
        % Create title 'Choose Difficulty'
        
        t3 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.4 0.6 0.2 0.05],...
            'string','Choose Difficulty',...
            'fontsize',14,...
            'backgroundcolor','white',...
            'visible','off');
        
        % Difficulty Level Strings placed in popup menu
        
        diff1 = 'Beginner';
        diff2 = 'Experienced';
        diff3 = 'Challenging';
        diff4 = 'Hard';
        diff5 = 'Very Hard';
        diff6 = 'Impossible';
        
        pop1 = uicontrol('style','popupmenu',...
            'units','normalized',...
            'position',[0.42 0.5 0.16 0.05],...
            'string',{diff1 diff2 diff3 diff4 diff5 diff6},...
            'fontsize',12,...
            'visible','off',...
            'horizontalalignment','center',...
            'callback',@cfdiff);
        
        set(pop1,'value',diffindex)
        
        % Back button to return to main menu along with its function
        
        b21 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.4 0.10 0.2 0.05],...
            'string','Back',...
            'fontsize',12,...
            'visible','off',...
            'callback',@cfback21);
        
        try
            set(t3,'fontname','Century Gothic')
            set(pop1,'fontname','Century Gothic')
            set(b21,'fontname','Century Gothic')
        end
        
        set(t3,'visible','on')
        set(pop1,'visible','on')
        set(b21,'visible','on')
        

        % Setting Difficulty
        
        function cfdiff(source,eventdata)
            diffindex = get(pop1,'value');
        end
        
        function cfback21(source,eventdata)
            set(pop1,'visible','off')
            set(b21,'visible','off')
            set(t3,'visible','off')
            set(tcred,'visible','on')
            set(b1,'visible','on')
            set(b2,'visible','on')
            set(b3,'visible','on')
            set(bex,'visible','on')
            set(b4,'visible','on')
            
        end
        
    end

% Function for how to play button and corresponding back button

    function cfhowto(source,eventdata)
        
        set(tcred,'visible','off')
        set(b1,'visible','off')
        set(b2,'visible','off')
        set(b3,'visible','off')
        set(bex,'visible','off')
        set(b4,'visible','off')
        
        howtotext = sprintf('In the wake of a terrible war, you have been tasked with clearing out minefields so that the citizens can populate the lands once again. Armed with a mine detector, you must mark the mine locations so that the dig team can safely dispose of them. But BEWARE! Step over a mine and it will explode! Your only hope is to check the signal strength from blocks surrounding a mine.\n\nTo check a block, left-click on it. If that block is not a mine, it reveals the number of mines surrounding it.\nFor example: If a blocks shows 1, it means only one of the 8 adjacent blocks contains a mine. If the block reads 8, you better leave all adjacent blocks alone!\nIf you suspect a block of containing a mine, right-click on it to turn it red. This will help you visually mark suspected mine spots. Right-clicking again returns the block to its normal color.\nIf you step over a mine, you lose the game. Press "Back" to return to the main menu. From here, you can change the difficulty by going to the "Options" menu, or start a new game by pressing "Play".   Happy Mining!');

        
        t4 = uicontrol('style','text',...
            'string',howtotext,...
            'units','normalized',...
            'position',[0.15 0.25 0.7 0.5],...
            'backgroundcolor','white',...
            'fontsize',11,...
            'horizontalalignment','left');
        
        try
            set(t4,'fontname','Century Gothic')
        end
        
        b32 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.4 0.10 0.2 0.05],...
            'string','Back',...
            'fontsize',12,...
            'visible','off',...
            'callback',@cfback32);
        
        try
            set(b32,'fontname','Century Gothic')
        end
        
        
        set(b32,'visible','on')
        
        function cfback32(source,eventdata)
            set(b32,'visible','off')
            set(t4,'visible','off')
            set(tcred,'visible','on')
            set(b1,'visible','on')
            set(b2,'visible','on')
            set(b3,'visible','on')
            set(bex,'visible','on')
            set(b4,'visible','on')
            
        end
        
    end

% Function for how to play button and corresponding back button

    function cfex(source,eventdata)
        
        set(tcred,'visible','off')
        set(b1,'visible','off')
        set(b2,'visible','off')
        set(b3,'visible','off')
        set(bex,'visible','off')
        set(b4,'visible','off')
        
        exabilitiestext = sprintf('As a trained minesweeper, you possess some unique abilites. However,these abilities are difficult to use and you can only call upon them once every several blocks.\n\n\nYour intuition guides you to a safe block the first time you enter a minefield. This is a passive ability.\n\nFrom past experience, you can predict the location of one mine in the field. Every time you detect a mine this way, you must reveal six more safe locations before you can detect another mine.\n\nDeploy you bomb diffusal team to dig one block. If it is a mine, the team will mark it and it will not explode. You must reveal ten more safe locations before your bomb diffusal team has restocked and is ready to dig once again.');

        
        t5 = uicontrol('style','text',...
            'string',exabilitiestext,...
            'units','normalized',...
            'position',[0.19 0.25 0.644 0.5],...
            'backgroundcolor','white',...
            'fontsize',11,...
            'horizontalalignment','left');
        
        t51 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.199 0.57 0.06 0.038],...
            'fontsize',14,...
            'string','Intuition',...
            'backgroundcolor','red',...
            'foregroundcolor','white');
                
        t52 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.199 0.45 0.06 0.038],...
            'fontsize',14,...
            'string','Detect',...
            'backgroundcolor','red',...
            'foregroundcolor','white');
        
        t53 = uicontrol('style','text',...
            'units','normalized',...
            'position',[0.199 0.33 0.06 0.038],...
            'fontsize',14,...
            'string','Diffuse',...
            'backgroundcolor','red',...
            'foregroundcolor','white');
        
        try
            set(t5,'fontname','Century Gothic')
            set(t51,'fontname','Century Gothic')
            set(t52,'fontname','Century Gothic')
            set(t53,'fontname','Century Gothic')
        end
        
        b42 = uicontrol('style','pushbutton',...
            'units','normalized',...
            'position',[0.4 0.10 0.2 0.05],...
            'string','Back',...
            'fontsize',12,...
            'visible','off',...
            'callback',@cfback42);
        
        try
            set(b42,'fontname','Century Gothic')
        end
        
        
        set(b42,'visible','on')
        
        function cfback42(source,eventdata)
            set(b42,'visible','off')
            set(t5,'visible','off')
            set(t51,'visible','off')
            set(t52,'visible','off')
            set(t53,'visible','off')
            set(tcred,'visible','on')
            set(b1,'visible','on')
            set(b2,'visible','on')
            set(b3,'visible','on')
            set(bex,'visible','on')
            set(b4,'visible','on')
            
        end
        
    end


% Function to quit the game, set to Quit button in main menu

    function cfquit(source,eventdata)
        close
    end

end