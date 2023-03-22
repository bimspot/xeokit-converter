# xeokit-converter

The image contains all tools needed for the [conversion of IFC files][1]
to the `xkt` format for the xeokit viewer.

- IfcConvert (IfcOpenShell)
- COLLADA2GLTF
- xeokit-gltf-to-xkt
- xeokit-metadata

## Usage

```
$ docker pull bimspot/xeokit-converter
```

See all available tags on [docker hub][5].

Using [`bimspot/xeokit-converter`][4] as a base image, all converter tools are
available in the `PATH`.

```bash
echo "Converting IFC to DAE"
IfcConvert -v -y --use-element-guids scene.ifc scene.dae

echo "Converting DAE to glTF"
COLLADA2GLTF -v -i scene.dae -o scene.gltf

echo "Creating metadata json"
xeokit-metadata scene.ifc scene.json

echo "Converting gltf to xkt"
xeokit-convert -s scene.gltf -o scene.xkt

echo "Converting gltf to xkt with metadata"
xeokit-convert -s scene.gltf -m scene.json -o scene.xkt
```

## Environment

The `IfcConvert` library is available through [`bimspot/ifcopenshell`][2].
The xeokit-converter image is based on the [bionic dotnet runtime][3].

## Distribution

The image is build locally and pushed to [Docker hub][5] with your own credentials.
Semver applies.

```
~ docker build -t bimspot/xeokit-converter:1.3.x .
~ docker push bimspot/xeokit-converter:1.3.x
```

[1]: https://github.com/xeokit/xeokit-convert
[2]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/ifcopenshell
[3]: mcr.microsoft.com/dotnet/core/runtime:2.2-bionic
[4]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/xeokit-converter
[5]: https://hub.docker.com/r/bimspot/xeokit-converter

