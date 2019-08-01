# Stop all containers
echo "Stoping all containers..."
docker stop `docker ps -qa`

# Remove all containers
echo "Removing all containers..."
docker rm `docker ps -qa`

# Remove all images
echo "Removing all images..."
docker rmi -f `docker images -qa `

# Remove all volumes
echo "Removing all volumes..."
docker volume rm $(docker volume ls -q)

# Remove all networks
echo "Removing all networks..."
docker network rm `docker network ls -q`

# Your installation should now be all fresh and clean.
echo "Checking..."

# The following commands should not output any items:
docker ps -a
docker images -a 
docker volume ls

# The following command show only show the default networks:
docker network ls
