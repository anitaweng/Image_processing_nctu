%%%%%%%%%%% load image %%%%%%%%%%%%%%%
I = imread('camellia (mono) 512x512.tif');
%%%%%%%%%%% plot image and its histogram %%%%%%%%%%%%%%%
figure
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imhist(I)
saveas(gcf,'origin','png');
%%%%%%%%%%% calculate the number of every gray level %%%%%%%%%%%%%%%
[nk,rk]=imhist(I);
%%%%%%%%%%% turn the number into probability and calculate its cdf %%%%%%%%%%%%%%%
pr=nk/(512*512);
sk=zeros(256,1);
for i =1:256
    if i==1
        sk(i)=pr(i);
    else
        sk(i)=sk(i-1)+pr(i);
    end
end
%%%%%%%%%%% define the expected spec. %%%%%%%%%%%%%%%
pz=zeros(256,1);
pz(1:64)=1248/(512*512);
pz(193:256)=1248/(512*512);
pz(65:192)=800/(512*512);
vn=zeros(256,1);
for i =1:256
    if i==1
        vn(i)=pz(i);
    else
        vn(i)=vn(i-1)+pz(i);
    end
end
%%%%%%%%%%% histogram equalization %%%%%%%%%%%%%%%
startfrom=ones(256,1);
%%% create table of transformation function %%%
for i =1:256
    if i==1
        for j=1:256
            if vn(j)>=sk(i)
                startfrom(i)=j;
                break;
            end
        end
    else
        for j=startfrom(i-1):256
            if vn(j)>=sk(i)
                startfrom(i)=j;
                break;
            end
        end
    end
end
% Since matlab index starts from 1, and the gray level starts from 0, so minus 1
realgraylevel=startfrom-1; 
%%%%%%%%%%% transfrom the image %%%%%%%%%%%%%%%
transfer_image=zeros(512,512);
for i=1:512
    for j=1:512
       transfer_image(i,j)=realgraylevel(I(i,j)+1);
    end
end 
%%%%%%%%%%% plot the resulted image and its histogram %%%%%%%%%%%%%%%
figure
subplot(1,2,1)
imshow(transfer_image,[0 255]);
subplot(1,2,2)
imhist(uint8(transfer_image));
saveas(gcf,'transferred','png');
