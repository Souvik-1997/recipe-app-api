FROM python:3.9-alpine3.13
LABEL maintainer="souvik_chatterjee"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
# python -m venv /py : This is the actual command being executed. It's using Python to create a virtual environment (abbreviated as "venv") in the /py directory.
# && : This is a shell operator that means "and then". It's used to chain multiple commands together in a single line. In this case, it's saying to execute the next command only if the previous one (the python -m venv /py command) succeeds.
# \ : The backslash at the end of the line is used to indicate that the command continues on the next line. It's an escape character that tells Docker that the command is not complete and should be continued on the next line.
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    # The -f or --force option, This option skips the confirmation prompt and allows for the immediate deletion of the specified files.
    # Running the "rm -rf" command with root privileges on the root partition "/" will result in the deletion of all its contents.
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user