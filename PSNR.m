function[psnr,mse]=PSNR(I,K)
% I=double(I);
% K=double(K);
if(I==K)
    psnr=100;
else
    [r]=length(I);
    d=0;
    for i=1:r
        d=d+(I(1,i)-K(1,i))^2;
    end
mse=d/(r);
mx=max(I(:));
psnr=10*log10(mx^2/mse);
end