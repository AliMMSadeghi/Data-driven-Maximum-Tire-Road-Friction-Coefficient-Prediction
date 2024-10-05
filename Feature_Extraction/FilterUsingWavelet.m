

function [A, D] = FilterUsingWavelet(x,nLevel,TYPE,Title)


[A, D]=GetDWT(x,nLevel,TYPE);

figure;
subplot(nLevel+1,2,[1 2]);
plot(x,'r');
ylabel('x');
title(Title)


% subplot(nLevel+1,2,2);
% plot(x,'r');
% ylabel('x');

c=2;
for i=nLevel:-1:1
    c=c+1;
    subplot(nLevel+1,2,c);
    plot(A{i},'b');
    ylabel(['a_{' num2str(i) '}']);
    
    c=c+1;
    subplot(nLevel+1,2,c);
    plot(D{i},'g');
    ylabel(['d_{' num2str(i) '}']);
end

end

