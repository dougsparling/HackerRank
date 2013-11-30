_,*n=ARGF.map(&:to_f)
s=->x,e,g=-1{e>9?0:g*x**e/(1..e).inject(&:*)+s[x,e+2,-g]}
n.map{|x|printf "%1.3f\n"*2,x+s[x,3],1+s[x,2]}