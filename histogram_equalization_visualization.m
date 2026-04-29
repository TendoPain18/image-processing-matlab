% Load image
original_image = imread('cameraman.tif');

% Apply histogram equalization
enhanced_image = histeq(original_image);

% Save images
imwrite(original_image, 'images/original_image.png');
imwrite(enhanced_image, 'images/enhanced_image.png');

%% FIGURE 1 — Image Comparison
figure;
subplot(1,2,1); imshow(original_image); title('Original Image');
subplot(1,2,2); imshow(enhanced_image); title('Enhanced Image');
saveas(gcf, 'images/comparison_images.png');

%% FIGURE 2 — Histograms
figure;
subplot(2,1,1); imhist(original_image); title('Histogram of Original Image');
subplot(2,1,2); imhist(enhanced_image); title('Histogram of Enhanced Image');
saveas(gcf, 'images/s5_histograms.png');  % ✅ renamed

%% FIGURE 3 — Transform Comparison
figure;
subplot(2,1,1);
plot(imhist(original_image)); hold on;
plot(imhist(enhanced_image));
legend('Original Image','Enhanced Image');
title('Histogram Comparison');

subplot(2,1,2);
plot(imhist(enhanced_image)); hold on;
plot((0:255)/255, (0:255)/255, 'r');
legend('Enhanced Image','Ideal Transform');
title('Output Transform Comparison');
saveas(gcf, 'images/transform_comparison.png');