wfcreate(wf = ch4, page = ch4) m 1969m01 1984m12

import UKdriversKSI.txt @freq m 1969m01 @rename series01 ksi

genr lksi = log(ksi)

' Deterministic level and seasonal
sspace ss_eq4_1
ss_eq4_1.append lksi = sv1 + sv2 + [var = exp(c(1))]
ss_eq4_1.append @state sv1 = sv1(-1) 
ss_eq4_1.append @state sv2 = -sv2(-1) - sv3(-1) - sv4(-1) - sv5(-1) - sv6(-1) - sv7(-1) - sv8(-1) - sv9(-1) - sv10(-1) - sv11(-1) - sv12(-1)
ss_eq4_1.append @state sv3 = sv2(-1)
ss_eq4_1.append @state sv4 = sv3(-1)
ss_eq4_1.append @state sv5 = sv4(-1)
ss_eq4_1.append @state sv6 = sv5(-1)
ss_eq4_1.append @state sv7 = sv6(-1)
ss_eq4_1.append @state sv8 = sv7(-1)
ss_eq4_1.append @state sv9 = sv8(-1)
ss_eq4_1.append @state sv10 = sv9(-1)
ss_eq4_1.append @state sv11 = sv10(-1)
ss_eq4_1.append @state sv12 = sv11(-1)
ss_eq4_1.ml

ss_eq4_1.makestates(t=filt) *f ' make filtered state estimates series

ss_eq4_1.makestates(t=smooth) *s  ' make smoothed state estimates series

scalar var_eps =  exp(ss_eq4_1.@coefs(1))

scalar mu1 = sv1s(1)

group gr1 lksi sv1s+sv2s

freeze(fig4_2) gr1.line

group group2 lksi sv1s

freeze(fig4_3) group2.line
fig4_3.axis(l) zeroline

freeze(fig4_4) sv2s.line
fig4_4.axis(l) zeroline

series res_ksi =  lksi - sv1s

freeze(fig4_5) res_ksi.line
fig4_5.axis(l) zeroline

' Stochastic level and seasonal
param c(1) -10 c(2) -10 c(3) -10
sspace ss_eq4_1a
ss_eq4_1a.append lksi = sv1 + sv2 + [var = exp(c(1))]
ss_eq4_1a.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_eq4_1a.append @state sv2 = -sv2(-1) - sv3(-1) - sv4(-1) - sv5(-1) - sv6(-1) - sv7(-1) - sv8(-1) - sv9(-1) - sv10(-1) - sv11(-1) - sv12(-1) + [var = exp(c(3))]
ss_eq4_1a.append @state sv3 = sv2(-1)
ss_eq4_1a.append @state sv4 = sv3(-1)
ss_eq4_1a.append @state sv5 = sv4(-1)
ss_eq4_1a.append @state sv6 = sv5(-1)
ss_eq4_1a.append @state sv7 = sv6(-1)
ss_eq4_1a.append @state sv8 = sv7(-1)
ss_eq4_1a.append @state sv9 = sv8(-1)
ss_eq4_1a.append @state sv10 = sv9(-1)
ss_eq4_1a.append @state sv11 = sv10(-1)
ss_eq4_1a.append @state sv12 = sv11(-1)
ss_eq4_1a.ml

ss_eq4_1a.makestates(t=filt) *fa ' make filtered state estimates series

ss_eq4_1a.makestates(t=smooth) *sa  ' make smoothed state estimates series

scalar var_eps_a =  exp(ss_eq4_1a.@coefs(1))
scalar var_xi_a =  exp(ss_eq4_1a.@coefs(2))
scalar var_omega_a =  exp(ss_eq4_1a.@coefs(3))

scalar mu1a = sv1sa(1)

group gr3 lksi sv1sa

freeze(fig4_6) gr3.line

freeze(fig4_7) sv2sa.line
fig4_7.axis(l) zeroline

smpl 1969 1969
freeze(fig4_8) sv2sa.line
fig4_8.axis(l) zeroline

smpl @all
series res_ksi_a =  lksi - sv1sa

freeze(fig4_9) res_ksi_a.line
fig4_9.axis(l) zeroline

' Stochastic level and deterministic seasonal
param c(1) -5 c(2) -5
sspace ss_eq4_1b
ss_eq4_1b.append lksi = sv1 + sv2 + [var = exp(c(1))]
ss_eq4_1b.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_eq4_1b.append @state sv2 = -sv2(-1) - sv3(-1) - sv4(-1) - sv5(-1) - sv6(-1) - sv7(-1) - sv8(-1) - sv9(-1) - sv10(-1) - sv11(-1) - sv12(-1)
ss_eq4_1b.append @state sv3 = sv2(-1)
ss_eq4_1b.append @state sv4 = sv3(-1)
ss_eq4_1b.append @state sv5 = sv4(-1)
ss_eq4_1b.append @state sv6 = sv5(-1)
ss_eq4_1b.append @state sv7 = sv6(-1)
ss_eq4_1b.append @state sv8 = sv7(-1)
ss_eq4_1b.append @state sv9 = sv8(-1)
ss_eq4_1b.append @state sv10 = sv9(-1)
ss_eq4_1b.append @state sv11 = sv10(-1)
ss_eq4_1b.append @state sv12 = sv11(-1)
ss_eq4_1b.ml

ss_eq4_1b.makestates(t=filt) *fb ' make filtered state estimates series

ss_eq4_1b.makestates(t=smooth) *sb  ' make smoothed state estimates series

series res_ksi_b =  lksi - sv1sb

scalar var_eps_b =  exp(ss_eq4_1b.@coefs(1))
scalar var_xi_b =  exp(ss_eq4_1b.@coefs(2))

scalar mu1b = sv1sb(1)

group gr4 lksi sv1sb

freeze(fig4_x) gr4.line

freeze(fig4_y) sv2sb.line
fig4_y.axis(l) zeroline

group group5 lksi sv1sb+sv2sb
freeze(fig4_z) group5.line

' The local level and seasonal model and UK inflation
pagecreate(page = ch4_q) q 1950 2001
pageselect ch4_q

import UKinflation.txt @freq q 1950q01 @rename series01 uk_infl

param c(1) -5 c(2) -5 c(3) -15
sspace ss_uk
ss_uk.append uk_infl = sv1 + sv2 + [var = exp(c(1))]
ss_uk.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_uk.append @state sv2 = -sv2(-1) - sv3(-1) - sv4(-1) + [var = exp(c(3))]
ss_uk.append @state sv3 = sv2(-1)
ss_uk.append @state sv4 = sv3(-1)
ss_uk.ml

ss_uk.makestates(t=filt) *f ' make filtered state estimates series

ss_uk.makestates(t=smooth) *s  ' make smoothed state estimates series

series res_uk =  uk_infl - sv1s

scalar var_eps =  exp(ss_uk.@coefs(1))
scalar var_xi =  exp(ss_uk.@coefs(2))
scalar var_omega =  exp(ss_uk.@coefs(3))

scalar mu1 = sv1s(1)

group gr1 uk_infl sv1s

freeze(fig4_10a) gr1.line

freeze(fig4_10b) sv2s.line
fig4_10b.axis(l) zeroline

freeze(fig4_10c) res_uk.line
fig4_10c.axis(l) zeroline


