' Chapter 1

wfcreate(wf = ch1, page = ch1_2) m 1969m01 1984m12

import UKdriversKSI.txt @freq m 1969m01 @rename series01 ksi

genr lksi = log(ksi)

group gr1 @trend lksi

freeze(fig1_1) gr1.scat linefit()

fig1_1.name(1) Time (in months)
fig1_1.name(2) Log of UK drivers KSI

equation eq1.ls lksi c @trend

freeze(fig1_2) lksi.line 

series eps = resid

freeze(fig1_3) eps.line

fig1_1.save(t=pdf, c, box, port, w=4.2, h = 4.1, u=in, d=96, trans) fig1_1.pdf

fig1_2.save(t=pdf, c, box, port, w=4.2, h = 4.1, u=in, d=96, trans) fig1_2.pdf

fig1_3.save(t=pdf, c, box, port, w=4.2, h = 4.1, u=in, d=96, trans) fig1_3.pdf

