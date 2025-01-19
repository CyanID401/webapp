import unittest
from unittest.mock import patch, MagicMock
from api.api import app

mock_data = [
    {'name': 'someMockUser55', 'id': 1},
    {'name': 'anotherMockUser22', 'id': 2},
    {'name': 'yetAnotherMockUser33', 'id': 3}
]

class ApiTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

        # Create the patcher objects
        self.db_patcher = patch('api.api.db')
        self.get_all_patcher = patch('api.api.db.get_all')
        self.get_one_patcher = patch('api.api.db.get_one')

        # Start the patchers
        self.mock_db = self.db_patcher.start()
        self.mock_get_all = self.get_all_patcher.start()
        self.mock_get_one = self.get_one_patcher.start()

        # Set up mock cursor
        self.mock_cursor = MagicMock()
        self.mock_cursor.fetchall.return_value = mock_data
        self.mock_cursor.fetchone.return_value = mock_data[0]

        # Set up mock connection
        self.mock_conn = MagicMock()
        self.mock_conn.cursor.return_value = self.mock_cursor

        # Configure db mock
        self.mock_db.connect.return_value = self.mock_conn
        self.mock_db.get_all.return_value = mock_data
        self.mock_db.get_one.return_value = mock_data[0]

    def tearDown(self):
        # Stop all patchers
        self.db_patcher.stop()
        self.get_all_patcher.stop()
        self.get_one_patcher.stop()

    def test_message(self):
        response = self.app.get('/api')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {'message': 'API is working!'})

    def test_get_users(self):
        self.mock_get_all.return_value = mock_data
        response = self.app.get('/api/user')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, mock_data)

    def test_get_user(self):
        self.mock_get_one.return_value = mock_data[0]
        response = self.app.get('/api/user/1')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, mock_data[0])

        self.mock_get_one.return_value = None
        response = self.app.get('/api/user/999')
        self.assertEqual(response.status_code, 404)
        self.assertEqual(response.json, {'error': 'User not found!'})

if __name__ == '__main__':
    unittest.main()