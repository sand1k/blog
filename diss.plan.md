---
id: zd36qirsf7dgy8mro0lz4cw
title: Plan
desc: ''
updated: 1658174283339
created: 1658171015702
---

План:
1. Подготовить набор подходов, которые будут использованы для имплементации
    - Методы построения представлений для исходного кода
        - [A literature study of embeddings on source code](https://arxiv.org/pdf/1904.03061.pdf)
        - [Global Relational Models of Source Code](https://openreview.net/pdf?id=B1lnbRNtwr)
        - [Neural program repair by jointly learning to localize and repair](https://arxiv.org/pdf/1904.01720.pdf), Marko Vasic, Aditya Kanade1, Petros Maniatis, David Bieber, Rishabh Singh, 2019
    - Методы автогенерации кода
        - Deepmind AlphaCode
            - [AlphaCode Explained: AI Code Generation](https://youtu.be/t3Yh56efKGI)
                - Next-token prediction loss for the decoder, masked language modeling loss for the encoder (Devlin et.al., 2018)
        - Open AI Codex
            - GPT-3
    - Методы автоматического исправления ошибок
        - [Leveraging machine learning to find security vulnerabilities](https://github.blog/2022-02-17-leveraging-machine-learning-find-security-vulnerabilities/)
2. Реализация
