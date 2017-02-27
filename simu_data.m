clear all
clc

nbrofLoc=200;

tx_set = sweepingTransceiver([-1,1], 60, 64);   %[-1,1] axis, 60, beam width; 64,sectors.
roomsize=[3, 4, 3];
tx_loc=[-1,1];
simudata.tx_loc=tx_loc;
simudata.roomsize=roomsize(1:2);

% sample data from different locations

for i=1:nbrofLoc
        mytime=tic;
        rx_loc=[-roomsize(1)/2 -roomsize(2)/2]+[roomsize(1) roomsize(2)].*rand(1,2);
        simudata.rx_loc(i, :)=rx_loc;
        rx_set = [sweepingTransceiver(rx_loc,60,1, angle2Points(rx_loc,tx_loc))];       
        [trace, tr_ccomps] = ch_trace( tx_set, rx_set, roomsize, 'max_refl',1);
        toc(mytime);
        data.paths{i}=trace.paths{1};
end

for i=1:nbrofLoc
    path=data.paths{i};
    powerdata=[];
    for j=2:5
        rx=path(j,1:2:end);
        ry=path(j,2:2:end);
        aod=angle2Points([rx(1),ry(1)],[rx(2),ry(2)]);
        aod=rad2deg(aod);
        aoa=angle2Points([rx(3),ry(3)],[rx(2),ry(2)]);
        aoa=rad2deg(aoa);
        l=distancePoints([rx(1),ry(1)],[rx(2),ry(2)])+distancePoints([rx(2),ry(2)],[rx(3),ry(3)]);
        powerdata=[powerdata;[aod, aoa, l]];
    end
    simudata.aoadata{i}=powerdata;
end
 save('simudata34.mat','simudata')     

