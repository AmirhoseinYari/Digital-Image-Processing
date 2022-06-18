clc
clear
close all

img1 = im2double(imread('Image1.png'));
img2 = im2double(imread('Image2.png'));
mask = im2double(imread('Mask.png'));

%imshow(blur(img1,10))
%%
sigmas = [1000, 600, 200, 100, 80, 60, 50, 40, 30, 20, 10];
final = zeros(size(img1));
for i=1:1:length(sigmas)-1
    sigma = sigmas(i);
    img1G = blur(img1,sigma);
    img2G = blur(img2,sigma);
    maskG = blur(mask,sigma);
    
    img1L = img1G - blur(img1,sigmas(i+1));
    img2L = img2G - blur(img2,sigmas(i+1));
    blendedL = img1L.*maskG + img2L.*(1-maskG);
    final = final + blendedL;
end
%for last one
img1G = blur(img1,sigmas(length(sigmas)));
img2G = blur(img2,sigmas(length(sigmas)));
maskG = blur(mask,sigmas(length(sigmas)));
img1L = img1G;
img2L = img2G;
blendedL = img1L.*maskG + img2L.*(1-maskG);
final = final + blendedL;
imshow(final)
imwrite(final,'Blended.png')

%%
function final = blur(img,sigma)
shape = size(img);
m=shape(1);
n=shape(2);

H = zeros(size(img));
for i=1:1:m
    for j=1:1:n
        H(i,j,:) = exp(((i-m/2)^2+(j-n/2)^2)/(-2*sigma^2));
    end
end
imgF = fftshift(fft2(img));
finalF = imgF.*H;
final = ifft2(ifftshift(finalF));
final = real(final);
end