'##########
' Chapter 5  #
'##########

wfcreate(wf = ch5, page = ch5) m 1969m01 1984m12

import UKdriversKSI.txt @freq m 1969m01 @rename series01 ksi

genr lksi = log(ksi)

group group1 @trend lksi

import logUKpetrolprice.txt @freq m 1969m01 @rename series01 lpetr

'Deterministic level and explanatory variable (linear trend)
equation eq1.ls lksi c @trend

sspace ss_ksi
ss_ksi.append lksi = sv1 + sv2*@trend + [var = exp(c(1))]
ss_ksi.append @state sv1 = sv1(-1)
ss_ksi.append @state sv2 = sv2(-1)
ss_ksi.ml

ss_ksi.makestates(t=filt) *f ' make filtered state estimates series

ss_ksi.makestates(t=smooth) *s  ' make smoothed state estimates series

series res_ksi =  lksi - sv1s

scalar var_eps =  exp(ss_ksi.@coefs(1))

scalar mu1 = sv1s(1)


' with petrol
equation eq2.ls lksi c lpetr

sspace ss_ksi2
ss_ksi2.append lksi = sv1 + sv2*lpetr + [var = exp(c(1))]
ss_ksi2.append @state sv1 = sv1(-1)
ss_ksi2.append @state sv2 = sv2(-1)
ss_ksi2.ml

ss_ksi2.makestates(t=filt) *fa ' make filtered state estimates series
ss_ksi2.makestates(t=smooth) *sa  ' make smoothed state estimates series

scalar var_eps2 =  exp(ss_ksi2.@coefs(1))

scalar mu1a= sv1sa(1)

scalar beta1a = sv2sa(1)

group group1 lksi sv1sa+sv2sa*lpetr

freeze(fig5_1) group1.line

group group2 lpetr lksi 

freeze(fig5_2) group2.scat linefit()

series res_ksi2 =  lksi - sv1sa - sv2sa*lpetr

freeze(fig5_3) res_ksi2.line
fig5_3.axis(l) zeroline

' Stochastic level and explanatory variable
param c(1) -10 c(2) -10 c(3) -10
sspace ss_ksi3
ss_ksi3.append lksi = sv1 + sv2*lpetr + [var = exp(c(1))]
ss_ksi3.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_ksi3.append @state sv2 = sv2(-1) 
ss_ksi3.ml

ss_ksi3.makestates(t=filt) *fb ' make filtered state estimates series

ss_ksi3.makestates(t=smooth) *sb  ' make smoothed state estimates series

scalar var_eps3 =  exp(ss_ksi3.@coefs(1))
scalar var_xi3 =  exp(ss_ksi3.@coefs(2))
scalar mu1b= sv1sb(1)
scalar beta1b = sv2sb(1)

group group2 lksi sv1sb+sv2sb*lpetr

freeze(fig5_4) group2.line

series res_ksi3 =  lksi - sv1sb - sv2sb*lpetr

freeze(fig5_5) res_ksi3.line
fig5_5.axis(l) zeroline 

wfsave ch5.wf1

