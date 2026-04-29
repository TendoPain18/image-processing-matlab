img_2 = imread('cameraman.tif');

%% FIGURE 1 — Original vs Synthesized
figure;
subplot(2,2,1); imshow(img_2);   title('Original Image');
subplot(2,2,3); imhist(img_2);   title('Histogram of Original Image');

[height, width, ~] = size(img_2);
desired_image = zeros(height, width, 3);
desired_image(:, 1:floor(width/3),           1) = 255;
desired_image(:, floor(width/3)+1:floor(2*width/3), 2) = 255;
desired_image(:, floor(2*width/3)+1:width,   3) = 255;
desired_image = uint8(desired_image);
desired_image = rgb2gray(desired_image);

subplot(2,2,2); imshow(desired_image); title('Synthesized Image');
subplot(2,2,4); imhist(desired_image); title('Histogram of Synthesized Image');

imwrite(desired_image, 'images/synthesized_image.png');
saveas(gcf, 'images/figure1_basic.png');

%% Brightness Adjustment
bright_factor = 100;
dark_factor   = -100;

brightened_img = uint8(min(double(img_2) + bright_factor, 255));
darkened_img   = uint8(max(double(img_2) + dark_factor,   0));

imwrite(brightened_img, 'images/brightened_100.png');
imwrite(darkened_img,   'images/darkened_100.png');

%% FIGURE 2 — Brightness Comparison
figure;
x = 0:255;
subplot(3,3,1); imshow(img_2);        title('Original');
subplot(3,3,2); imshow(brightened_img);title('Brightened');
subplot(3,3,3); imshow(darkened_img); title('Darkened');
subplot(3,3,4); imhist(img_2);        title('Histogram of Original');
subplot(3,3,5); imhist(brightened_img);title('Histogram of Brightened');
subplot(3,3,6); imhist(darkened_img); title('Histogram of Darkened');
subplot(3,3,7); plot(x, x);              xlim([0 255]); ylim([0 255]); title('Transform of Original');
subplot(3,3,8); plot(x, x+bright_factor);xlim([0 255]); ylim([0 255]); title('Transform of Brightened');
subplot(3,3,9); plot(x, x+dark_factor);  xlim([0 255]); ylim([0 255]); title('Transform of Darkened');
saveas(gcf, 'images/figure2_brightness.png');

%% Histogram Equalization
enhanced_image = histeq(img_2);
imwrite(enhanced_image, 'images/s4_equalized_image.png');  % ✅ renamed

%% FIGURE 3 — Equalization
figure;
subplot(3,2,1); imshow(img_2);        title('Original Image');
subplot(3,2,2); imshow(enhanced_image);title('Enhanced Image');
subplot(3,2,3); imhist(img_2);        title('Histogram of Original');
subplot(3,2,4); imhist(enhanced_image);title('Histogram of Enhanced');

histogram = imhist(img_2);
cdf = cumsum(histogram) / numel(img_2);
x   = 0:255;
y1  = round(255 * cdf(x+1));

eq_histogram = imhist(enhanced_image);
eq_cdf = cumsum(eq_histogram) / numel(enhanced_image);
y2 = round(255 * eq_cdf(x+1));

subplot(3,2,5); plot(x, y1); xlim([0 255]); ylim([0 255]); title('Original Output Transform');
subplot(3,2,6); plot(x, y2); xlim([0 255]); ylim([0 255]); title('Equalized Output Transform');
saveas(gcf, 'images/figure3_equalization.png');