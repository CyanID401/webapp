from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api', methods=['GET'])
def message():
    data = {'message': 'API is working!'}
    return jsonify(data)
    
if __name__ == '__main__':
    app.run()