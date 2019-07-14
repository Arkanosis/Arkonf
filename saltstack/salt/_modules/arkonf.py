import logging

logger = logging.getLogger(__name__)

__virtual_name__ = 'arkonf'

def __virtual__():
    return __virtual_name__

def allowed_ssh_users(users, local_users):
    return _allowed_users(users, local_users, 'ssh', 'sftp')

def allowed_sftp_users(users, local_users):
    return _allowed_users(users, local_users, 'sftp')

def _allowed_users(users, local_users, *conditions):
    logger.debug('users ({}): {}'.format(conditions, users))
    allowed_users = []
    for user in users:
        if user['login'] in local_users:
            for condition in conditions:
                if user.get(condition, False):
                    allowed_users.append(user)
                    break
    logger.debug('allowed_users ({}): {}'.format(conditions, allowed_users))
    return allowed_users

def lines(file_path):
    try:
        with open(file_path) as file:
            for line in file:
                if not line.startswith('#'):
                    yield line.rstrip()
    except IOError:
        return

def key_values(file_path):
    for line in lines(file_path):
        yield line.split(' ')
