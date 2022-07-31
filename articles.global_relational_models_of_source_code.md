---
id: c5qe6ldplx2lvj6gjx1hd66
title: Global relational models of source code
desc: ''
updated: 1658172663012
created: 1658171443020
---

## Overview

Models:
- Graph Sandwiches - wrap traditional (gated) graph message-passing layers in sequential message-passing layers;
- Graph Relational Embedding Attention Transformers (GREAT) -  bias traditional Transformers with relational information from graph edge types.

Task: variable-misuse identification.

Initial representations of source code relied on sequential models from natural-language processing, such as n-gram language models (Hindle et al., 2012; Allamanis & Sutton, 2013; Hellendoorn & Devanbu, 2017) and Recurrent Neural Networks (RNNs) (White et al., 2015), but these models struggle to capture the complexity of source code.

Gated Graph Neural Network (GGNN) model for embedding programs was shown to learn better, more generalizable representations faster than classical RNN-based sequence models.

Graph neural networks typically rely on synchronous message passing, which makes them inherently local, requiring many iterations of message passing to aggregate information from distant parts of the code. However, state-of-the-art graph neural networks for code often use as few as eight message-passing iterations (Allamanis et al., 2018b; Fernandes et al., 2018), primarily for computational reasons: program graphs can be very large, and training time grows linearly with the number of message passes. This is in contrast to, e.g., Transformer models (Vaswani et al., 2017), which allow program-wide information flow at every step, yet lack the powerful inductive bias from knowing the code’s structure.

## Links

- [[diss.plan]]