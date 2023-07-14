% scan of detuning of thermal state of atoms

clearvars ;
folderpath = 'Z:\SCI-NBI-quantop-data\data\gwd\atoms\2023-07-13 - scan probe volt_000\';
load([folderpath,'scan probe volt_00000.mat']);
%% 

D = dev5456.demods.sample(1:30) ;

for loop = 1:30
%pat = "lambda " + digitsPattern(4) + ("a"|"b");
pat = digitsPattern(3)+"."+ digitsPattern(6) ;
str = convertCharsToStrings(D{loop}.header.name)

lambda_(loop) = str2double(extract(str,pat));
DATAS_(:,loop) = D{loop}.r ;
end

[lambda,I_sort] = sort(lambda_);
DATAS = DATAS_ ;
DATAS(:,:) = DATAS_(:,I_sort);

figure(1); clf;
subplot(121)
surfc(D{loop}.frequency*1e-6,lambda, DATAS')
view([0 90])
cb = colorbar;
clim([0 3e-3])
shading interp
ylabel('\lambda (nm)')
xlabel('MORS freq(MHz)')
title('no repump - 40 muW probe')

%% scan of detuning of thermal state of atoms

clearvars ;
load('sweep_00000.mat');

D = dev5456.demods.sample(31:end) ;
for loop = 1:length(D)
%pat = "lambda " + digitsPattern(4) + ("a"|"b");
pat = digitsPattern(3)+"."+digitsPattern(6) ;
str = convertCharsToStrings(D{loop}.header.name);

lambda_(loop) = str2double(extract(str,pat));
DATAS_(:,loop) = D{loop}.r ;
end

[lambda,I_sort] = sort(lambda_);
[lambda,Iunique] = unique(lambda);
DATAS = DATAS_ ;
DATAS(:,:) = DATAS_(:,I_sort);
DATAS(:,27) = [];

figure(1); 
subplot(122)
surfc(D{loop}.frequency*1e-6,lambda, DATAS')
view([0 90])
cb = colorbar;
clim([0 3e-3])
shading interp
ylabel('\lambda (nm)')
xlabel('MORS freq(MHz)')
title('1mW repump - 40 muW probe')

% define D1 and D2 transition:
D1_lambda = 3e8/(852.34727582e-9) - 5.170855370625e9 ;
