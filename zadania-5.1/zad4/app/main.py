import os

port = os.getenv("APP_PORT", "8000")
print(f"server running {port}")
