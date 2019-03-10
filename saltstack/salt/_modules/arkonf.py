import logging

logger = logging.getLogger(__name__)

__virtual_name__ = 'arkonf'

def __virtual__():
    return __virtual_name__

def allowed_ssh_users(users):
    return _allowed_users(users, 'ssh', 'sftp')

def allowed_sftp_users(users):
    return _allowed_users(users, 'sftp')

def _allowed_users(users, *conditions):
    logger.debug('users ({}): {}'.format(conditions, users))
    allowed_users = []
    for user in users:
        for condition in conditions:
            if user.get(condition, False):
                allowed_users.append(user)
                break
    logger.debug('allowed_users ({}): {}'.format(conditions, allowed_users))
    return allowed_users
