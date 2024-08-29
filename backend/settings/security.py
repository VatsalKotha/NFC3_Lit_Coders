from flask_jwt_extended import JWTManager
from settings.config import Config

jwt = JWTManager()

def init_jwt(app):
    app.config['JWT_SECRET_KEY'] = Config.JWT_SECRET_KEY
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = Config.JWT_ACCESS_TOKEN_EXPIRES
    jwt.init_app(app)
