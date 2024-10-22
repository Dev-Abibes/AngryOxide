# Utiliser une image de base légère
FROM ubuntu:20.04

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    make \
    && rm -rf /var/lib/apt/lists/*

# Installer Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Cloner le dépôt Git
RUN git clone --recurse-submodules https://github.com/Ragnt/AngryOxide.git /app

# Définir le répertoire de travail
WORKDIR /app

# Construire et installer l'application
RUN make
RUN make install

# Définir la commande par défaut pour le conteneur
CMD ["/usr/local/bin/angryoxide"]
