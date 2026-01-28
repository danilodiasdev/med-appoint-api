from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def get_health_status():
    """
    Checks the API health status.
    """
    return {
        "status": "online",
        "manager": "uv",
        "language": "english"
    }

@app.get("/appointments")
def list_appointments():
    """
    Placeholder for listing medical appointments.
    """
    return {"appointments": []}