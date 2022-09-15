$title Turkey Power Planning Model

$onText
Modified version from GAMS modelling examples to showcase gams and sphinx

This is an investment planning model for the Turkish power
sector to determine the least cost expansion pattern.


Turvey, R, and Anderson, D, Chapter 8: Electricity Development in Turkey:
A Case Study using Linear Programming. In Electricity Economics: Essays
and Case Studies. Johns Hopkins University Press, Baltimore and London,
1977.

Keywords: linear programming, investment planning, energy economics
$offText
$ONDOLLAR

***
* Run script for turkpower
* ==========================
*
* This is turkpower version |version|.
*
* It can be run in several ways:
*
* - directly from the command line, with the input data file name
*   and other options specific as command line parameters, e.g.::
*
*   ``gams run.gms``
*
***


*----------------------------------------------------------------------------------------------------------------------*
* initialize sets, mappings, parameters, load data, do pre-processing                                                  *
*----------------------------------------------------------------------------------------------------------------------*

** initialize sets, mappings, parameters and tables
$INCLUDE sets_parameter_table_def.gms

*----------------------------------------------------------------------------------------------------------------------*
* variable and equation definition, model declaration                                                                  *
*----------------------------------------------------------------------------------------------------------------------*

$INCLUDE model_core.gms

*----------------------------------------------------------------------------------------------------------------------*
* solve statements
*----------------------------------------------------------------------------------------------------------------------*

$INCLUDE model_solve.gms

*----------------------------------------------------------------------------------------------------------------------*
* post-processing
*----------------------------------------------------------------------------------------------------------------------*

$INCLUDE reporting.gms