

# /home/setepenre/recipes/website/.venv/bin/python3 /home/setepenre/recipes/website/.venv/bin/waitress-serve --port 8081 --call recipes.server.run:entry


virtual-env:
	virtualenv .venv
	(. .venv/bin/activate && pip install -e recipes)

install:
	(. .venv/bin/activate && pip install -e recipes)

back-dev:
	(. .venv/bin/activate && FDC_API_KEY=tXSwKmAk5Y3nWz8ZavdAnWRLempYL8zFhOc9qzxa FLASK_STATIC=$(pwd) flask --debug --app recipes.server.run:entry run --port 5001)

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

current:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/recipes/alembic/alembic.ini current)


telegram:
	(. .venv/bin/activate && python recipes/recipes/server/messaging.py)

test-deploy:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python recipes/scripts/static_generator.py)


deploy-dev:
	sudo cp deploy/okasan-flask.service /etc/systemd/system/okasan-flask.service
	sudo cp deploy/okasan-vite.service /etc/systemd/system/okasan-vite.service
	sudo cp deploy/okasan.target /etc/systemd/system/okasan.target

start-services:
	sudo systemctl enable okasan.target
	sudo systemctl start okasan.target

update-services: deploy-dev
	sudo systemctl daemon-reload
	sudo systemctl restart okasan.target

flask-logs:
	sudo journalctl -u okasan-flask.service -f

vite-logs:
	sudo journalctl -u okasan-vite.service -f
