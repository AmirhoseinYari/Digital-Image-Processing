clc
clear
close all

%% a 
figure
for i = 130:10:512
    tic
    s = i; %size
    x = zeros(s);
    x(s/2-64:s/2+64,s/2-64:s/2+64) = 1;

    y = x;

    z = conv2(x,y,'same');
    n = (i-130)/10+1;
    t(n) = toc;
    size(n) = s;
end
subplot(1,2,1)
plot(size,t)
title('time(size) :')
xlabel('size')
ylabel('time(s)')

%% c
for i = 130:10:512
    tic
    s = i; %size
    x = zeros(s);
    x(s/2-64:s/2+64,s/2-64:s/2+64) = 1;

    y = x;

    z = myconv(x,y);
    n = (i-130)/10+1;
    myt(n) = toc;
    size(n) = s;
end
subplot(1,2,2)
plot(size,myt)
title('my conv time(size) :')
xlabel('size')
ylabel('time(s)')

%%
function z = myconv(x,y)
    X = fft2(x);
    X = fftshift(X);
    Y = fft2(y);
    Y = fftshift(Y);
    
    Z = X.*Y;
    Z = ifftshift(Z);
    z = ifft2(Z);
    z = ifftshift(z);
    z = real(z);
end