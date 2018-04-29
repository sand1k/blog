Convolution with stride s and padding p
Size of output matrix: floor((n + 2p - f)/s) x floor((n + 2p - f)/s)

Convolution over volume: multiple filters

Typels of layer:

* Convolution
* Pooling
* Fully connected

Localization and detection:
* Object classification with localization - detect 1 object in image and loczlize it
* Object detection - detect all object in picture (there are multiple objects, maybe of different categories, in image)

### Object detection

Sliding windows - window, which slides over image and that part of image is fed into CNN.
Bounding box prediction.

Bounding Box Predictions

Intersection over union - to say how well object was detected the ratio of intersection (between detected rectangle and actual rectangle) over their is calculated. Usually threshold 0.5 is used to say that detection was good.

Non-max Suppression - cleans up redundant detections of the algorithm.
