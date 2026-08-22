from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_say_hello():
    response = client.get("/hello/Atul")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello, Atul!"}
