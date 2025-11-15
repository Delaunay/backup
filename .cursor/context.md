The project is managing a lifestyle web app.
The web app is 100% local and use sqlite.
It can be deployed statically to a github page, as such the frontend has two mode:

* static mode: display data from json file hosted alongside the frontend
* edit mode: display the data using the flask server as backend

* /database.db: the sqlite database we display
* /recipes: the recipe website (UI + backend)
    * recipes/server: flask server
    * recipes/ui: the React Front end (use ChakraUI library)
        * src/services/api.ts: All the AJAX calls made by the frontend to the backend
          The frontend only calls method inside api.ts
          api.ts is the only location that interacts with the backend
    * recipes/cli: Tool to manage the webapp
    * recipes/alembic: used to update and migrate the sqlite database
    * scripts/static_generator.py: used to generate a static version of the website
* /static: Built static version of the website
* /uploads/: images uploaded by the users, one folder = one recipe


I would like the app to be a one stop, place to do all life related planning and become a safe and secure
spot to share things like password or journaling.

We want the planning to be as easy as possible to limit the amount of energy one person puts to be able to plan
things. We want to automate as much as possible and be able to work with missing data and provide
easy way for the user to provide it when necessary or deduce it when possible.

Features
--------

* Receipt tracking
* Calendar
    * Event
* Todo lists
* Telegram Integration
* KeyValue Store
* Cooking Recipe
    * Unit Conversion
* Meal Planning
    * Nutrition Info
    * Budget
* Nutrition Info
* Blog | Project tracking
    * Hobbies


Doable
------

* Mode telegram integration
* Garmin Integration ?
* Google Calendar Import / Export ?
* Password manager
