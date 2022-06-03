'##########
' Chapter 3 #
'##########

wfcreate(wf = book_examples, page = ch3) m 1969m01 1984m12

import UKdriversKSI.txt @freq m 1969m01 @rename series01 ksi

genr lksi = log(ksi)

' Local trend, constant, simple linear regression
equation eq_trend.ls lksi c @trend

' Local trend, constant, state space estimation
sspace ss_eq3_2
ss_eq3_2.append @signal lksi = sv1 + [var = exp(c(1))]
ss_eq3_2.append @state sv1 = sv1(-1) + sv2(-1)
ss_eq3_2.append @state sv2 = sv2(-1) 
ss_eq3_2.ml

ss_eq3_2.makestates(t=filt) *f ' make filtered state estimates series

ss_eq3_2.makestates(t=smooth) *s  ' make smoothed state estimates series

scalar mu1 = sv1s(1)
scalar nu1  = sv2s(1)

scalar var_eps =  exp(ss_eq3_2.@coefs(1))

series res_ksi =  lksi - sv1s

graph gr1.line res_ksi


' Stochastic intercept and stochastic linear trend
param c(1) -10 c(2) -10 c(3) -1
sspace ss_eq3_2a
ss_eq3_2a.append lksi = sv1 + [var = exp(c(1))]
ss_eq3_2a.append @state sv1 = sv1(-1) + sv2(-1) + [var = exp(c(2))]
ss_eq3_2a.append @state sv2 = sv2(-1) + [var = exp(c(3))]
ss_eq3_2a.ml

ss_eq3_2a.makestates(t=filt) *fa' make filtered state estimates series

ss_eq3_2a.makestates(t=smooth) *sa  ' make smoothed state estimates series

scalar var_epsa =  exp(ss_eq3_2a.@coefs(1))
scalar var_xi =  exp(ss_eq3_2a.@coefs(2))
scalar var_zeta =  exp(ss_eq3_2a.@coefs(3))

scalar mu1a = sv1sa(1)
scalar nu1a  = sv2sa(1)

group group1 lksi sv1sa

freeze(fig3_1) group1.line

freeze(fig3_2) sv2sa.line

series res_ksi =  lksi - sv1sa

freeze(fig3_3) res_ksi.line
fig3_3.axis(l) zeroline

' Stochastic intercept and deterministic linear trend
param c(1) -10 c(2) -10
sspace ss_eq3_3
ss_eq3_3.append lksi = sv1 + [var = exp(c(1))]
ss_eq3_3.append @state sv1 = sv1(-1) + sv2(-1) + [var = exp(c(2))]
ss_eq3_3.append @state sv2 = sv2(-1) 
ss_eq3_3.ml

ss_eq3_3.makestates(t=filt) *fb ' make filtered state estimates series

ss_eq3_3.makestates(t=smooth) *sb  ' make smoothed state estimates series

scalar var_epsb =  exp(ss_eq3_3.@coefs(1))
scalar var_xib = exp(ss_eq3_3.@coefs(2))

scalar mu1b = sv1sb(1)
scalar nu1b  = sv2sb(1)

group group2 lksi sv1sb

freeze(fig3_4) group2.line

series res_ksi =  lksi - sv1sb

' Finnish data
pagecreate(page=ch3_a) a 1970 2003

pageselect ch3_a

import NorwayFinland.txt @freq a 1970 @rename series02 norfat series03 finfat

delete series01 ' time data

genr lnor = log(norfat)
genr lfin = log(finfat)

param c(1) -5 c(2) -10 c(3) -10
sspace ss_fin
ss_fin.append lfin = sv1 + [var=exp(c(1))]
ss_fin.append @state sv1 = sv1(-1) + sv2(-1) + [var=exp(c(2))]
ss_fin.append @state sv2 = sv2(-1) + [var = exp(c(3))]
ss_fin.ml

ss_fin.makestates(t=filt) *f ' make filtered state estimates series

ss_fin.makestates(t=smooth) *s  ' make smoothed state estimates series

series res_fin =  lfin - sv1s

scalar var_eps =  exp(ss_fin.@coefs(1))

scalar mu1 = sv1s(1)
scalar nu1  = sv2s(1)

group gr1 lfin sv1s

freeze(fig3_5a) gr1.line

freeze(fig3_5b) sv2s.line
fig3_5b.axis(l) zeroline

freeze(fig3_6) res_fin.line
fig3_6.axis(l) zeroline

wfsave ch3.wf1

