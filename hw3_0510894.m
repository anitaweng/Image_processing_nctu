%%%%%%%%%%% load image %%%%%%%%%%%%%%%
Img=im2double(imread('Bird 1.tif'));
[m,n] = size(Img);
%%%%%%%%%%% padding %%%%%%%%%%%%%%%
pad = zeros(2*m,2*n);
pad(1:m,1:n) =Img;
%%%%%%%%%%% multiple -1^x+y %%%%%%%%%%%%%%%
neg = zeros(2*m,2*n);
for i = 1:2*m
    for j = 1:2*n
        neg_matrix(i,j) = (-1)^((i-1)+(j-1));
    end
end
neg = pad.*neg_matrix;
%%%%%%%%%%% DFT %%%%%%%%%%%%%%%
F = fft2(neg);
%%%%%%%%%%% Laplacian filter %%%%%%%%%%%%%%%
H = zeros(2*m,2*n);
for i = -1*m:m-1
    for j = -1*n:n-1
        H(i+m+1,j+n+1) = (i*i+j*j);
    end
end
normA = H ./ max(abs(H(:)));
%normA = -1.*normA;
%%%%%%%%%%% Output spectrum %%%%%%%%%%%%%%%
filt = normA.* F;
%%%%%%%%%%% Plot figure %%%%%%%%%%%%%%%
figure
imshow(abs(filt),[])
title('Fourier magnitude spectra after applying Laplacian filtering')
saveas(gcf,'Fourier after laplacian filter','png');

S2 = log(1+abs(filt));
figure
imshow(S2,[])
title('Fourier magnitude spectra after applying Laplacian filtering(using log scale)')
saveas(gcf,'Fourier after laplacian filter(using log)','png');

figure
imshow(abs(normA),[])
title('Figure of the Fourier magnitude of Laplacian filter H(u,v)')
saveas(gcf,'Laplacian filter H(u,v)','png');
%%%%%%%%%%% Inverse Fourier,decentering %%%%%%%%%%%%%%%
y = ifft2(filt);
idft = zeros(2*m,2*n);
for i = 1:2*m
    for j = 1:2*n
        idft(i,j) = real(y(i,j))*((-1)^((i-1)+(j-1)));
    end
end
result = idft(1:m,1:n);
%%%%%%%%%%% Plot figure %%%%%%%%%%%%%%%
figure
imshow(result)
title('Figure of the output image')
saveas(gcf,'Figure of the output image','png');

re = 255 * result;
figure
imshow(re)
title('Figure of the output image * 255')
saveas(gcf,'Figure of the output image_times_255','png');
%%%%%%%%%%% obtain largest 25 DFT %%%%%%%%%%%%%%%
temp = abs(filt);
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