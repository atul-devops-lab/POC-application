from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
def health_check():
    """Used by orchestrators (e.g. Kubernetes) to verify the service is alive."""
    return {"status": "ok"}


@app.get("/hello/{name}")
def say_hello(name: str):
    return {"message": f"Hello, {name}!"}
