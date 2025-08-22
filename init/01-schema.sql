CREATE USER appuser IDENTIFIED BY apppwd;

GRANT CONNECT, RESOURCE TO appuser;

-- Grant unlimited quota on USERS tablespace
ALTER USER appuser QUOTA UNLIMITED ON USERS;