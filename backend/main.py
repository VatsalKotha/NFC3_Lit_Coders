from flask import Flask
from settings.security import init_jwt
from routes.auth_routes import auth_bp
from routes.main_routes import main_bp

app = Flask(__name__)
init_jwt(app)

app.register_blueprint(auth_bp, url_prefix="/auth")
app.register_blueprint(main_bp)

if __name__ == "__main__":
    app.run(debug=True,port=10000)
