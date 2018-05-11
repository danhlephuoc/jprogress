set (0, 'defaultaxesfontname', 'Helvetica')
set (0, 'defaultaxesfontsize', 7)
set (0, 'defaulttextfontname', 'Helvetica')
set (0, 'defaulttextfontsize', 7) 

%% Load data
perfMatrix1 = csvread('exp6/kr-offline-1.csv',1,0);
perfMatrix2 = csvread('exp6/kr-offline-2.csv',1,0);
perfMatrix3 = csvread('exp6/kr-offline-3.csv',1,0);

%idVec = perfMatrix1(:,1);
%qualityVec = perfMatrix1(:,2);
%verdictMatrix = perfMatrix1(:,3:6);
%bucketMatrix = perfMatrix1(:,7:19);
%durationMatrix = perfMatrix1(:,20:25);

n1 = size(perfMatrix1(:,20:25));
n = n1(1);
n2 = size(perfMatrix2(:,20:25));
n = min(n, n2(1));
n3 = size(perfMatrix3(:,20:25));
n = min(n, n3(1));
durationMatrix = ( perfMatrix1(1:n,20:25) + perfMatrix2(1:n,20:25) + perfMatrix3(1:n,20:25) ) ./ 3;


idVec = perfMatrix1(1:n,1);
qualityVec = perfMatrix1(1:n,2);
verdictMatrix = perfMatrix1(1:n,3:6);
bucketMatrix = perfMatrix1(1:n,7:19);
graphMatrix = perfMatrix1(1:n,26:28);


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
plot(idVec,zeroPop);
grid on;
axis([1 length(idVec)*1.1 -0.1 1.1])
xlabel('Iteration');
y = ylabel('Density');
set(y, 'Units', 'Normalized', 'Position', [-0.09, 0.5, 0]);


%% Print figures
%print('graph', '-dpng', '-r300');

disp(sum(durationTotalMs)/1000);
disp(mean(durationTotalMs));