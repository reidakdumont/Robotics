fid = fopen('optdigits-orig.cv', 'r');
line = 'toto';
i = 0;
cnb = 0;
index = 1;
while line ~= -1
    line = fgetl(fid);
    if line ~= -1
        if i >= 20
            if cnb == 33
                index = index + 1;
                cnb = 0;
            end
            if cnb == 32
                C = textscan(line,'%s','delimiter',' ');
                LABELOPTDIGITTEST(1,index) = str2num(C{1}{2});
            else
                DATAOPTDIGITTEST(cnb+1,index) = bin2dec(line);
            end
            cnb = cnb+1;
        elseif i == 7
            C = textscan(line,'%s','delimiter',' ');
            LABELOPTDIGITTEST = zeros(1,str2num(C{1}{3}));
            DATAOPTDIGITTEST = zeros(32,str2num(C{1}{3}));
        end
        i = i + 1;
    end
end
save('optdigitdata_test', 'DATAOPTDIGITTEST');
save('optdigitlabel_test', 'LABELOPTDIGITTEST');
fclose(fid);