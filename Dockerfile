# ----------------------------------------------------------------------------
# IfcConvert container
# ----------------------------------------------------------------------------
FROM bimspot/ifcopenshell:bionic-0.6.0 as IfcConvert

# ----------------------------------------------------------------------------
# xeokit-converter
# ----------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-bionic as xeokit-converter

RUN apt-get -qq update && apt-get -qq install -y  \
  wget \
  unzip \
  git \
  python3.6

RUN apt-get update -qq && apt-get install -qq curl -y \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install nodejs -y

RUN npm install npm@latest -g
RUN npm install xeokit/xeokit-gltf-to-xkt#33d3d4b84f8fffcdb457d74b4e98d01269fcd377 -g

# Converting tools
COPY --from=IfcConvert /usr/bin/IfcConvert /usr/bin/IfcConvert
RUN ln -s /usr/lib/IfcConvert /usr/local/bin/IfcConvert

COPY --from=IfcConvert /usr/local/lib/python3.6/dist-packages/ifcopenshell /usr/local/lib/python3.6/dist-packages/ifcopenshell

# Install COLLADA2GLTF
RUN wget --quiet https://github.com/KhronosGroup/COLLADA2GLTF/releases/download/v2.1.5/COLLADA2GLTF-v2.1.5-linux.zip
RUN unzip -q COLLADA2GLTF-v2.1.5-linux.zip -d /usr/lib/COLLADA2GLTF
RUN ln -s /usr/lib/COLLADA2GLTF/COLLADA2GLTF-bin /usr/local/bin/COLLADA2GLTF
RUN rm -rf COLLADA2GLTF-v2.1.5-linux.zip

# IFC metadata
RUN wget --quiet https://github.com/bimspot/xeokit-metadata/releases/download/1.0.0/xeokit-metadata-linux-x64.tar.gz
RUN tar -zxvf xeokit-metadata-linux-x64.tar.gz
RUN chmod +x xeokit-metadata-linux-x64/xeokit-metadata
RUN cp -r xeokit-metadata-linux-x64/ /usr/lib/xeokit-metadata
RUN ln -s /usr/lib/xeokit-metadata/xeokit-metadata /usr/local/bin/xeokit-metadata
RUN rm -rf xeokit-metadata-linux-x64.tar.gz
