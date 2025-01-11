from flask import Flask, jsonify
# context in the Docker container is different from the local context (unit tests)
try:
    from db import Database
    from utils import get_env
except ImportError:
    from .db import Database
    from .utils import get_env

MYSQL_USER = get_env('MYSQL_USER_FILE') or get_env('MYSQL_USER') or None
MYSQL_PASS = get_env('MYSQL_PASSWORD_FILE') or get_env('MYSQL_PASSWORD') or None
MYSQL_DB = get_env('MYSQL_DATABASE_FILE') or get_env('MYSQL_DATABASE') or None
MYSQL_HOST = get_env('MYSQL_HOST') or None

db = Database(MYSQL_USER, MYSQL_PASS, MYSQL_DB, MYSQL_HOST)
app = Flask(__name__)


@app.before_request
def before_request():
    db.conn()

    if db.cursor is None:
        return jsonify({'error': 'No database connection!'}), 500

@app.route('/api', methods=['GET'])
def message():
    data = {'message': 'API is working!'}
    return jsonify(data)

@app.route('/api/user', methods=['GET'])
def get_users():
    data = None
    result = db.get_all("users")

    if result:
        data = result
        return jsonify(data)
    else:
        data = []
        return jsonify(data), 404


@app.route('/api/user/<int:id>', methods=['GET'])
def get_user(id):
    data = None
    result = db.get_one("users", id)

    if result:
        data = result
        return jsonify(data)
    else:
        return jsonify({'error': 'User not found!'}), 404

if __name__ == '__main__':
    app.run()