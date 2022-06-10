function varargout = Main_file(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_file_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_file_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Main_file_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Main_file_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

set(handles.figure1, 'pointer', 'watch')
drawnow;

[file path]=uigetfile('*.wav');
[y fs]=audioread(file);
sound(y(:,1),fs)
axes(handles.axes1)
specgram(y(:,1),1024,fs);
handles.y=y;
handles.fs=fs;

set(handles.figure1, 'pointer', 'arrow')

guidata(hObject, handles);


function edit2_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

set(handles.figure1, 'pointer', 'watch')
drawnow;
tic;
y=handles.y;
fs=handles.fs;
cover=y(:,1);
cover=cover';

% Sec Text handling
[textStr]=get(handles.edit1,'string');
binVector = str2bin(textStr);
binVector=binVector';

% Sec Key handling
len1=length(binVector);
[key]=get(handles.edit3,'string');
key=str2num(key);
[sec_key]=secret_key_generation_txt(len1,key);

% Encryption of Sec Msg
binVector=xor(binVector,sec_key);

% Wavelet Decomposition
level=1;
%level=str2num(level);
[ca cd]=lwt(cover,'haar',level);
len=length(cd);

% Embedding Process
for i=1:len1
     if(binVector(1,i)==0)
         new(1,i)=cd(1,i)+0.001;
     else
         new(1,i)=cd(1,i);
     end
        
end

cd1=[new cd(len1+1:end)];
len2=length(cd1);
stego = ilwt(ca,cd1,'haar',level);
sound(stego,fs)
axes(handles.axes2)
specgram(stego,1024,fs);

% Output parameters
%y1=y(:,1)';
%SNR = 20*log10(norm(y1) / norm (y1-stego(1,:)) );
%set(handles.edit5,'string',SNR)

%[psnr,mse]=PSNR(y1,stego(1,:));
%set(handles.edit8,'string',psnr)
%set(handles.edit9,'string',mse)

%set(handles.edit4,'string',len)

handles.stego=stego;
handles.cd=cd;
handles.len1=len1;
handles.key=key;
t=toc;
set(handles.edit10,'string',t)

set(handles.figure1, 'pointer', 'arrow')

global psnr mse len SNR

guidata(hObject, handles);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

stego=handles.stego;
fs=handles.fs;
stego=stego';
[file path]=uiputfile('*.wav');
audiowrite([path file],stego,fs)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

axes(handles.axes1);cla
axes(handles.axes2);cla
a=[];
set(handles.edit1,'string',a)
set(handles.edit2,'string',a)
set(handles.edit3,'string',a)
set(handles.edit4,'string',a)
set(handles.edit5,'string',a)

set(handles.edit8,'string',a)
set(handles.edit9,'string',a)
set(handles.edit10,'string',a)



function edit6_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

set(handles.figure1, 'pointer', 'watch')
drawnow;

[file path]=uigetfile('*.wav');
[y fs]=audioread(file);
sound(y(:,1),fs)
axes(handles.axes3)
specgram(y(:,1),1024,fs);
handles.y=y;
handles.fs=fs;

set(handles.figure1, 'pointer', 'arrow')


guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

set(handles.figure1, 'pointer', 'watch')
drawnow;



global psnr mse len SNR
%set(handles.edit14,'string',len)
%set(handles.edit15,'string',SNR)
%set(handles.edit16,'string',psnr)
%set(handles.edit17,'string',mse)

y=handles.y;
fs=handles.fs;
cd=handles.cd;
len1=handles.len1;
key=handles.key;

tic;

key1=get(handles.edit7,'string');
key1=str2num(key1);

if(key~=key1)% checking if key is not equal
    msgbox('Wrong key enter correct key','box')
    error('Wrong key enter correct key')
end

%level=get(handles.edit6,'string');
level=1;
%level=str2num(level);

y=y';
[ca2 cd2]=lwt(y(1,:),'haar',level);

for i=1:len1
        if(cd2(1,i)~=cd(1,i))
            recov_sec(1,i)=0;
        else
            recov_sec(1,i)=1;
        end
end



[sec_key]=secret_key_generation_txt(len1,key1);


sec=xor(recov_sec,sec_key);
recov_sec=sec';

textStr = bin2str(recov_sec);
%textStr='hEllo98';
set(handles.figure1, 'pointer', 'arrow')

t=toc;
set(handles.edit13,'string',t)

set(handles.text8,'string',textStr)
handles.textStr=textStr;
guidata(hObject, handles);



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

textStr=handles.textStr;
fidenc=fopen('Recovered Secrete Text.txt','w');
fprintf(fidenc,'%s',textStr)
fclose(fidenc)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)

axes(handles.axes3);cla
a=[];
set(handles.edit6,'string',a)
set(handles.edit7,'string',a)
set(handles.text8,'string',a)
set(handles.edit13,'string',a)
set(handles.edit14,'string',a)
set(handles.edit15,'string',a)
set(handles.edit16,'string',a)
set(handles.edit17,'string',a)

clc;
clear all;



function edit8_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
