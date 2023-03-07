# ``Unofficial Swift package for the LeapML API``

## Overview

See also https://www.tryleap.ai/

Currently this package is very limited; it only supports requests for generating images, and listing all outstanding
requests. The inference model used to generate the images, is hardcoded to one of LeapMLs pre-trained models.

Note: this particular file currently is ignored by DocC due to a bug:
https://github.com/apple/swift-docc-plugin/issues/29

## Topics

### Services


- ``GenerateImageService``
- ``ListInferenceService``

### Models


- ``Inference``
- ``InferenceJob``
- ``InferenceImage``
- ``Status``
