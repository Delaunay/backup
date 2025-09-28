

# /home/setepenre/recipes/website/.venv/bin/python3 /home/setepenre/recipes/website/.venv/bin/waitress-serve --port 8081 --call recipes.server.run:entry


virtual-env:
	virtualenv .venv
	(. .venv/bin/activate && pip install -e recipes)

install:
	(. .venv/bin/activate && pip install -e recipes)

back-dev:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) flask --debug --app recipes.server.run:entry run --port 5001)

back-prod:
	(. .venv/bin/activate && waitress-serve --port 8081 --call recipes.server.run:entry)

front-dev:
	(cd recipes/recipes/ui && npm i && npm run dev)

preprocess-images:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python -m recipes.tools.preprocess_images)

update-db:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/recipes/alembic/alembic.ini upgrade head)

make-migration:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/recipes/alembic/alembic.ini revision --autogenerate -m "migration")


telegram:
	(. .venv/bin/activate && python recipes/recipes/server/messaging.py)

test-deploy:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python recipes/scripts/static_generator.py)
