FROM runpod/worker-comfyui:5.8.5-base

# Install custom nodes
RUN comfy-node-install comfyui-gguf
RUN comfy-node-install comfyui-kjnodes
RUN comfy-node-install was-node-suite-comfyui
RUN comfy-node-install comfyui_essentials

# Install SAM3 from source
RUN cd /comfyui/custom_nodes && \
    wget -O sam3.zip "https://huggingface.co/samiyoya/loras/resolve/main/comfyui-sam3.zip" && \
    mkdir -p comfyui-sam3 && \
    cd comfyui-sam3 && \
    python3 -c "import zipfile; zipfile.ZipFile('../sam3.zip').extractall('.')" && \
    pip install -r requirements.txt && \
    cd .. && rm sam3.zip

# Create model directories
RUN mkdir -p /comfyui/models/unet \
    && mkdir -p /comfyui/models/clip \
    && mkdir -p /comfyui/models/vae \
    && mkdir -p /comfyui/models/sam3

# Download Klein 9B Q6_K model (~9 GB)
RUN wget --progress=dot:giga -O /comfyui/models/unet/flux-2-klein-9b-Q6_K.gguf \
    "https://huggingface.co/unsloth/FLUX.2-klein-9B-GGUF/resolve/main/flux-2-klein-9b-Q6_K.gguf"

# Download Qwen3 8B Q6_K text encoder (~7 GB)
RUN wget --progress=dot:giga -O /comfyui/models/clip/Qwen3-8B-Q6_K.gguf \
    "https://huggingface.co/Qwen/Qwen3-8B-GGUF/resolve/main/Qwen3-8B-Q6_K.gguf"

# Download Flux2 VAE (~300 MB)
RUN wget --progress=dot:giga -O /comfyui/models/vae/flux2-vae.safetensors \
    "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors"

# Download SAM3 model (~600 MB)
RUN wget --progress=dot:giga -O /comfyui/models/sam3/sam3.pt \
    "https://huggingface.co/bodhicitta/sam3/resolve/main/sam3.pt"
