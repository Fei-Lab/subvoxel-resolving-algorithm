clear
ViewNum = 1;    % View num = 1, 2, 3 or 4
gensize = 100; % Maximum X,Y,Z pixel size during generation
cropthershold = 3000; % crop psf while pixel index is less than cropthershold (maximum = 65535)


xyImprove = 4;
zImprove = 2;

%% Compute filter size

xyReal =  3;
zReal =  3;

xyGrid = xyReal * xyImprove;
zGrid = zReal * zImprove;



xySigma = xyGrid/2;
if xySigma < 1
    xySigma = 1;
end
zSigma = zGrid/2;
if zSigma < 1
    zSigma = 1;
end
    
    
%% Generate filter slices

     xyH = fspecial('gaussian', [gensize gensize], xySigma/2);
%     xyH = fspecial('gaussian', [gensize gensize], diameter/4);
     xyH = xyH * (65535/max(xyH(:)));
    zHLine = fspecial('gaussian', [1 gensize], zSigma/2);
%   zHLine = fspecial('gaussian', [1 gensize], diameter/4 * (3/5));
    zHLine = zHLine * (65535/max(zHLine(:)));
    
    h = zeros(gensize, gensize, gensize);
    for i = 1:gensize
        h(:,:,i) = xyH * zHLine(1,i);
    end
    
    h = h * (65535/max(h(:)));
    
    
    
    
    
    %% Clip
    psf = uint16(h);
    sx = gensize;
    sy = gensize;
    sz = gensize;
    psfm = psf(:,:,round(sz/2));
    xcrop1 = 0;
    for i=1:round(sx/2)
        if( max(psfm(i,:))<= cropthershold)
            xcrop1 = i;
        end
    end
    xcrop1 = xcrop1+1;
    
    xcrop2 = gensize;
    for i=round(sx/2):sx
        if( max(psfm(i,:)) > cropthershold)
            xcrop2 = i;
        end
    end
    
    xcrop1 = min(xcrop1, (gensize - xcrop2 +1));
    xcrop2 = gensize - xcrop1 + 1;
    
    
    ycrop1 = 0;
    for i=1:round(sy/2)
        if( max(psfm(:,i))<= cropthershold)
            ycrop1 = i;
        end
    end
    ycrop1 = ycrop1+1;
    
    ycrop2 = gensize;
    for i=round(sy/2):sy
        if( max(psfm(:,i))> cropthershold)
            ycrop2 = i;
        end
    end
    
    ycrop1 = min(ycrop1, (gensize - ycrop2 +1));
    ycrop2 = gensize - ycrop1 + 1;
    
    output = psf(xcrop1:xcrop2, ycrop1:ycrop2, :);
    output1 = output;
    
    zcrop1 = 0;
    for i=1:round(sz/2)
        if(max(max(output1(:,:,i)))<= cropthershold)
            zcrop1 = i;
        end
    end
    zcrop1 = zcrop1 +1;
    
    zcrop = gensize;
    for i=round(sz/2):sz
        if(max(max(output1(:,:,i)))> cropthershold)
            zcrop2 = i;
        end
    end
    
    zcrop1 = min(zcrop1, (gensize - zcrop2 + 1));
    zcrop2 = gensize - zcrop1 + 1;
    
    output = output1(:,:, zcrop1:zcrop2);
    output = uint16(output);
    outputold = output;
    
    rawFile = ['./psf_xydiameter_' num2str(xyGrid) '_factor_' num2str(xyImprove) num2str(xyImprove) num2str(zImprove) '.raw'];
    fp = fopen(rawFile,'w');
    ct1 = fwrite(fp,output, 'uint16');
    fclose(fp);
    
    temp = size(output);
    image = output;
    
    tifFile = ['psf_xydiameter_' num2str(xyGrid) '_factor_' num2str(xyImprove) num2str(xyImprove) num2str(zImprove) '.tif'];
    imwrite(uint16(image(:,:,1)'), tifFile, 'tiff');
    for i = 2:size(image, 3)
        imwrite(uint16(image(:,:,i)'), tifFile, 'tiff', 'WriteMode', 'append');
    end

