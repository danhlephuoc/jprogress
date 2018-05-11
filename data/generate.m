set (0, 'defaultaxesfontname', 'Helvetica')
set (0, 'defaultaxesfontsize', 7)
set (0, 'defaulttextfontname', 'Helvetica')
set (0, 'defaulttextfontsize', 7) 

%% Load data
perfMatrix1 = csvread('exp2/kr-online-1-149.csv',1,0);
%perfMatrix2 = csvread('exp1/kr-online-1-175-2.csv',1,0);
%perfMatrix3 = csvread('exp1/kr-online-1-175-3.csv',1,0);
%perfMatrix4 = csvread('exp1/kr-online-1-175-4.csv',1,0);
%perfMatrix5 = csvread('exp1/kr-online-1-175-5.csv',1,0);
%perfMatrix6 = csvread('exp1/kr-online-1-175-6.csv',1,0);
%perfMatrix7 = csvread('exp1/kr-online-1-175-7.csv',1,0);
%perfMatrix8 = csvread('exp1/kr-online-1-175-8.csv',1,0);
%perfMatrix9 = csvread('exp1/kr-online-1-175-9.csv',1,0);
%perfMatrix10 = csvread('exp1/kr-online-1-175-10.csv',1,0);

idVec = perfMatrix1(:,1);
qualityVec = perfMatrix1(:,2);
verdictMatrix = perfMatrix1(:,3:6);
bucketMatrix = perfMatrix1(:,7:19);
durationMatrix = perfMatrix1(:,20:25);
%durationMatrix = ( perfMatrix1(:,20:25) + perfMatrix2(:,20:25) + perfMatrix3(:,20:25) + perfMatrix4(:,20:25) + perfMatrix5(:,20:25) + perfMatrix6(:,20:25) + perfMatrix7(:,20:25) + perfMatrix8(:,20:25) + perfMatrix9(:,20:25) + perfMatrix10(:,20:25) ) ./ 10;
%durationMatrix = ( perfMatrix1(:,19:24) + perfMatrix2(:,19:24) + perfMatrix3(:,19:24) + perfMatrix4(:,19:24) + perfMatrix5(:,19:24) ) ./ 5;
graphMatrix = perfMatrix1(:,26:28);


%% Progression trace graph
verdictTrue = verdictMatrix(:,1);
verdictFalse = verdictMatrix(:,2);
verdictUnknown = verdictMatrix(:,3);
verdictNone =  verdictMatrix(:,4);

subplot(4,1,1);
%plot(idVec,verdictTrue,idVec,verdictFalse,'--',idVec,verdictUnknown,':',idVec,verdictNone,'-.',idVec,qualityVec,'black.');
%plot(idVec,verdictTrue,idVec,verdictFalse,'--',idVec,verdictUnknown,':',idVec,qualityVec,'black.');
plot(idVec,verdictTrue,idVec,verdictFalse,'--',idVec,verdictUnknown,':');
grid on;
axis([1 length(idVec)*1.1 -0.1 1.1])
%xlabel('Iteration');
y = ylabel('Verdict Probability');
set(y, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);
legend('True','False','Unknown','Location','south', 'Orientation', 'horizontal');
legend('boxoff');


%% Time graph
expandMs = durationMatrix(:,2)/1000000;
removeMs = durationMatrix(:,3)/1000000;
durationTotalMs = durationMatrix(:,6)/1000000;

subplot(4,1,2);
plot(idVec,expandMs);
grid on;
axis([1 length(idVec)*1.1 0.0 max(durationTotalMs)*1.1])
%xlabel('Iteration');
y = ylabel('Time (ms)');
set(y, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);


%% Space graph
componentVec = graphMatrix(:,1);
vertexVec = graphMatrix(:,2);
edgeVec = graphMatrix(:,3);

subplot(4,1,3);
%plot(idVec,componentVec);
plot(idVec,componentVec,idVec,vertexVec,'--',idVec,edgeVec,':');
grid on;
axis([1 length(idVec)*1.1 0 max(graphMatrix(:))*1.1])
%xlabel('Iteration');
y = ylabel('Formula size');
set(y, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);
legend('Components','Vertices','Edges','Location','northwest');
legend('boxoff');


%% Population graph
zeroPop = 1-bucketMatrix(:,1);

subplot(4,1,4);
%plot(idVec,verdictTrue,idVec,verdictFalse,'--',idVec,verdictUnknown,':',idVec,verdictNone,'-.',idVec,qualityVec,'black.');
%plot(idVec,verdictTrue,idVec,verdictFalse,'--',idVec,verdictUnknown,':',idVec,qualityVec,'black.');
plot(idVec,zeroPop);
grid on;
axis([1 length(idVec)*1.1 -0.1 1.1])
xlabel('Iteration');
y = ylabel('Density');
set(y, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);


%% Print figures
print('graph', '-dpng', '-r300');