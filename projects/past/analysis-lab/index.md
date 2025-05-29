---
layout: project
title: Analysis Lab — Hardware & Software Stack
blurb: My new homelab architecture
---

# Analysis Lab — Hardware & Software Stack, Methodology

*Last updated: May 26 2025*

---

## 1  Servers

| Hostname         | Model                       | CPUs (total cores)                             | Memory          | GPUs                       | PSUs      |
| ---------------- | --------------------------- | ---------------------------------------------- | --------------- | -------------------------- | --------- |
| **edge-router**  | Dell PowerEdge R410         | 2 × Xeon L5520 @ 2.26 GHz (8 cores total)      | 16 GB DDR3 ECC  | –                          | 2 × 500 W |
| **docker-ai**    | Dell PowerEdge R720         | 2 × Xeon E5‑2670 v2 @ 2.5 GHz (40 cores total) | 256 GB DDR3 ECC | 2 × NVIDIA Tesla P40 24 GB | 2 × 750 W |
| **docker-logic** | Dell PowerEdge R630 (8 SFF) | 2 × Xeon E5‑2680 v3 @ 2.4 GHz (48 cores total) | 128 GB DDR4 ECC | –                          | 2 × 750 W |

Both servers run **Ubuntu 24 LTS** with a single, root‑based Docker daemon. The edge router runs **pfSense** and also hosts a **WireGuard** tunnel for remote/public access to the internal network.

---

## 2  AI Server (`docker-ai`) Containers

| Container              | Image                                         | GPU | Host Ports   | Notes                                                  |
| ---------------------- | --------------------------------------------- | --- | ------------ | ------------------------------------------------------ |
| Portainer              | `portainer/portainer-ce:lts`                  | –   | 9443 (HTTPS) | Runs as root (`-u 0:0`) to avoid cert‑dir permissions  |
| Ollama                 | `ollama/ollama:latest`                        | ✅   | 11434        | Models stored in `/var/containers/ollama` (bind‑mount) |
| Stable‑Diffusion WebUI | `zefie/stable-diffusion-automatic1111:latest` | ✅   | 7860         | Model assets bind‑mounted from `/var/containers/sd`    |

---

## 3  Logic Server (`docker-logic`) Containers

| Container | Image                                  | Host Ports  | Notes                                                                    |
| --------- | -------------------------------------- | ----------- | ------------------------------------------------------------------------ |
| Portainer | `portainer/portainer-ce:lts`           | 9443 / 8000 | Runs as root inside                                                      |
| OpenWebUI | `ghcr.io/open-webui/open-webui:latest` | 3000        | `OLLAMA_BASE_URL=http://docker-ai:11434`                                 |
| Dashy     | `lissy93/dashy:latest`                 | 8088        | Config & icons bind‑mounted from `/home/cj/docker/dashy`                 |
| Jellyfin  | `jellyfin/jellyfin:latest`             | 8096        | Config & cache in `/srv/jellyfin`; media on local disks                  |
| GitLab    | `gitlab/gitlab-ce:latest`              | 8929 / 2222 | Persistent volumes `gitlab_config`, `gitlab_data`; self‑hosted code repo |

---


## 4 Setup Scripts

- [Script To Set Up AI Server](./startAI.sh)
- [Script To Set Up Logic Server](./startLogic.sh)
