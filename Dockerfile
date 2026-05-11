FROM runpod/worker-comfyui:5.8.5-base

# Install custom nodes via official registry (reliable)
RUN comfy node install --exit-on-fail comfyui-gguf@1.1.10 --mode remote
RUN comfy node install --exit-on-fail comfyui-sam3@0.3.10

# Install via git for nodes not in registry
RUN git clone https://github.com/kijai/ComfyUI-KJNodes /comfyui/custom_nodes/ComfyUI-KJNodes && \
    cd /comfyui/custom_nodes/ComfyUI-KJNodes && \
    pip install -r requirements.txt

RUN git clone https://github.com/WASasquatch/was-node-suite-comfyui /comfyui/custom_nodes/was-node-suite-comfyui && \
    cd /comfyui/custom_nodes/was-node-suite-comfyui && \
    pip install -r requirements.txt
