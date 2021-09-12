%%%%%%%%%%% load image %%%%%%%%%%%%%%%
Img=im2double(imread('image-pj7c.tif'));
[w, h, ch] = size(Img);
red = Img(:,:,1);
green = Img(:,:,2);
blue = Img(:,:,3);
super = 100;
s = sqrt(w*h/super);
c = 1;
T = 10;
%%%%%%%%%%% init m %%%%%%%%%%%%%%%
m = zeros(sqrt(super),5);
ti = 1;
for i = 1:s:w
    for j = 1:s:h
        m(ti,1:3) = Img(i+s-1,j+s-1,:);
        m(ti,4) = i+s-1;
        m(ti,5) = j+s-1;
        ti =ti+1;
    end
end
L = -1*ones(w,h);
d = Inf(w,h);
x = m(:,4);
y = m(:,5);
%%%%%%%%%%% do SLIC %%%%%%%%%%%%%%%
% for k = 1: super
%     while 1
%         for i = x(k)-1*s+1:x(k)+s
%             for j = y(k)-1*s+1:y(k)+s
%                 if i <= w && j <=h 
%                     dc = sqrt((Img(i,j,1)-m(k,1)).^2 + (Img(i,j,2)-m(k,2)).^2 + (Img(i,j,3)-m(k,3)).^2);
%                     ds = sqrt((i-m(k,4)).^2 + (j-m(k,5)).^2);
%                     D = sqrt(dc^2+c^2*(ds/s)^2);
%                     if D<d(i,j)
%                         d(i,j) = D;
%                         L(i,j) = k;
%                     end
%                 end
%             end
%         end
%         new_m = 1/(sum(sum(L==k))).*[sum(red(L==k)),sum(green(L==k)),sum(blue(L==k))];
%         E = 4*s*sqrt(sum((new_m - m(k,1:3)).^2));
%         if E < T
%             red(L==k) = new_m(1);
%             green(L==k) = new_m(2);
%             blue(L==k) = new_m(3);
%             break;
%         else
%             m(k,1:3) = new_m;
%         end
%     end
% end

% new_m = zeros(super,3);
new_m = zeros(super,5);
E = -Inf;
num=0;
ix = 1:w;
iy = 1:h;
ixx = repmat(ix,h,1);
iyy = repmat(iy',1,w);
while E < T
    for k = 1: super
        for i = x(k)-1*s+1:x(k)+s
            for j = y(k)-1*s+1:y(k)+s
                if i <= w && j <=h 
                    dc = sqrt((Img(i,j,1)-m(k,1)).^2 + (Img(i,j,2)-m(k,2)).^2 + (Img(i,j,3)-m(k,3)).^2);
                    ds = sqrt((i-m(k,4)).^2 + (j-m(k,5)).^2);
                    D = sqrt(dc^2+c^2*(ds/s)^2);
                    if D<d(i,j)
                        d(i,j) = D;
                        L(i,j) = k;
                    end
                end
            end
        end
%         new_m(k,:) = 1/(sum(sum(L==k))).*[sum(red(L==k)),sum(green(L==k)),sum(blue(L==k))];
        new_m(k,:) = 1/(sum(sum(L==k))).*[sum(red(L==k)),sum(green(L==k)),sum(blue(L==k)),sum(ixx(L==k)),sum(iyy(L==k))];
        
    end
%     E = sum(sqrt(sum((new_m - m(:,1:3)).^2,2)));
    E = sum(sqrt(sum((new_m - m(:,1:5)).^2,2)));
%     m(:,1:3) = new_m;
    m(:,1:5) = new_m;
    num =num+1;
end
for k = 1:super
    red(L==k) = m(k,1);
    green(L==k) = m(k,2);
    blue(L==k) = m(k,3);
end
%%%%%%%%%%% assign the final result %%%%%%%%%%%%%%%
result=zeros(w,h,3);
result(:,:,1)=red;
result(:,:,2)=green;
result(:,:,3)=blue;
%%%%%%%%%%% plot figure %%%%%%%%%%%%%%%
figure;
imshow(result) 
title([num2str(super) ' superpixel & c=' num2str(c)])
saveas(gcf,[num2str(super) ' superpixel & c=' num2str(c)],'png');

figure;
diff = Img-result;
imshow(diff);
title([num2str(super) ' superpixel & c=' num2str(c) ' origin-result difference'])
saveas(gcf,[num2str(super) ' superpixel & c=' num2str(c) ' origin-result difference'],'png');

