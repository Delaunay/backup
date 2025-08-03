

# /home/setepenre/recipes/website/.venv/bin/python3 /home/setepenre/recipes/website/.venv/bin/waitress-serve --port 8081 --call recipes.server.run:entry


back-dev:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) flask --debug --app recipes.server.run:entry run --port 5001)


back-prod:
	(. .venv/bin/activate && waitress-serve --port 8081 --call recipes.server.run:entry)


front-dev:
	(cd ../recipes/ui && npm run dev)


preprocess-images:
	(. .venv/bin/activate && FLASK_STATIC=$(pwd) python -m recipes.tools.preprocess_images)

