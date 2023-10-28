# recipe-app-api
Recipe API project

# Create django project in docker
docker-compose run --rm app sh -c "django-admin startproject app ."

# Run docker app, When you run `docker-compose up` in the directory containing your `docker-compose.yml` file, it will create and start containers for each service, based on the configuration you've defined.
docker-compose up 