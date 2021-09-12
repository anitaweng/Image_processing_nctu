%%%%%%%%%%% load image %%%%%%%%%%%%%%%
Img=im2double(imread('violet (color).tif'));
%%%%%%%%%%% determined H,S,I via formula2 %%%%%%%%%%%%%%%
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
min_rgb = zeros(1024,1024);
for i = 1:1024
    for j = 1:1024
        min_rgb(i,j) = min([R(i,j), G(i,j), B(i,j)]); 
    end
end
S = 1 - 3./ (R+G+B) .* min_rgb;
I = 1/3 .* (R+G+B);
H = zeros(1024,1024);
num = 0.5*((R - G) + (R - B)); 
den = sqrt((R - G).^2 + (R - B).*(G - B)); 
theta = acos(num./(den)); 
H = theta; 
H(B > G) = 2*pi - H(B > G); 
H = H/(2*pi); 
H(S==0)=0;

figure
imshow(H)
title('H')
saveas(gcf,'Hue','png');
figure
imshow(S)
title('S')
saveas(gcf,'Saturation','png');
figure
imshow(I)
title('I')
saveas(gcf,'Intensity','png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1 = [134.0, 51.0, 143.0];
a2 = [131.0, 132.0, 4.0];
R0 = 30;

rgb_Img = imread('violet (color).tif');
sphere_R = rgb_Img(:,:,1);
sphere_G = rgb_Img(:,:,2);
sphere_B = rgb_Img(:,:,3);
sphere_img_a1 = zeros(1024,1024,3);
sphere_img_a2 = zeros(1024,1024,3);
for i = 1:1024
    for j = 1:1024
        if (double(sphere_R(i,j))-a1(1))^2 + (double(sphere_G(i,j))-a1(2))^2 + (double(sphere_B(i,j))-a1(3))^2 > R0^2
            sphere_img_a1(i,j,:) = [0.5,0.5,0.5];
        else
            sphere_img_a1(i,j,:) = Img(i,j,:);
        end
    end
end

figure
imshow(sphere_img_a1)
title('Sphere-based color slicing a1 = [134,51,143]')
saveas(gcf,'Sphere-based color slicing a1 = [134,51,143]','png');

for i = 1:1024
    for j = 1:1024
        if (double(sphere_R(i,j))-a2(1))^2 + (double(sphere_G(i,j))-a2(2))^2 + (double(sphere_B(i,j))-a2(3))^2 > R0^2
            sphere_img_a2(i,j,:) = [0.5,0.5,0.5];
        else
            sphere_img_a2(i,j,:) = Img(i,j,:);
        end
    end
end

figure
imshow(sphere_img_a2)
title('Sphere-based color slicing a2 = [131,132,4]')
saveas(gcf,'Sphere-based color slicing a2 = [131,132,4]','png');
        
