%%%%%%%%%%% load image %%%%%%%%%%%%%%%
Img=im2double(imread('image-pj6(Canny).tif'));
%%%%%%%%%%% gaussian %%%%%%%%%%%%%%%
[w,h] = size(Img);
sig = min([w,h]) * 0.005;
x = floor(-3*sig):ceil(3*sig);
y = floor(-3*sig):ceil(3*sig);
y = repmat(y,19,1);
x = repmat(x',1,19);
G = exp((-0.5*x.^2 -0.5*y.^2)./sig^2);
%G = exp(-0.5*x.^2 /sig^2);
% G = G./sum(G);%scale to range [0,1]
%dGx = -x.*G/sig^2;
%dGy = -y.*G/sig^2;
sobel_x = [-1,-2,-1;0,0,0;1,2,1];
sobel_y = [-1,0,1;-2,0,2;-1,0,1];
sxg = conv2(Img, G ,'same');
syg = conv2(Img, G ,'same');
sxg = sxg./sum(sum(G));
syg = syg./sum(sum(G));
sx = conv2(sxg, sobel_x ,'same');
sy = conv2(syg, sobel_y ,'same');
sx = -1.*sx;
sy = -1.*sy;
% sxg = imfilter(Img, G );
% syg = imfilter(Img, G );
% s=fspecial('sobel');
% sx=imfilter(sxg,sobel_x,'same');    
% % s=s';
% sy=imfilter(syg,sobel_y,'same'); 
% for i=1:w-2
%     for j=1:h-2
%         %Gradient operations
%         Gx=sum(sum(sobel_x.*sxg(i:i+2,j:j+2)));
%         Gy=sum(sum(sobel_y.*syg(i:i+2,j:j+2)));
%                
%         %Magnitude of vector
%          Mag(i+1,j+1)=sqrt(Gx.^2+Gy.^2);
%        
%     end
% end

% dGx=conv2(G, sobel_x ,'same');
% dGy=conv2(G, sobel_y ,'same');
% sx = conv2(Img, dGx ,'same');
% sy = conv2(Img, dGy ,'same');
%%%%%%%%%%% compute the gradient and the magnitude %%%%%%%%%%%%%%%
Mag = sqrt( sx.^2 + sy.^2 );
Angle = atan2(sy, sx) * (180.0/pi);
figure;
imshow(Mag,[])
title('Gradient magnitude')
saveas(gcf,'Gradient magnitude','png');
figure;
imshow(Angle,[])
title('Gradient angle')
saveas(gcf,'Gradient angle','png');
%%%%%%%%%%% define d %%%%%%%%%%%%%%%
% x and x+pi are the sam categories
a = Angle < 0;
Angle = Angle + 180.0*a;
dmap = zeros(w,h);
d = [-inf 22.5 67.5 112.5 157.5 inf];
dmap((Angle >= d(1) & Angle < d(2)) | (Angle >= d(5) & Angle < d(6)))=1;
dmap(Angle >= d(2) & Angle < d(3))=2;
dmap(Angle >= d(3) & Angle < d(4))=3;
dmap(Angle >= d(4) & Angle < d(5))=4;

% for i =1:w
%     for j = 1:h
%         if (Angle(i,j) >= d(1) && Angle(i,j) < d(2)) || (Angle(i,j) >= d(5) && Angle(i,j) < d(6))
%             dmap(i,j)=1;
%         elseif Angle(i,j) >= d(2) && Angle(i,j) < d(3)
%             dmap(i,j)=2;
%         elseif Angle(i,j) >= d(3) && Angle(i,j) < d(4)
%             dmap(i,j)=3;
%         else
%             dmap(i,j)=4;
%         end
%     end
% end
            

% d = [-inf 45.0 90.0 135.0 inf];
% dmap((Angle >= d(1) & Angle < d(2)))=1;
% dmap(Angle >= d(2) & Angle < d(3))=2;
% dmap(Angle >= d(3) & Angle < d(4))=3;
% dmap(Angle >= d(4) & Angle < d(5))=4;

%gn
gn = zeros(w,h);
temp = zeros(w+2,h+2);
temp(2:w+1,2:h+1)=dmap;
tempMag = zeros(w+2,h+2);
tempMag(2:w+1,2:h+1)=Mag;
for i = 2:w+1
    for j = 2:h+1
        m = 0;
        n = 0;
%         if temp(i,j)==temp(i-1,j-1) && m < tempMag(i-1,j-1)
%             m = tempMag(i-1,j-1);
%         end
%         if temp(i,j)==temp(i-1,j) && m < tempMag(i-1,j)
%             m = tempMag(i-1,j);
%         end
%         if temp(i,j)==temp(i-1,j+1) && m < tempMag(i-1,j+1)
%             m = tempMag(i-1,j+1);
%         end
%         if temp(i,j)==temp(i,j-1) && m < tempMag(i,j-1)
%             m = tempMag(i,j-1);
%         end
%         if temp(i,j)==temp(i,j+1) && m < tempMag(i,j+1)
%             m = tempMag(i,j+1);
%         end
%         if temp(i,j)==temp(i+1,j-1) && m < tempMag(i+1,j-1)
%             m = tempMag(i+1,j-1);
%         end
%         if temp(i,j)==temp(i+1,j) && m < tempMag(i+1,j)
%             m = tempMag(i+1,j);
%         end
%         if temp(i,j)==temp(i+1,j+1) && m < tempMag(i+1,j+1)
%             m = tempMag(i+1,j+1);
%         end
        
        if temp(i,j)==1
            m = tempMag(i-1,j);
            n = tempMag(i+1,j);
        elseif temp(i,j)==2
            m = tempMag(i-1,j-1);
            n = tempMag(i+1,j+1);
        elseif temp(i,j)==3
            m = tempMag(i,j-1);
            n = tempMag(i,j+1);
        elseif temp(i,j)==4
            m = tempMag(i-1,j+1);
            n = tempMag(i+1,j-1);
        end
        
        
        if tempMag(i,j) >= max([n m])
            gn(i-1,j-1) = tempMag(i,j);
        else
            gn(i-1,j-1) = 0;
        end
    end
end

TH = 0.1;
TL = 0.04;
gnh = zeros(w,h);
gnl = zeros(w,h);
% gn = gn./max(max(gn));
gnh(gn>=TH) = gn(gn>=TH);
gnl(TH > gn & gn >= TL) = gn(TH > gn & gn >= TL);
figure;
imshow(gnl,[]) 
title('gnL')
saveas(gcf,'gnL','png');
figure;
imshow(gnh,[]) 
title('gnH')
saveas(gcf,'gnH','png');
e =zeros(w,h);
temp_gnl=zeros(w+2,h+2);
temp_gnl(2:w+1,2:h+1)=gnl;
for i = 2:w+1
    for j = 2:h+1
        if gnh(i-1,j-1) > 0
            e(i-1,j-1)=1;
            if temp_gnl(i-1,j-1) > 0
                e(i-1-1,j-1-1)=1;
            end
            if temp_gnl(i-1,j) > 0
                e(i-1-1,j-1)=1;
            end
            if temp_gnl(i-1,j+1) > 0
                e(i-1-1,j+1-1)=1;
            end
            if temp_gnl(i,j-1) > 0
                e(i-1,j-1-1)=1;
            end
            if temp_gnl(i,j+1) > 0
                e(i-1,j+1-1)=1;
            end
            if temp_gnl(i+1,j-1) > 0
                e(i+1-1,j-1-1)=1;
            end
            if temp_gnl(i+1,j) > 0
                e(i+1-1,j-1)=1;
            end
            if temp_gnl(i+1,j+1) > 0
                e(i+1-1,j+1-1)=1;
            end
        end 
    end
end
figure;
imshow(e) 
title('Final edge map')
saveas(gcf,'Final edge map','png');







