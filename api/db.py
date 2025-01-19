import mysql.connector as mysql
import logging
import json

logging.basicConfig(level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')

class Database:
    def __init__(self, db_user, db_password, db_name, db_host="localhost", db_port=3306):
        self.db_user = db_user
        self.db_password = db_password
        self.db_name = db_name
        self.db_host = db_host
        self.db_port = db_port
        self.db = None
        self.cursor = None

    def conn(self):
        try:
            self.db = mysql.connect(
                host = self.db_host,
                port = self.db_port,
                user = self.db_user,
                password = self.db_password,
                database = self.db_name
            )
            self.cursor = self.db.cursor(dictionary=True)
        except mysql.Error as e:
            logging.error(f"MySQL Error: {e}")

    def get_all(self, table):
        try:
            if self.cursor:
                self.cursor.execute(f"SELECT * FROM {table}")
                result = self.cursor.fetchall()
                return result
        except mysql.Error as e:
            logging.error(f"MySQL Error: {e}")
        finally:
            if self.cursor:
                self.cursor.close()

    def get_one(self, table, id):
        try:
            if self.cursor:
                self.cursor.execute(f"SELECT * FROM {table} WHERE id={id}")
                result = self.cursor.fetchone()
                return result
        except mysql.Error as e:
            logging.error(f"MySQL Error: {e}")
        finally:
            if self.cursor:
                self.cursor.close()