***
* .. _sets_parameter_table_def:
*
* Parameter definition
* ====================
*
* This file contains the definition of all sets and parameters used in turkpow.
***
$sTitle Set Definitions
Set
   time     'time periods'                     / 1975*2005 /
   te(time) 'extended time horizon'            / 1975, 1978, 1983, 1988, 1993, 1998, 2005 /
   t(te)    'time periods excluding base year' /       1978, 1983, 1988, 1993, 1998, 2005 /
   b        'load blocks' / peak, high, medium, low /
   m        'plant types' / hydro-1*hydro-13, gas-t, oil, lignite-1*lignite-3, nuclear /
   mh(m)    'hydro units' / hydro-1*hydro-13 /
   mt(m)    'thermal units - with vintage'
   mc(m)    'thermal units with limitations on total new capacity' / lignite-1*lignite-3 /;

Alias (t,v), (b,bp);
mt(m) = not mh(m);
display mt;

$sTitle Data:
Set labels 'for plant data'
           / initcap   'initial capacities                             (mw)'
             avail     'operational availability'
             e-fact    'energy factor for hydro plants'
             opcost    'operating costs               (mill tl per mw-year)'
             opcost-g  'annual rate of decrease in operating costs      (%)'
             capcost   'capital costs                      (mill tl per mw)'
             capcost-g 'annual rate of decrease in capital costs        (%)'
             life      'life of units                               (years)'
             maxcap    'maximum capacity - on total new capacity       (mw)' /;

Table mdatah(m,labels) 'data for hydro plants'
              initcap  avail  e-fact     opcost   capcost    life  maxcap
*                (mw)                  (mill tl  (mill tl (years)    (mw)
*                                    per mw-yr)   per mw)
   hydro-1                .9      .4        .09       1.4      50     684
   hydro-2                .9      .4        .09       4        50    1484
   hydro-3                .9      .4        .09       6.5      50     844
   hydro-4                .9      .4        .09       7        50     250
   hydro-5       1829     .9      .6        .09       3        50    2000
   hydro-6                .9      .6        .09       6.8      50     814
   hydro-7                .9      .8        .09       4.3      50     890
   hydro-8                .9      .4        .09       2.7      50    1366
   hydro-9                .9      .4        .09       4.6      50     656
   hydro-10               .9      .4        .09       6.1      50     192
   hydro-11               .9      .6        .09       3.9      50    1002
   hydro-12               .9      .6        .09       5.6      50     947
   hydro-13               .9      .8        .09       6.1      50      81;

Table mdatat(m,labels) 'data for thermal plants'
             initcap  avail      opcost  opcost-g   capcost  capcost-g     life  maxcap
*               (mw)           (mill tl       (%)  (mill tl        (%)  (years)    (mw)
*                            per mw-yr)             per mw)
   gas-t         120     .8         1.7     -.005       2.5                  30    +inf
   oil           847     .9         1.1     -.005       4.5       -.01       30    +inf
   lignite-1     960     .8          .6     -.005       5         -.01       30
   lignite-2             .8          .2     -.005       7         -.01       30    2500
   lignite-3             .8          .2     -.005       7         -.01       30    3500
   nuclear               .8          .3     -.005       9         -.02       30    +inf;

Parameter
   hlo(m,te) 'lower bound: hydro unit expansions         (mw)'
             /  hydro-4.1978   250 /
   hup(m,te) 'upper bound: hydro unit expansions         (mw)'
             / (hydro-1*hydro-3, hydro-5*hydro-7).(1978,1983)  inf
               (hydro-1*hydro-13).(1988,1993,1998,2005)        inf
                hydro-4.1978                                   250 /
   tlo(m,te) 'lower bound: thermal unit expansions       (mw)'
             / gas-t.1983  100, gas-t.1988  200, gas-t.1993  360
               gas-t.1998  600, gas-t.2005 1600                    /;

Table tup(m,te) 'upper bound on thermal unit expansions (mw)'
                              1978  1983  1988  1993  1998  2005
   gas-t                       230   390   650  1110  1580  3580
   nuclear                           600  2500  5000 10000   inf
   lignite-3                               inf   inf   inf   inf
   (oil,lignite-1,lignite-2)   inf   inf   inf   inf   inf   inf;

Table dd(b,*) 'demand data for 1975'
* In the reference the data presented in the tables actually use two sets of growth
* rates for determining future demand, and not one as stated in the text. Here the
* single growth rate (11% annually) is used.
            duration  demand
*         hrs per yr)    (mw)
   peak          526    3365
   high         2540    2550
   medium       3066    2050
   low          2628    1520;

Scalar
   rho 'interest rate'                       / .11 /
   prr 'peak reserve requirement        (%)' / .05 /
   r   'maximum aggregate hydro capacity'    / .5  /
   g   'demand growth rate       (annual %)' / .11 /;

Parameter
   length(time)    'distance from base year'
   d(b,te)         'power demand by block                              (mw)'
   dur(b)          'load duration of block               (fraction of year)'
   opcostt(m,v,t)  'operating cost for thermal units (million tl per mw-yr)'
   capcostt(m,v,t) 'capital cost for thermal units      (million tl per mw)'
   sigma(m)        'capital recovery factor'
   delta(t)        'discount factor'
   bs(b,b)         'load order matrix'
   vs(t,v)         'vintage time matrix'
   kit(m,v)        'initial capacity for thermal units                 (mw)';

length(time) =  ord(time) - 1;
bs(b,bp)     = (ord(b) >= ord(bp));
vs(t,v)      = (ord(t) >= ord(v));
opcostt(m,v,t)$vs(t,v)  = mdatat(m,"opcost")* (1 + mdatat(m,"opcost-g"))**length(v);
capcostt(m,v,t)$vs(t,v) = mdatat(m,"capcost")*(1 + mdatat(m,"capcost-g"))**length(v);

d(b,te)        = round(dd(b,"demand")*(1 + g)**length(te),0);
dur(b)         = sum(bp$bs(b,bp), dd(bp,"duration"))/sum(bp, dd(bp,"duration"));
delta(t)       = (1 + rho)**(-length(t));
sigma(mt)      = rho/(1 - (1 + rho)**(-mdatat(mt,"life")));
sigma(mh)      = rho/(1 - (1 + rho)**(-mdatah(mh,"life")));
kit(mt,"1978") = mdatat(mt,"initcap");

display length, bs, vs, opcostt, capcostt, dd, d, dur, delta, sigma;
