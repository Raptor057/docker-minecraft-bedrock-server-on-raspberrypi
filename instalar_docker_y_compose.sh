#!/bin/bash

echo "==================================="
echo " Instalación de Docker y Docker Compose en Raspbian "
echo "==================================="

# Actualizar el sistema
echo "1. Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar los requisitos previos
echo "2. Instalando los paquetes necesarios..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Añadir la clave GPG de Docker
echo "3. Añadiendo la clave GPG de Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Añadir el repositorio de Docker
echo "4. Añadiendo el repositorio de Docker..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker
echo "5. Instalando Docker..."
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verificar la instalación de Docker
echo "6. Verificando la instalación de Docker..."
docker --version

# (Opcional) Añadir usuario al grupo Docker
echo "7. Añadiendo el usuario actual al grupo Docker..."
sudo usermod -aG docker $USER

# Habilitar Docker al inicio del sistema
echo "8. Habilitando Docker para iniciar con el sistema..."
sudo systemctl enable docker
sudo systemctl start docker

# Instalar Docker Compose
echo "9. Instalando Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Dar permisos de ejecución a Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Verificar la instalación de Docker Compose
echo "10. Verificando la instalación de Docker Compose..."
docker-compose --version

# Verificar la instalación de Docker
echo "10. Verificando la instalación de Docker ..."
docker --version

echo "==================================="
echo " Docker y Docker Compose se han instalado correctamente "
echo "==================================="
echo "Nota: Si no puedes usar Docker sin 'sudo', reinicia tu sesión o usa el comando: 'newgrp docker'"


# Iniciar minecraft-bedrock-server
echo "11. Iniciando servidor minecraft-bedrock-server..."
docker-compose up -d

