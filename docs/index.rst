The turkpow model
*******************

The core turkpow model is a shameless copy of `Turkey Power Planning Model
<turkpow-gams>`_ from the `GAMS`_ modelling library.

.. _`turkpow-gams`: https://www.gams.com/latest/gamslib_ml/libhtml/gamslib_turkpow.html
.. _`GAMS`: https://www.gams.com/

- For the scientific reference of the framework, see Huppmann et al. (2019) :cite:`huppmann_messageix_2018`.
- For an overview and recent publications related to the specific turkpow-GLOBIOM global model instance used at the IIASA ECE Program, see the `MESSAGEix-GLOBIOM documentation`_.


.. _getting-started:

Getting started
===============

.. NB this ReST pattern is repeated throughout this file:

   1. List of :doc:`...` links, followed by
   2. .. toctree:: directive with :hidden:, containing the same links.

   This overcomes limitations of toctree, allowing introductory paragraphs, and different titles in this page than in the sidebar.

- :doc:`framework` detailed description and feature list.
- :doc:`Usage <usage>` of turkpow in academic publications, research projects, and derived tools.

.. toctree::
   :hidden:
   :caption: Getting started

   framework
   Publications, Projects, and Tools <usage>

.. figure:: _static/ix_features.svg
   :width: 360px
   :align: center

   Features of ``ixmp``, ``message_ix``, and related packages :cite:`huppmann_messageix_2018`


.. _core:

Mathematical specification
==========================

These pages provide comprehensive description of the variables and equations in
the core MESSAGEix mathematical implementation.

- :doc:`model/sets_parameters_table_def`
- :doc:`time`
- :doc:`model/model_core`
- :doc:`model/model_solve`
- :doc:`model/reporting`

.. toctree::
   :hidden:
   :caption: Mathematical Specification

   model/sets_parameters_table_def
   time
   model/model_core
   model/model_solve
   model/reporting


Using, getting help, and contributing
=====================================

Everyone is encouraged to use the framework to develop energy system and integrated assessment models!

- :doc:`whatsnew` —release history and migration/upgrade notes.
- :doc:`bibliography`

.. toctree::
   :hidden:
   :caption: Help & reference

   whatsnew
   bibliography

.. _help:

Have a question? Check…

- …on GitHub:

  - Join an existing `discussion <https://github.com/iiasa/message_ix/discussions>`_ or start a new one with your question.
  - Search `current issues <https://github.com/iiasa/message_ix/issues?q=is:issue>`_, or open a new one to report a bug in the code.

- …the message_ix Google Group, either `online <https://groups.google.com/d/forum/message_ix>`_ or via e-mail at <message_ix@googlegroups.com>.

.. _`MESSAGEix-GLOBIOM documentation`: http://data.ene.iiasa.ac.at/message-globiom/
.. _`APACHE 2.0 open-source license`: https://github.com/iiasa/message_ix/blob/main/LICENSE
