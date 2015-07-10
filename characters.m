keySet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
valueSet = [6, 6, 2, 2, 5, 16, 9, 12, 7, 6, 6, 6, 25, 8, 10, 2, 4, 6, 7, 6, 2, 10, 6, 7, 5, 2, 11, 11, 16, 19, 19, 23, 27, 20, 13, 18];
defaultSet = [5, 2, 1, 1, 3, 4, 3, 3, 7, 4, 2, 6, 1, 4, 6, 2, 4, 2, 3, 1, 1, 3, 5, 7, 4, 2, 1, 9, 1, 13, 1, 16, 5, 10, 8, 10];
mapObj = containers.Map(keySet, valueSet);
defaultObj = containers.Map(keySet, defaultSet);

% for i = 1 : length(keySet)
%     letter = keySet(i);
%     for j = 1 : valueSet(i)
%         file = char(strcat('letters/', letter, '_', int2str(j), '.jpg'));
%         img = imread(file);
%         [fil, col] = size(img);
%         r_img = imresize(img, 140 / fil);
%         imwrite(r_img, char(strcat('characters/', letter, '_', int2str(j), '.jpg')));
%     end
% end

for i = 1 : length(keySet)
    letter = keySet(i);
    for j = 1 : valueSet(i)
        file = char(strcat('characters/', letter, '_', int2str(j), '.jpg'));
        img = imread(file);
        [fil, col] = size(img);
        r_img = fillMatrix(img, 88);
        imwrite(r_img, char(strcat('characters/', letter, '_', int2str(j), '.jpg')));
    end
end