# xeokit-converter

The image contains all tools needed for the [conversion of IFC files][1]
to the `xkt` format for the xeokit viewer.

- IfcConvert (IfcOpenShell)
- COLLADA2GLTF
- xeokit-gltf-to-xkt
- xeokit-metadata

## Usage

Using [`bimspot/xeokit-converter`][4] as a base image, all converter tools are
available in the `PATH`.

```bash
echo "Converting IFC to DAE"
IfcConvert -v -y --use-element-guids scene.ifc scene.dae

echo "Converting DAE to glTF"
COLLADA2GLTF -v -i scene.dae -o scene.gltf

echo "Converting gltf to xkt"
gltf2xkt -s scene.gltf -o scene.xkt

echo "Creating metadata json"
xeokit-metadata scene.ifc scene.json
```

## Environment

The `IfcConvert` library is available through [`bimspot/ifcopenshell`][2].
The xeokit-converter image is based on the [bionic dotnet runtime][3].

[1]: https://github.com/xeokit/xeokit-gltf-to-xkt
[2]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/ifcopenshell
[3]: mcr.microsoft.com/dotnet/core/runtime:2.2-bionic
[4]: https://cloud.docker.com/u/bimspot/repository/docker/bimspot/xeokit-converter
