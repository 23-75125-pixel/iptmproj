from src.app import create_app


def test_routes_load():
    app = create_app()
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert b"SEMCDS" in response.data
