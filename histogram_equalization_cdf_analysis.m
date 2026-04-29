% Load the image
img = imread('cameraman.tif');

% Calculate the histogram and the CDF
histogram = imhist(img);
cdf = cumsum(histogram) / numel(img);

% Compute the output transform using the CDF
x = 0:255;
y1 = round((256-1) * cdf(x+1));

% Apply histogram equalization
eq_img = histeq(img);

% Save the equalized image as PNG
imwrite(eq_img, 'images/s1_equalized_image.png');  % ✅ renamed

% Calculate histogram and CDF of equalized image
eq_histogram = imhist(eq_img);
eq_cdf = cumsum(eq_histogram) / numel(eq_img);

% Compute transform
y2 = round((256-1) * eq_cdf(x+1));

% Create figure
figure;
subplot(2,1,1);
plot(x, y1); xlim([0 255]); ylim([0 255]);
title('Original Output Transform');
xlabel('Input Intensity'); ylabel('Output Intensity');

subplot(2,1,2);
plot(x, y2); xlim([0 255]); ylim([0 255]);
title('Output Transform after Histogram Equalization');
xlabel('Input Intensity'); ylabel('Output Intensity');

% Save the figure as PNG
saveas(gcf, 'images/transform_plot.png');