%%%%%%%%%%% load image %%%%%%%%%%%%%%%
Img=imread('Bird 1.tif');
%%%%%%%%%%% DFT %%%%%%%%%%%%%%%
F = fft2(Img,512,512);
%%%%%%%%%%% DFT magnitude %%%%%%%%%%%%%%%
S = abs(F);
%%%%%%%%%%% get the centered spectrume %%%%%%%%%%%%%%%
Fsh = fftshift(F);
%%%%%%%%%%% apply log transform %%%%%%%%%%%%%%%
S2 = log(1+abs(Fsh));
%%%%%%%%%%% plot fourier magnitude with log scale %%%%%%%%%%%%%%%
figure
imshow(S2,[]);title('log transformed Image')
saveas(gcf,'log transformed Image','png');
%%%%%%%%%%% plot phase spectrum after centering %%%%%%%%%%%%%%%
figure
imshow(angle(Fsh),[]),title('phase Image')
saveas(gcf,'phase Image','png');
%%%%%%%%%%% obtain largest 25 DFT %%%%%%%%%%%%%%%
temp = abs(Fsh);
linearIndexesOfMaxes = zeros(25,1);
Maxes = zeros(25,3);
for i = 1:25
    [maxValue, linearIndexes] = max(temp(:));
    Maxes(i,3) = maxValue;
    [rowsOfMaxes colsOfMaxes] = find(temp == maxValue);
    Maxes(i,1) = rowsOfMaxes(1,1);
    Maxes(i,2) = colsOfMaxes(1,1);
    temp(Maxes(i,1), Maxes(i,2)) = -inf;
end
