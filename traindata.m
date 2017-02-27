% generating training and testing data

load simudata34

tx=simudata.tx_loc;
feature=zeros(length(simudata.aoadata),16);
alpha=0.8;
for i=1:length(simudata.aoadata)
    loc=[tx simudata.rx_loc(i,:) ];
    feature(i,:)=[reshape(simudata.aoadata{i},1,12) loc];   
end

fsize=size(feature);
datax=[];
datay=[];
flag=0;
for i=1:fsize(1)
    for j=1:fsize(1)
        if i~=j 
        flag=flag+1;
        datax(flag,:)=[feature(i,:) feature(j,end-1:end)];
        datay(flag,:)=[feature(j,1:end-2)];
        end
    end
end
trainx=datax(1:0.8*flag,:);
trainy=datay(1:0.8*flag,:);
testx=datax(0.8*flag+1:flag,:);
testy=datay(0.8*flag+1:flag,:);
save('data0222.mat','trainx','trainy','testx','testy')