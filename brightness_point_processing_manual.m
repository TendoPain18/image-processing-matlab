% Load the image
img = imread('images/hhhh.jpg');
img = rgb2gray(img);

% Declare variables
bright_factor = 50;
dark_factor = -50;

% Get dimensions
[height, width, RGB] = size(img);

% Initialize images
brightened_img = zeros(height, width, RGB);
darkened_img   = zeros(height, width, RGB);

% Change brightness
for i = 1:RGB
    for j = 1:height
        for k = 1:width
            pixel_val = double(img(j,k,i));
            brightened_val = min(pixel_val + bright_factor, 255);
            darkened_val   = max(pixel_val + dark_factor,  0);
            brightened_img(j,k,i) = brightened_val;
            darkened_img(j,k,i)   = darkened_val;
        end
    end
end

brightened_img = uint8(brightened_img);
darkened_img   = uint8(darkened_img);

% Save processed images
imwrite(img,           'images/original.png');
imwrite(brightened_img,'images/brightened.png');
imwrite(darkened_img,  'images/darkened.png');

%% FIGURE 1 — Image Comparison
figure;
subplot(1,3,1); imshow(img);            title('Original');
subplot(1,3,2); imshow(brightened_img); title('Brightened');
subplot(1,3,3); imshow(darkened_img);   title('Darkened');
saveas(gcf, 'images/images_comparison.png');

%% FIGURE 2 — Histograms
figure;
subplot(3,1,1); imhist(img);            title('Histogram of Original');
subplot(3,1,2); imhist(brightened_img); title('Histogram of Brightened');
subplot(3,1,3); imhist(darkened_img);   title('Histogram of Darkened');
saveas(gcf, 'images/s3_histograms.png');  % ✅ renamed

%% FIGURE 3 — Output Transforms
figure;
x = 0:255;
subplot(3,1,1); plot(x, x);              xlim([0 255]); ylim([0 255]); title('Output Transform of Original');
subplot(3,1,2); plot(x, x+bright_factor);xlim([0 255]); ylim([0 255]); title('Output Transform of Brightened');
subplot(3,1,3); plot(x, x+dark_factor);  xlim([0 255]); ylim([0 255]); title('Output Transform of Darkened');
saveas(gcf, 'images/transforms.png');