% Read in grayscale image
img = imread('cameraman.tif');

% Adjust intensity values
img_adj = imadjust(img, stretchlim(img, [0.01, 0.99]));

% Calculate dynamic range
dynamic_range = max(img_adj(:)) - min(img_adj(:));

% Save adjusted image
imwrite(img_adj, 'images/adjusted_image.png');

% Display results
figure;
subplot(1,2,1); imshow(img); title('Original Image');
subplot(1,2,2); imshow(img_adj);
title(sprintf('Adjusted Image (Dynamic Range = %.2f)', dynamic_range));

% Save the figure
saveas(gcf, 'images/comparison_plot.png');