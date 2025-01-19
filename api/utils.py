import os

def read_path(file_path):
    with open(file_path, 'r') as file:
        return file.read().strip()

def get_env(var_name):
    try:
        if "_FILE" in var_name:
            env_file_path = os.environ[var_name]
            return read_path(env_file_path)
        elif var_name in os.environ:
            return os.environ[var_name]
        else:
            return None
    except KeyError:
        return None