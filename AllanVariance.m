%Allan Variance的原始实现，并设置了可变的步长d，实现对求取时间的控制。
%**********author:zytjasper 2018/12/10.************%
%********https://blog.csdn.net/zytjasper***********%
%Reference:Noise Identification and Analysis in MEMS Sensors Using an  Optimized Variable Step Allan variance 
clc;
clear all;
tic;
data = xlsread('data.xlsx');
X = data(1:720000,1)*3600;   %读取数据，以陀螺仪某一轴为例

Ts = 0.01; %采样时间
[N,M] = size(X);
N_max = floor(N/3);%（N/3）
T = zeros(N_max,10);
R = zeros(N_max,10);

for d = [1 2 3]  %设置迭代的步长为d，当d=1时为传统的Allan方差
    Allan = zeros(N_max,2);
    Cluster_mean = zeros(N,1);
    for n = 1:d:N_max    %每一簇的簇长
    K = floor(N/n);
    for k = 1:K
        Cluster_mean(k,1) = mean(X((n*(k-1)+1):(n*k),1));
    end
    Cluster_diff = diff(Cluster_mean(1:K),1);
    Allan(n,1) = n*Ts;  %Time tau
    Allan(n,2) = sum((Cluster_diff.^2))/(2*(K-1));
    end
    Allan(any(Allan,2)==0,:)=[]
    TUP = ceil(N_max/d);
    RUP = ceil(N_max/d);
    T(1:TUP,d)=Allan(:,1);
    R(1:RUP,d)=Allan(:,2);
end
x1 = T(:,1);
y1 = R(:,1);

a= [1 2 3 4 5];%函数拟合过程
a(1:5)=lsqcurvefit(@test,a,x1,y1);
f=a(1)*x1.^(-2)+a(2)*x1.^(-1)+a(3)*x1.^(0)+a(4)*x1.^(1)+a(5)*x1.^(2);

figure(1)=figure('color',[1 1 1]);
loglog(T(:,3),R(:,3),'color',[255/255,0/255,0/255]);   
hold on;
loglog(T(:,2),R(:,2),'color',[0/255,191/255,255/255]);   
hold on;
loglog(T(:,1),R(:,1),'color',[255/255,215/255,0/255]);   
hold on;
loglog(x1, f,'r','LineWidth',1.3);
hold on;
xlabel('Cluster Time （sec）'); 
ylabel('Allan Deviation （deg/h）');
grid on;
legend('   Step size=1','   Step size=2','   Step size=3','   Fitting Curve')
toc; 
