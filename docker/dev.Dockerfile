# @file dev.Dockerfile
# @brief Builds a development-ready Vite React image
# @author c-stxrm

# Sets the base image to official Node.js version 26 built on top of the Debian Bookworm Linux distribution.
FROM node:26-bookworm

# Declares official image metadata
# Defines the specific version number for this build
LABEL version="1.0.0"

# Sets the internal working directory to /app. 
# All subsequent relative-path commands execute inside this folder.
WORKDIR /app

# 1. Install system utilities
# Updates the apt package manager cache, 
#installs essential command-line tools (git, curl, wget, nano, vim, bash-completion), 
# and deletes the apt cache lists afterward to reduce final image size.
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    nano \
    vim \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# 2. Scaffold core Vite React project and install baseline dependencies
# Executes the Vite CLI initialization script to generate
# a React template directly into the /app directory (overwriting files if necessary),
# installs the default dependencies listed in the newly generated package.json,
# and modifies the "build" script entry in package.json to 
# output production assets explicitly to the "dist" directory.
RUN npm create vite@latest . -- --template react --force && \
    npm install
RUN npm pkg set scripts.build="vite build --outDir dist"

# 3. Safely extend the project with plugins and Tailwind v3
# Installs development dependencies for the Vite React plugin, 
# Tailwind CSS v3, PostCSS, and Autoprefixer.
# Deletes the default TypeScript Vite configuration file (if present) 
# and generates default configuration files for Tailwind and PostCSS.
RUN npm install -D @vitejs/plugin-react tailwindcss@3 postcss autoprefixer && \
    rm -f vite.config.ts && \
    npx tailwindcss@3 init -p

# Inject content paths into tailwind.config.js
# Uses the stream editor (sed) to search tailwind.config.js
# and replace the empty content array with the file paths required 
# for Tailwind to scan for utility classes.
RUN sed -i 's|content: \[\]|content: ["./index.html","./src/**/*.{js,ts,jsx,tsx}"]|' tailwind.config.js

# Overwrite index.css with Tailwind directives
# Overwrites the contents of src/index.css with the standard three Tailwind CSS layer directives.
RUN echo '@tailwind base;\n@tailwind components;\n@tailwind utilities;' > src/index.css

# 4. Clean, safe HMR configuration (guaranteed to target the active config file)
# Creates or overwrites a JavaScript-based vite.config.js 
# file using a Here Document (EOF).
# Configures Vite to bind the development server 
mto all network interfaces (0.0.0.0) 
# and enables polling-based file watching for hot module replacement (HMR).
RUN cat > vite.config.js <<'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    watch: {
      usePolling: true
    }
  }
})
EOF

# Port for App 
# Informs container runtimes that the container 
#listens on network port 5173 at runtime (the default Vite dev server port).
EXPOSE 5173

# Boot straight into the dev server with double-insurance network binding
# Defines the default execution command for the container 
# to start the Vite development server, explicitly appending the --host 0.0.0.0 flag to ensure external network access.
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]