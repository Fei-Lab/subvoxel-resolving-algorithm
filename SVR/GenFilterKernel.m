X=6;
Y=6;
Z=6;


kernel = zeros(X*Y*Z,1);

for k=1:Z
    for j=1:Y
        for i=1:X
            pos = (k-1)*X*Y+(j-1)*X+i;
            kernel(pos) = 1;
        end
    end
end

%normalize
kernel = kernel./(sum(kernel));

output = single(kernel);
fp = fopen('filter.raw','w');
ct1 = fwrite(fp,output, 'single');
fclose(fp);