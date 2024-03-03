# Fedora 40
FROM fedora:40
# Accept UID and GID as build arguments
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME

RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
  dnf -y update

#Lazygit
RUN dnf install -y dnf-plugins-core
RUN dnf copr enable atim/lazygit -y
# Core
RUN dnf install -y neovim \ 
  python3-neovim \
  git \
  fzf \
  g++ \
  lazygit \
  fd-find \
  ripgrep \
  gcc \
  unzip \
  kubernetes-client
# Langs
RUN dnf install -y cargo \
  nodejs \
  go 

# Create a group and user
RUN if getent group ${GROUP_ID} ; then \
  echo "Group ${GROUP_ID} already exists"; \
  else \
  groupadd -g ${GROUP_ID} ${USERNAME}; \
  fi && \
  useradd -l -u ${USER_ID} -g ${GROUP_ID} ${USERNAME} && \
  install -d -m 0755 -o ${USERNAME} -g ${GROUP_ID} /home/${USERNAME} && \
  echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}

ENV HOME=/home/${USERNAME}
WORKDIR /workspace
USER ${USERNAME}
# Deno
RUN curl -fsSL https://deno.land/install.sh | sh
RUN echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.bashrc
COPY . /home/${USERNAME}/.config/nvim
RUN sudo chown -R ${USER_ID}:${GROUP_ID} $HOME && \
  sudo chmod -R 755 $HOME


CMD ["nvim"]
