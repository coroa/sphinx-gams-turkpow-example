
$sTitle Model Definition

***
* turkpower core formulation
* ==========================
*
* For the complete list of sets, mappings and parameters, refer to the auto-documentation page :doc:`sets_parameters_table_def`.
*
* .. contents::
*    :local:
*    :backlinks: none
*
***

*----------------------------------------------------------------------------------------------------------------------*
* Variable definitions                                                                                                 *
*----------------------------------------------------------------------------------------------------------------------*

***
* .. _section_variable_def:
*
* Variable definitions
* --------------------
*
* .. _section_decision_variable_def:
*
* Decision variables
* ^^^^^^^^^^^^^^^^^^
* ======================================================== ====================================================================================
* Variable                                                 Explanatory text
* ======================================================== ====================================================================================
* :math:`OBJ \in \mathbb{R}`                               Objective value of the optimization program
* :math:`EXT_{n,c,g,y} \in \mathbb{R}_+`                   Extraction of non-renewable/exhaustible resources from reserves
* :math:`STOCK_{n,c,l,y} \in \mathbb{R}_+`                 Quantity in stocks (storage) at start of period :math:`y`
* :math:`STOCK\_CHG_{n,c,l,y,h} \in \mathbb{R}`            Input or output quantity into intertemporal commodity stock (storage)
* :math:`COST\_NODAL_{n,y} \in \mathbb{R}`                 System costs at the node level over time
* :math:`REN_{n,t,c,g,y,h} \in \mathbb{R}_+`               Activity of renewable technologies per grade
* :math:`CAP\_NEW_{n,t,y} \in \mathbb{R}_+`                Newly installed capacity (yearly average over period duration)
* :math:`CAP_{n,t,y^V,y} \in \mathbb{R}_+`                 Maintained capacity in year :math:`y` of vintage :math:`y^V`
* :math:`CAP\_FIRM_{n,t,c,l,y,q} \in \mathbb{R}_+`         Capacity counting towards firm (dispatchable)
* :math:`ACT_{n,t,y^V,y,m,h} \in \mathbb{R}`               Activity of a technology (by vintage, mode, subannual time)
* :math:`ACT\_RATING_{n,t,y^V,y,c,l,h,q} \in \mathbb{R}_+` Auxiliary variable for activity attributed to a particular rating bin [#ACT_RATING]_
* :math:`CAP\_NEW\_UP_{n,t,y} \in \mathbb{R}_+`            Relaxation of upper dynamic constraint on new capacity
* :math:`CAP\_NEW\_LO_{n,t,y} \in \mathbb{R}_+`            Relaxation of lower dynamic constraint on new capacity
* :math:`ACT\_UP_{n,t,y,h} \in \mathbb{R}_+`               Relaxation of upper dynamic constraint on activity [#ACT_BD]_
* :math:`ACT\_LO_{n,t,y,h} \in \mathbb{R}_+`               Relaxation of lower dynamic constraint on activity [#ACT_BD]_
* :math:`LAND_{n,s,y} \in [0,1]`                           Relative share of land-use scenario (for land-use model emulator)
* :math:`EMISS_{n,e,\widehat{t},y} \in \mathbb{R}`         Auxiliary variable for aggregate emissions by technology type
* :math:`REL_{r,n,y} \in \mathbb{R}`                       Auxiliary variable for left-hand side of relations (linear constraints)
* :math:`COMMODITY\_USE_{n,c,l,y} \in \mathbb{R}`          Auxiliary variable for amount of commodity used at specific level
* :math:`COMMODITY\_BALANCE_{n,c,l,y,h} \in \mathbb{R}`    Auxiliary variable for right-hand side of commodity_balance
* :math:`STORAGE_{n,t,l,c,y,h} \in \mathbb{R}`             State of charge or content of storage at each sub-annual timestep
* :math:`STORAGE\_CHARGE_{n,t,l,c,y,h} \in \mathbb{R}`     Charging of storage in each sub-annual timestep (negative for discharging)
* ======================================================== ====================================================================================
*
* The index :math:`y^V` is the year of construction (vintage) wherever it is necessary to
* clearly distinguish between year of construction and the year of operation.
*
* All decision variables are by year, not by (multi-year) period, except :math:`STOCK_{n,c,l,y}`.
* In particular, the new capacity variable :math:`CAP\_NEW_{n,t,y}` has to be multiplied by the number of years
* in a period :math:`|y| = duration\_period_{y}` to determine the available capacity :math:`CAP_{n,t,y^V,y}`
* in subsequent periods (assuming the newly build capacity is not immediately decommissioned):
*
* The current model framework allows both input or output normalized formulation.
* This will affect the parametrization.
*
* .. [#ACT_RATING] The auxiliary variable :math:`ACT\_RATING_{n,t,y^V,y,c,l,h,q}` is defined in terms of input or
*    output of the technology.
*
* .. [#ACT_BD] The dynamic activity constraints are implemented as summed over all modes;
*    therefore, the variables for the relaxation are not indexed over the set ``mode``.
*
***

Variable
   phi         'total discounted cost                           (million tl)'
   phic(te)    'capital charges                                 (million tl)'
   phio(te)    'operating costs                                 (million tl)'
   hh(m,te)    'capacity additions: hydro units                         (mw)'
   ht(m,v)     'capacity additions: thermal units                       (mw)'
   htt(m)      'capacity additions: total thermal unit over time        (mw)'
   zh(m,b,t)   'power output: hydro                                     (mw)'
   zt(m,v,b,t) 'power output: thermal                                   (mw)';

Positive Variable zh, zt, hh, ht;

Equation
   db(b,te)    'demand balance                                          (mw)'
   pr(te)      'peak and reserve requirements                           (mw)'
   cch(m,te)   'capacity constraint: hydro                              (mw)'
   cct(m,v,te) 'capacity constraint: thermal                            (mw)'
   ech(m,te)   'hydro energy constraint                              (mw-yr)'
   hcc(te)     'hydro capacity constraint                               (mw)'
   rch(m)      'resource constraint: maximum new capacity on hydros     (mw)'
   cat(m)      'capacity accounting: total new capacity for unit        (mw)'
   ak(te)      'accounting: capital charges                     (million tl)'
   ao(te)      'accounting: operating costs                     (million tl)'
   obj         'total discounted cost                           (million tl)';

db(b,t)..     sum(bp$bs(bp,b), sum(mh, zh(mh,bp,t))
           +  sum((mt,v)$vs(t,v), zt(mt,v,bp,t)))   =g= d(b,t);

pr(t)..       sum(mh, mdatah(mh,"avail")*(mdatah(mh,"initcap") + sum(v$vs(t,v), hh(mh,v))))
           +  sum(mt, mdatat(mt,"avail")*sum(v$vs(t,v), kit(mt,v) + ht(mt,v)))
          =g= (1 + prr)*d("peak",t);

cch(mh,t)..   sum(b, zh(mh,b,t)) =l= mdatah(mh,"avail")*(mdatah(mh,"initcap")
                                  +  sum(v$vs(t,v), hh(mh,v)));

cct(mt,v,t)$vs(t,v)..
              sum(b, zt(mt,v,b,t)) =l= mdatat(mt,"avail")*(kit(mt,v) + ht(mt,v));

ech(mh,t)..   sum(b, dur(b)*zh(mh,b,t)) =l= mdatah(mh,"e-fact")*( mdatah(mh,"initcap")
                                         +  sum(v$vs(t,v), hh(mh,v)));

hcc(t)..      sum(mh, mdatah(mh,"initcap") + sum(v$vs(t,v), hh(mh,v))) =l= r*d("peak",t);

rch(mh)..     sum(t, hh(mh,t)) =l= mdatah(mh,"maxcap");

cat(mt)..     htt(mt) =e= sum(v, ht(mt,v));

ak(t).. phic(t) =e= sum(mh, sigma(mh)*mdatah(mh,"capcost")*sum(v$vs(t,v), hh(mh,v)))
                 +  sum(mt, sigma(mt)*sum(v, capcostt(mt,v,t)*ht(mt,v)));

ao(t).. phio(t) =e= sum(mh, mdatah(mh,"opcost")*sum(b, dur(b)*zh(mh,b,t)))
                 +  sum((mt,v)$vs(t,v), opcostt(mt,v,t)*sum(b, dur(b)*zt(mt,v,b,t)));

***
* .. _section_objective:
*
* Objective function
* ------------------
*
* The objective function of the MESSAGEix core model 2
* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*
* .. _equation_objective:
*
* Equation OBJECTIVE
* """"""""""""""""""
*
* The objective function (of the core model) minimizes total discounted systems costs including costs for emissions,
* relaxations of dynamic constraints
*
* .. math::
*    OBJ = \sum_{n,y \in Y^{M}} df\_period_{y} \cdot COST\_NODAL_{n,y}
*
***
obj..       phi =e= sum(t, delta(t)*(phic(t) + phio(t)));

hh.lo(mh,t) = hlo(mh,t);
hh.up(mh,t) = hup(mh,t);
ht.lo(mt,t) = tlo(mt,t);
ht.up(mt,t) = tup(mt,t);
htt.up(mt)  = mdatat(mt,"maxcap");

Model turkey / all /;