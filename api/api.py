from flask import Flask, jsonify

app = Flask(__name__)

mock_data = [{'name': 'someUser55', 'id': 1}, {'name': 'anotherUser22', 'id': 2}, {'name': 'yetAnotherUser33', 'id': 3}]

@app.route('/api', methods=['GET'])
def message():
    data = {'message': 'API is working!'}
    return jsonify(data)

@app.route('/api/user', methods=['GET'])
def get_users():
    data = mock_data
    return jsonify(data)

@app.route('/api/user/<int:id>', methods=['GET'])
def get_user(id):
    data = None
    for user in mock_data:
        if user['id'] == id:
            data = user
            break
    if data is not None:
        return jsonify(data)
    else:
        return jsonify({'error': 'User not found!'}), 404
    
if __name__ == '__main__':
    app.run()