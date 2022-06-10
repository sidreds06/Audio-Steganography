function y=fixdec(x,n)

error(nargchk(2,2,nargin))

if isempty(x)||isempty(n)
    y=[];
    return
end

size_x=size(x);
size_n=size(n);
scalar_x=all(size_x==1)
scalar_n=all(size_n==1)