# Docker Swarm Boat Cluster

## Environment

### Management

- Private IP: 172.31.52.186
- Remote access: ssh -i boatkey.pem ubuntu@54.202.10.46
- Role: MySQL NDB Cluster Management Server / Docker Swarm Manager

### Worker 1

- Private IP: 172.31.48.221
- Remote access: ssh -i boatkey.pem ubuntu@54.190.172.233
- Role: MySQL NDB API Server / Docker Swarm Worker

### Worker 2

- Private IP: 172.31.48.110
- Remote access: ssh -i boatkey.pem ubuntu@35.160.227.14
- Role: MySQL NDB API Server / Docker Swarm Worker

## Files in this folder

### Docker related files/folders

**web-app/** - web-app docker image

**docker-compose.yml** - docker containers configuration

### Shell scripts

**deploy-swarm.sh** - Script to deploy web app cluster using docker swarm

**init-swarm.sh** - Commands to initalize the swarm

**install-docker.sh** - Script to install docker in a vm during launch

**publish-images.sh** - Script to publish images in Docker Hub

**util.sh** - Utility commands

## Instalation (Ubuntu Linux 18.04)

1. Clone the project repository into one of the machines, and enter the *~/csc462boatsql/swarm* folder;

2. Execute the script *install-docker-(linux|ubuntu).sh* to install docker on all machines that will be part of the swarm.

3. Initialize and join the swarm from all machines which are part of the swarm. See *init-swarm.sh*.

4. Execute the script to initialize the database: *mysql -u root -p < ../boat.sql*

5. Create the application user in the database:

    ```sql
    CREATE USER 'boatuser'@'%' identified by 'boatpass';
    GRANT ALL ON boatdb.* to 'boatuser'@'%' identified by 'boatpass';
    ```

6. Execute the script *deploy-swarm.sh*
