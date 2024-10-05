function a=ACC(Dbin,n,s,l,f)




D=Dbin{n};
DD=[];
for i=1:l
DD=[DD,D(s+i-1,:)];
end
if l~=1
if strcmp(DD(1),'1')
    L=num2str(ones(1,l*8));
    ll=L==' ';
L(ll)=[];
a=(bin2dec(DD)-bin2dec(L))*f;
else
  a=bin2dec(DD)*f;  
end
else
    a=bin2dec(DD)*f;  
end

end