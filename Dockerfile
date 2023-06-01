FROM ubuntu:23.10

ADD ./version version

WORKDIR app

RUN apt-get update && \
apt-get install -y git pkg-config bash \
python3-full python3-pip python3-aiohttp python3-google-auth &&\
update-alternatives --install /usr/bin/python python /usr/bin/python3 1 &&\
pip install \
--break-system-packages \
setuptools==66 \
scipy transformers huggingface_hub packaging tqdm requests cython \
torch onnx && apt-get clean -y

# RUN git clone --depth=1 https://github.com/FlagAI-Open/FlagAI.git
RUN git clone --depth=1 https://github.com/xxaier/FlagAI.git

ADD os/ /

RUN cd FlagAI && python setup.py install || ( pip uninstall urllib3 && python setup.py install )
