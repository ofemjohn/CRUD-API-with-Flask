from flask import Flask, request, jsonify



app = Flask(__name__)


items = []


@app.route('/')
def home():
    return "Welcome to the Flask CRUD API!"


# create item
@app.route('/items', methods=['POST'])
def create_item():
    new_item = request.get_json()
    items.append(new_item)
    return jsonify(new_item), 201

# get all items
@app.route('/items', methods=['GET'])
def get_items():
    return jsonify(items)


# get a single item
@app.route('/items/<int:index>', methods=['GET'])
def get_item(index):
    index = index - 1
    if index < 0 or index >= len(items):
        return jsonify({'erro': 'Item not found'}), 404
    return jsonify(items[index])


# update items
@app.route('/items/<int:index>', methods=['PUT'])
def update_item(index):
    index = index - 1
    if index < 0 or index >= len(items):
        return jsonify({'error': 'Item not found'}), 404
    updated_item = request.get_json()
    items[index] = updated_item
    return jsonify(updated_item)


# delete an item
@app.route('/items/<int:index>', methods=['DELETE'])
def delete_item(index):
    index = index - 1
    if index < 0 or index >= len(items):
        return jsonify({'error': 'Item not found'}), 404
    deleted_item = items.pop(index)
    return jsonify(deleted_item)


if __name__ == '__main__':
    app.run(debug=True)
