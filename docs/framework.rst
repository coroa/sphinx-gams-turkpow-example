turkpow model
*****************************

turkpow is a simple copy from the `GAMS`_ modelling library of the 

Model components
====================

.. figure:: _static/ix_components.png

   Components and their interlinkages in the ixmp (:cite:`huppmann_messageix_2018`): web-based user interface, scientific
   programming interface, modeling platform, database backend, implementation
   of the turkpow mathematical model formulation.


**MESSAGE** is a specific mathematical formulation of a model developed for strategic energy planning and integrated assessment of energy-engineering-economy-environment systems (E4).
The formulation included in :mod:`message_ix` is a re-implementation and extension of “MESSAGE V” (Messner and Strubegger, 1995 :cite:`messner_users_1995`), the integrated assessment model developed at IIASA since the 1980s.
The optimization model can be linked to the general-equilibrium **MACRO** model to incorporate feedback between prices and demand levels for energy and commodities.
The :mod:`message_ix` package includes code for both MESSAGE, MACRO, and the MESSAGE-MACRO link.
These are written in the `GAMS`_ mathematical programming language.
:mod:`message_ix` uses GAMS to compute the numerical solution of a model instance.

.. _`GAMS`: http://www.gams.com

.. _running:

Running a model
===============

There are two ways to run a turkpow model:

1. Using the file ``run.gms``, where the scenario name (i.e., the
   gdx input file), the optimization horizon (perfect foresight or myopic/
   rolling-horizon version), and other options can be defined explicitly.

   *This approach is recommended for users who prefer to work via GAMS IDE or
   other text editors to set the model specifications.*

2. Directly from the command line calling the file ``run.gms``.
   The scenario name and other arguments can be passed as
   command line parameters::

       $ gams MESSAGE_run.gms --in="<data-file>" --out="<output-file>"

Auto-generated documentation for the model run scripts is provided:

.. toctree::

   model/run
