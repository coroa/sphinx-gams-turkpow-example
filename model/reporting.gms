***
* Standard output reports
* =======================
*
* This part of the code contains the default reports that will be created after run.
***
$sTitle Report
Parameter report 'summary report';

Set reporder / power, capacity, duration, energy, e-limit, op-cost /;

report(mt,b,t)                = sum(v, zt.l(mt,v,b,t));
report(mh,b,t)                = zh.l(mh,b,t);
report("power",b,t)           = d(b,t);
report("duration",b,t)        = dur(b);
report("power","power",t)     = sum(b, report("power",b,t));
report(m,"power",t)           = sum(b, report(m,b,t));
report(mt,"capacity",t)       = sum(v$vs(t,v), kit(mt,v) + ht.l(mt,v));
report(mh,"capacity",t)       = mdatah(mh,"initcap") + sum(v$vs(t,v), hh.l(mh,v));
report("energy",b,t)          = report("power",b,t)*report("duration",b,t);
report("energy","energy",t)   = sum(b, report("energy",b,t));
report(m,"energy",t)          = sum(b, dur(b)*report(m,b,t));
report(mh,"e-limit",t)        = report(mh,"capacity",t)*mdatah(mh,"e-fact");
report(mh,"op-cost",t)        = report(mh,"energy",t)*mdatah(mh,"opcost");
report(mt,"op-cost",t)        = sum(v$vs(t,v), opcostt(mt,v,t)*sum(b, dur(b)*zt.l(mt,v,b,t)));
report("op-cost","op-cost",t) = sum(m, report(m,"op-cost",t));
report("op-cost",b,t)         = sum(mh, dur(b)*mdatah(mh,"opcost")*zh.l(mh,b,t))
                              + sum((mt,v)$vs(t,v), dur(b)*opcostt(mt,v,t)*zt.l(mt,v,b,t));

display hh.l, ht.l, report;