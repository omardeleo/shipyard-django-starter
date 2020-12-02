FROM python:3.9.0-alpine

WORKDIR /code

# Install system dependencies for: uWSGI, poetry, watchman
RUN apk add --update --no-cache \
  gcc \
  libc-dev \
  libffi-dev \
  openssl-dev \
  bash \
  git \
  libtool \
  m4 \
  g++ \
  autoconf \
  automake \
  build-base \
  postgresql-dev

# Install poetry
RUN pip install poetry

# Install Python dependencies
ADD pyproject.toml poetry.lock /code/
RUN poetry install

# Add the project
# NOTE Run the install again to install the project
ADD . /code/
RUN poetry install

# Set the default command
CMD ["poetry", "run", "python", "manage.py", "runserver", "0:8080"]