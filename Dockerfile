# ----------------------------------------------------------------------------
# IfcConvert container
# ----------------------------------------------------------------------------
FROM bimspot/ifcopenshell:bionic-0.6.0 as IfcConvert

# ----------------------------------------------------------------------------
# xeokit-converter
# ----------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/runtime:2.2-bionic as xeokit-converter

RUN apt-get -qq update && apt-get -qq install -y  \
  nodejs \
  wget \
  npm \
  unzip \
  git

RUN npm install npm@latest -g
RUN npm install xeokit/xeokit-gltf-to-xkt -g

# Converting tools
COPY --from=IfcConvert /usr/bin/IfcConvert /usr/bin/IfcConvert
RUN ln -s /usr/lib/IfcConvert /usr/local/bin/IfcConvert

# Install COLLADA2GLTF
RUN wget --quiet https://github.com/KhronosGroup/COLLADA2GLTF/releases/download/v2.1.5/COLLADA2GLTF-v2.1.5-linux.zip
RUN unzip -q COLLADA2GLTF-v2.1.5-linux.zip -d /usr/lib/COLLADA2GLTF
RUN ln -s /usr/lib/COLLADA2GLTF/COLLADA2GLTF-bin /usr/local/bin/COLLADA2GLTF
RUN rm -rf COLLADA2GLTF-v2.1.5-linux.zip

# IFC metadata
RUN wget --quiet https://github.com/bimspot/xeokit-metadata/releases/download/0.0.5/xeokit-metadata-linux-x64.tar.gz
RUN tar -zxvf xeokit-metadata-linux-x64.tar.gz
RUN chmod +x xeokit-metadata-linux-x64/xeokit-metadata
RUN cp -r xeokit-metadata-linux-x64/ /usr/lib/xeokit-metadata
RUN ln -s /usr/lib/xeokit-metadata/xeokit-metadata /usr/local/bin/xeokit-metadata
RUN rm -rf xeokit-metadata-linux-x64.tar.gz
