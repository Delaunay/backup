Recipe Website
==============

This is the data repository of the recipe website.
Fork this repo to create your own.

Folder Structure
----------------

.. code-block::

    website/
    ├── .github/             Built website
    │   └── workflow
    |       └── deploy.yml   Deploy automatically to github pages
    ├── .venv                Python virtualenv for the server
    ├── static/              Built website
    ├── uploads/             Image and uploaded files
    ├── recipes/             Website Code
    │   └── recipes
    │       ├── server       Flask Back End
    │       └── tools       
    │       └── ui           React Front End
    ├── database.db          Sqlite3 Database
    └── Makefile             Makefile helper



Getting Started
---------------

* Have npm installed
* have virtualenv and python installed

.. code-block::

    git clone https://github.com/Delaunay/backup website
    cd website

    git clone https://github.com/Delaunay/recipes recipes/

    virtualenv .venv
    source .venv/bin/activate
    pip install -e recipes

    make back-dev &
    make front-dev &


Database Change
---------------

if the recipe website make database updates you can propagate them to the database using

.. code-block::

   make update-db
