close all;
clear all;
clc;
%%%%%%%%%%% load image %%%%%%%%%%%%%%%
im = im2double(imread('image-pj4 (motion blurring).tif'));
%im = im2double(imread('image-pj4 (motion blurring)_origin.tif'));
%im = imread('image-pj4 (motion blurring).tif');
%%%%%%%%%%% create u,v for H centering value %%%%%%%%%%%%%%%
[m n] = size(im); 
s= [linspace(-256,-1,256), linspace(1,256,256)];
[v u] = meshgrid(s);
T = 1;
a = -0.019;
b = 0;
temp = pi * (a*u + b*v);
H = (T./temp) .* sin(temp) .* exp(-1i.*temp);
%%%%%%%%%%% DFT and decide linear-motion degradation %%%%%%%%%%%%%%%
G = fft2(im);
Fsh = fftshift(G);
%F = Fsh ./ H;
%K = 0.0032;
%F = G ./H;
%W = 1 ./ H .* ((abs(H).^2)./((abs(H).^2) + K));
F = Fsh ./H;
%%%%%%%%%%% show image %%%%%%%%%%%%%%%
S2 = log(1+abs(Fsh));
filt = ifftshift(F);
y = ifft2(filt);
figure
imshow(abs(Fsh))
title('Figures of the Fourier magnitude spectra of the degraded image')
saveas(gcf,'degraded image','png');

figure
imshow(abs(S2),[])
title('Fourier magnitude spectra of the degraded image(log & normalize)')
saveas(gcf,'degraded image(log)','png');

%figure
%imshow(abs(S2),[])%normalize of original image

figure
imshow(abs(H))
title('Figure of the Fourier magnitude of degradation model H(u,v)')
saveas(gcf,'H(u,v)','png');

figure
imshow(uint8(y*255))
title('Figure of the output image')
saveas(gcf,'output','png');
