#!/usr/bin/env bash
set -euo pipefail

# Ensure script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Error: This script must be run as root" >&2
  exit 1
fi

# Optional install docker
read -rp "Run one-time docker installation? [y/N]: " answer
if [[ "$answer" =~ ^[Yy] ]]; then

	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo docker run hello-world

fi

# Optional install nvidia drivers
read -rp "Run one-time NVIDIA driver installation? [y/N]: " answer
if [[ "$answer" =~ ^[Yy] ]]; then
        curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
            | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
        curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
            | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
            | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
        sudo apt-get update
        sudo apt-get install -y nvidia-container-toolkit nvtop nvidia-cuda-toolkit
        sudo nvidia-ctk runtime configure --runtime=docker
        sudo systemctl restart docker
fi


# Configuration
NAS_BASE="/var/containers"
GPU_FLAG="--gpus all"
DOCKER_USER="docker"
DOCKER_GROUP="docker"

# Ensure NAS directory structure
mkdir -p "$NAS_BASE/ollama"
mkdir -p "$NAS_BASE/sd/"{checkpoints,loras,embeddings,vae,controlnet,hypernetworks,upscalers}
mkdir -p "$NAS_BASE/comfy/"{checkpoints,loras,embeddings,vae,controlnet,workflows}


# Create dedicated docker user and group if missing
if ! id "$DOCKER_USER" &>/dev/null; then
  groupadd --system "$DOCKER_GROUP"
  useradd  --system --no-create-home --shell /usr/sbin/nologin \
           --gid "$DOCKER_GROUP" "$DOCKER_USER"
fi

# Function to fix permissions for docker user on host paths
fix_permissions() {
  USER_ID=$(id -u "$DOCKER_USER")
  GROUP_ID=$(getent group "$DOCKER_GROUP" | cut -d: -f3)
  chown -R "$USER_ID:$GROUP_ID" "$NAS_BASE"
  chmod -R g+rwX "$NAS_BASE"
}

# Apply permissions fix
fix_permissions

# Helper: create or start container
create_or_start() {
  local name="$1"; shift

  # 1. If container is RUNNING, skip.
  if docker ps --filter "name=^${name}$" --format '{{.Names}}' | grep -q "^${name}$"; then
    echo "✅ ${name} is already running – skipped."
    return
  fi

  # 2. If it exists but is STOPPED, start it.
  if docker ps -a --filter "name=^${name}$" --format '{{.Names}}' | grep -q "^${name}$"; then
    echo "🔄 Starting ${name}"
    docker start "$name"
    return
  fi

  # 3. Otherwise, create it.
  echo "🚀 Creating ${name}"

#--user "$USER_ID:$GROUP_ID" \

  docker run -d \
    --name "$name" \
    --network bridge \
    --restart unless-stopped \
    "$@"
}

# Deploy containers on host network
echo "1. Portainer UI"
docker volume create portainer_data
create_or_start portainer \
  -p 8000:8000 \
  -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:lts
sudo chown -R docker:docker /var/lib/docker/volumes/portainer_data/_data

echo "2. Ollama LLM backend"
create_or_start ollama \
  $GPU_FLAG \
  -p 11434:11434 \
  -e OLLAMA_MAX_QUEUE=256 \
  -v /var/containers/ollama-local:/root/.ollama \
  -v $NAS_BASE/ollama/models:/root/.ollama/models \
  --restart unless-stopped \
  ollama/ollama:latest

#echo " 3. OpenWebUI front-end"
#create_or_start openwebui \
#  -p 3000:8080 \
#  -e OLLAMA_BASE_URL=http://localhost:11434 \
#  -e OLLAMA_API_KEY= \
#  --restart unless-stopped \
#  ghcr.io/open-webui/open-webui:latest

echo "4. Automatic1111 SD WebUI"
create_or_start automatic1111 \
  $GPU_FLAG \
  -p 7860:7860 \
  -v "$NAS_BASE/sd:/stable-diffusion-webui/models" \
  --restart unless-stopped \
  zefie/stable-diffusion-automatic1111:latest

#echo "5. ComfyUI"
#create_or_start comfyui \
#  $GPU_FLAG \
#  -p 8188:8188 \
#  -v "$NAS_BASE/comfy:/root" \
#  --restart unless-stopped \
#  saladtechnologies/comfyui-api:comfy0.3.29-api1.8.3-torchnightly-cuda12.8-runtime


echo " Access URLs: "
echo " • Yacht UI:              http://<host>:8000"
echo " • Ollama API:            http://<host>:11434"
echo " • OpenWebUI:             http://<host>:3000"
echo " • Automatic1111 UI:      http://<host>:7860"
echo " • ComfyUI UI:            http://<host>:8188"
echo " • oobabooga Web UI:      http://<host>:7861"
echo " • oobabooga API:         http://<host>:5000"


