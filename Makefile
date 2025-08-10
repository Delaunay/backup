

# /home/setepenre/recipes/website/.venv/bin/python3 /home/setepenre/recipes/website/.venv/bin/waitress-serve --port 8081 --call recipes.server.run:entry


virtual-env:
	virtualenv .venv
	pip install -e .. 

back-dev:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) flask --debug --app recipes.server.run:entry run --port 5001)


back-prod:
	(. .venv/bin/activate && waitress-serve --port 8081 --call recipes.server.run:entry)


front-dev:
	(cd ../recipes/ui && npm run dev)

preprocess-images:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python -m recipes.tools.preprocess_images)

update-db:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c ../recipes/alembic/alembic.ini upgrade head)

make-migration:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c ../recipes/alembic/alembic.ini revision --autogenerate -m "migration")
