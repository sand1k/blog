---
id: lohfwmze9ptlrtuedlacygi
title: Perception
desc: ''
updated: 1657140089582
created: 1656535182940
---

Categories for detection:
- Road users
    - Open door
    - Road users semantics (gestures)
- Road semantics - traffic signs, lights, etc.
- Road geometry - drivable paths
- Road boundaries

Redundancy in CV subsystem:
- Appearance based
- Geometry based

Object detection:
- 3DVD - classical approach with bounding boxes
- Full image detection - large truck which covers several cameras, close objects
    - Inter-cameras tracking (object signature network)
- Top View FS (free space)
    - Pixel-level scene segmentation
- Wheels
- VIDAR - generate 3d percept of the world using classical triangulation, feed to classical LIDAR algorithms

Measurements:
- VIDAR
- Visual road model - plain plus parallax, perspective
- Range net
- Map world model (REM)

Parallax net
VIDAR
Obstaccle
