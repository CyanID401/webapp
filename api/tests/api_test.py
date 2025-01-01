import unittest
from api.api import app

class ApiTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_message(self):
        response = self.app.get('/api')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {'message': 'API is working!'})

    def test_get_users(self):
        response = self.app.get('/api/user')
        self.assertEqual(response.status_code, 200)
        self.assertTrue(isinstance(response.json, list))
        self.assertTrue(len(response.json) >= 0)

    def test_get_user(self):
        response = self.app.get('/api/user/1')
        self.assertEqual(response.status_code, 200)
        self.assertTrue(isinstance(response.json, dict))

        response = self.app.get('/api/user/999')
        self.assertEqual(response.status_code, 404)
        self.assertEqual(response.json, {'error': 'User not found!'})

if __name__ == '__main__':
    unittest.main()