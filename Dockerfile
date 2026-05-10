FROM runpod/worker-comfyui:5.2.0-base

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/city96/ComfyUI-GGUF.git && \
    cd ComfyUI-GGUF && pip install -r requirements.txt

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    cd ComfyUI-KJNodes && pip install -r requirements.txt

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
    cd was-node-suite-comfyui && pip install -r requirements.txt

RUN cd /comfyui/custom_nodes && \
    wget -O sam3.zip "https://huggingface.co/samiyoya/loras/resolve/main/comfyui-sam3.zip" && \
    mkdir -p comfyui-sam3 && \
    cd comfyui-sam3 && \
    python3 -c "import zipfile; zipfile.ZipFile('../sam3.zip').extractall('.')" && \
    pip install -r requirements.txt && \
    cd .. && rm sam3.zip
