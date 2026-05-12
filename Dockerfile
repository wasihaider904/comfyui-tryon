FROM runpod/worker-comfyui:5.8.5-base

RUN comfy-node-install comfyui-gguf
RUN comfy-node-install comfyui-kjnodes
RUN comfy-node-install was-node-suite-comfyui
RUN comfy-node-install comfyui_essentials

RUN cd /comfyui/custom_nodes && \
    wget -O sam3.zip "https://huggingface.co/samiyoya/loras/resolve/main/comfyui-sam3.zip" && \
    mkdir -p comfyui-sam3 && \
    cd comfyui-sam3 && \
    python3 -c "import zipfile; zipfile.ZipFile('../sam3.zip').extractall('.')" && \
    pip install -r requirements.txt && \
    cd .. && rm sam3.zip

RUN rm -rf /workspace && ln -s /runpod-volume /workspace
