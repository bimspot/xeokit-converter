# ----------------------------------------------------------------------------
# xeokit-converter
# ----------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-focal as xeokit-converter

RUN apt-get -qq update && apt-get -qq install -y  \
  wget \
  unzip \
  git \
  python3.6 \
  curl \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install nodejs -y \
  && apt autoremove -qq  -y \
  && rm -r /var/lib/apt/lists/*

RUN npm install npm@latest -g \
  && npm install xeokit/xeokit-gltf-to-xkt#35c3378849efca927af948ba0c2a293ca17c2da8 -g

# Converting tools

# Version 0.7.0
RUN wget --quiet https://s3.amazonaws.com/ifcopenshell-builds/IfcConvert-v0.7.0-e44e03f-linux64.zip \
  && unzip -q IfcConvert-v0.7.0-e44e03f-linux64.zip -d /usr/lib/IfcConvert \
  && ln -s /usr/lib/IfcConvert/IfcConvert /usr/local/bin/IfcConvert \
  && rm -rf IfcConvert-v0.7.0-e44e03f-linux64.zip

# Install COLLADA2GLTF
RUN wget --quiet https://github.com/KhronosGroup/COLLADA2GLTF/releases/download/v2.1.5/COLLADA2GLTF-v2.1.5-linux.zip \
  && unzip -q COLLADA2GLTF-v2.1.5-linux.zip -d /usr/lib/COLLADA2GLTF \
  && ln -s /usr/lib/COLLADA2GLTF/COLLADA2GLTF-bin /usr/local/bin/COLLADA2GLTF \
  && rm -rf COLLADA2GLTF-v2.1.5-linux.zip

# IFC metadata
RUN wget --quiet https://github.com/bimspot/xeokit-metadata/releases/download/1.0.0/xeokit-metadata-linux-x64.tar.gz \
  && tar -zxvf xeokit-metadata-linux-x64.tar.gz \
  && chmod +x xeokit-metadata-linux-x64/xeokit-metadata \
  && cp -r xeokit-metadata-linux-x64/ /usr/lib/xeokit-metadata \
  && ln -s /usr/lib/xeokit-metadata/xeokit-metadata /usr/local/bin/xeokit-metadata \
  && rm -rf xeokit-metadata-linux-x64.tar.gz
