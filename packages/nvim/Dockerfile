# Fedora 40
FROM fedora:40
# Accept UID and GID as build arguments
ARG USER_ID
ARG GROUP_ID
ARG USERNAME

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
RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
  dnf -y update

#Lazygit
RUN dnf install -y dnf-plugins-core
RUN dnf copr enable atim/lazygit -y
RUN dnf install -y neovim \ 
  python3-neovim \
  htop \
  git \
  fzf \
  g++ \
  lazygit \
  fd-find \
  ripgrep \
  gcc \
  kubernetes-client \
  cargo \
  nodejs \
  go \
  elixir \
  erlang

WORKDIR /workspace

COPY . /home/javiles/.config/nvim
USER javiles

CMD ["nvim"]
