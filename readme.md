# R↔FLIP: Fast React Local Infrastructure Platform

[![Docker](https://img.shields.io/badge/Docker-24.0+-blue?logo=docker&logoColor=white)](https://www.docker.com/)
[![Vite](https://img.shields.io/badge/Vite-Latest-646CFF?logo=vite&logoColor=white)](https://vitejs.dev/)
[![React](https://img.shields.io/badge/React-Latest-61DAFB?logo=react&logoColor=white)](https://react.dev/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-v3-38B2AC?logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)
[![Nginx](https://img.shields.io/badge/Nginx-Alpine-009639?logo=nginx&logoColor=white)](https://nginx.org/)


**R↔FLIP** (Fast React Local Infrastructure Platform) is a containerized, production-ready blueprint for bootstrapping and developing modern React single-page applications (SPAs). 

this is a quick-starter for a React SPA with Vite, TailwindCSS,
targeting an NGINX server for production, that can be expanded and integrated into exsisting developement workflows, or for quickly spinning up a local development environment for testing.

---

# 🛠️ Tech Stack & Key Features

* **Frontend:** Vite, React, Tailwind CSS v3, PostCSS, Autoprefixer.
* **Dev Server:** Configured with HMR (Hot Module Replacement) file-polling (`usePolling: true`) to ensure seamless updates across network boundaries and virtual filesystems.
* **Production Web Server:** Nginx Alpine featuring standard SPA routing fallbacks (`try_files`) and aggressive caching headers (`Cache-Control: public, immutable`) for `/assets/`.

---
To ensure the orchestration and containerization layers of **R↔FLIP** execute predictably across different host operating systems, your local environment must meet the following baseline requirements.

---

# 1. Host Software Requirements

## 🐳 Docker Engine & Compose
* **Docker Engine:** Version `24.0.0` or higher is highly recommended to support modern multi-stage builds and advanced metadata handling.
* **Docker Compose:** Compose V2 CLI syntax integration (`docker compose`) is required. If using legacy standalone V1 (`docker-compose`), update your binaries to prevent syntax compatibility issues with modern mapping layers.

## 💻 Supported Integrated Development Environments (IDEs)
To leverage the container injection workflow ("Warping"), you need an editor capable of mounting internal container volumes:
* **Visual Studio Code:** Recommended with the official **Dev Containers** (ms-vscode-remote.remote-containers) extension pack installed.
* **JetBrains IDEs (WebStorm, IntelliJ IDEA):** Version `2023.3+` with native Docker integration enabled.

---

# 2. Base Container Specifications

The platform automatically configures the internal container footprints based on the provided Dockerfiles.

| Service | Base Image | OS Layer | Role / Purpose |
| :--- | :--- | :--- | :--- |
| **`RFLIP_dev`** | `node:26-bookworm` | Debian Linux | Sandboxed Vite compilation, package management, and active development workspace. |
| **`RFLIP_prod`** | `nginx:alpine` | Alpine Linux | Ultra-lightweight, hardened reverse-proxy serving immutable static bundle distributions. |

---

# 3. Network Port Allocations

Before starting the containers, ensure the following ports are unallocated and free from host-side binding conflicts:

* **Port `5173` (TCP):** Utilized exclusively by the internal Vite development engine for local application serving and Hot Module Replacement (HMR) polling traffic.
* **Port `8080` (TCP):** Utilized by the Nginx production container to expose the compiled Single Page Application (SPA) on your local loopback address (`http://localhost:8080`).

---

# 4. Minimum Hardware Recommendations

While containers share host kernel resources, the underlying compilation pipelines dictate the following minimum hardware guidelines:

* **Architecture:** x86_64 or ARM64 (Full Apple Silicon/M-Series optimization supported natively out-of-the-box via official base images).
* **Memory (RAM):** 4 GB minimum allocated to the Docker daemon runtime workspace (8 GB or higher recommended for larger dependency footprints during parallel asset optimization passes).
---

## how to use :

- copy the whole project to your local machine
- edit the ```docker-compose.yml``` file (modify names, ports, etc as you wish)
- run `docker-compose up -d`
- attach VSCODE or any compatible editor to the dev container
- **develop your revolutionary SPA**
- commit to git or any other version control system
- hit ```npm run build```
- head to the prod container adress and enjoy your SPA

---
---

## 👥 Authors & Contributors

* **c-stxrm** - *Core Architecture & Infrastructure Design* - [GitHub](https://github.com/c-stxrm)

---