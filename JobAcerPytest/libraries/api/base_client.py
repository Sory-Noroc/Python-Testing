import requests

class BaseClient:
    def __init__(self, base_url: str):
        self.base_url = base_url
        self.session = requests.Session()

    def add_token(self, token: str):
        """Persist a bearer token for all future requests in this session."""
        self.session.headers.update({"Authorization": f"Bearer {token}"})
        return self

    def get(self, endpoint: str, **kwargs):
        """Execute GET and return the response."""
        return self.session.get(f"{self.base_url}{endpoint}", **kwargs)

    def post(self, endpoint: str, data=None, json=None, **kwargs):
        """Execute POST and return the response."""
        return self.session.post(f"{self.base_url}{endpoint}", data=data, json=json, **kwargs)