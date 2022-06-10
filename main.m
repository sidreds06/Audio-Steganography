clc
clear all
[file path]=uigetfile('*.wav');
[y fs nbits]=wavread(file);
% wavplay(y(:,1),fs)

cover=y(:,1);
cover=cover';

% [ca cd]=lwt(cover,'haar');
[ca cd]=lwt(cover,'haar',3);

len=length(cd);

[textStr]=input('Enter Sec Text=');
binVector = str2bin(textStr);
binVector=binVector';

len1=length(binVector);
[key]=input('Enter sec key=');

[sec_key]=secret_key_generation_txt(len1,key);
% msg=[1 1 1 1 1 0 0 1 1 0 0 1 0 1 1 0 0]
binVector=xor(binVector,sec_key);


 for i=1:len1
     if(binVector(1,i)==0)
         new(1,i)=cd(1,i)+0.001;
     else
         new(1,i)=cd(1,i);
     end
        
 end
 
cd1=[new cd(len1+1:end)];
len2=length(cd1);
stego = ilwt(ca,cd1,'haar',3);
% [stego]=waverec(ca,cd2,'haar');
wavplay(stego,fs)
wavwrite(stego',fs,'stego.wav')
[stego fs nbits]=wavread('stego.wav');
stego=stego';

[ca2 cd2]=lwt(stego(1,:),'haar',3);
% [ca1 cd1]=lwt(stego,'haar');

for i=1:len1
        if(cd2(1,i)~=cd(1,i))
            recov_sec(1,i)=0;
        else
            recov_sec(1,i)=1;
        end
end

sec=xor(recov_sec,sec_key);
recov_sec=sec';

textStr = bin2str(recov_sec)

