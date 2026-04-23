

virtual-env:
	virtualenv .venv
	(. .venv/bin/activate && pip install -e recipes)

install:
	(. .venv/bin/activate && pip install -e recipes)

back-dev:
	(. .venv/bin/activate && FDC_API_KEY=tXSwKmAk5Y3nWz8ZavdAnWRLempYL8zFhOc9qzxa FLASK_STATIC=$(pwd) uvicorn okaasan.server.run:entry --reload --host 0.0.0.0 --port 5001)

back-prod:
	(. .venv/bin/activate && uvicorn okaasan.server.run:entry --host 0.0.0.0 --port 8081)

front-dev:
	(cd recipes/okaasan/ui && npm i && npm run dev)

preprocess-images:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python -m okaasan.tools.preprocess_images)

update-db:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/okaasan/alembic/alembic.ini upgrade head)

make-migration:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/okaasan/alembic/alembic.ini revision --autogenerate -m "migration")

current:
	(. .venv/bin/activate && DATABASE_URI=sqlite://$(pwd)/database.db alembic -c recipes/okaasan/alembic/alembic.ini current)


telegram:
	(. .venv/bin/activate && python recipes/okaasan/server/messaging.py)

test-deploy:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python recipes/scripts/static_generator.py)


deploy-dev:
	(. .venv/bin/activate && uv pip install -e /home/setepenre/work/website/recipes)
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
