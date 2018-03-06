function [output_img] = correlation(input_img, mask)
[row, col] = size(input_img);
output_img = zeros(row, col);
[mrow, mcol] = size(mask);
krow = floor(mrow/2);
kcol = floor(mcol/2);
pad_img = zeros(row+2*krow, col+2*kcol);
[prow, pcol] = size(pad_img);
for i = 1:krow
    pad_img(i,:) = 0;
    pad_img(prow+1-i,:) = 0;
end
for i = 1:kcol
    pad_img(:,i) = 0;
    pad_img(:,pcol+1-i) = 0;
end
for i = 1:row
    for j = 1:col
        pad_img(i+krow,j+kcol) = input_img(i,j);
    end
end
for i = krow+1 : krow+row
    for j = kcol+1 : kcol+col
        for s = -krow : krow
            for t = -kcol : kcol
                output_img(i-krow, j-kcol) = output_img(i-krow,j-kcol)...
                    + mask(1+krow+s,1+kcol+t)*pad_img(i+s,j+t);
            end
        end
    end
end
output_img = im2uint8(mat2gray(output_img));
end