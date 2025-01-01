FROM python:alpine

WORKDIR /api

RUN adduser -D api-user

ENV PATH="/home/api-user/.local/bin:${PATH}"
RUN chown api-user:api-user /api

USER api-user

COPY --chown=api-user requirements.txt requirements.txt 

RUN pip install -r requirements.txt 

COPY --chown=api-user . .

EXPOSE 8000

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "api:app"]