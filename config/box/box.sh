#!/usr/bin/env bash
set -euo pipefail

# Adapted from https://bxt.rs/blog/easy-sandboxing-on-linux-with-bubblewrap/

# Export ALLOW_NET=0 to disable network access inside the sandbox.
#
# Keep in mind that if your X11/Xwayland doesn't check Xauth,
# then network access lets the sandbox connect to your X11
# via an abstract Unix socket. This is quite dangerous.
ALLOW_NET="${ALLOW_NET:-1}"

# Export PASS_WAYLAND=0 to disable Wayland access.
# Warning: it is currently NOT SANDBOXED (e.g. with security-context protocol).
# See https://niri-wm.github.io/niri/Security-Model.html#unsandboxed-clients
# for an example of what that implies.
PASS_WAYLAND="${PASS_WAYLAND:-1}"

# Export PASS_DRI=1 to enable DRI (GPU) access for hardware acceleration.
PASS_DRI="${PASS_DRI:-0}"

# The current folder that we're binding read-write.
REPO="$(readlink -f .)"

BWRAP=(bwrap
    --die-with-parent
    # Unshare (isolate) a bunch of things inside the sandbox.
    --unshare-pid
    --unshare-uts
    --unshare-cgroup-try
    --unshare-user-try
    --cap-drop ALL
    # Create/mount important folders.
    --proc /proc
    --dev /dev
    --tmpfs /tmp
    --tmpfs /var
    --dir /run
    --dir /etc
    --hostname sandbox

    # Warning: this script shares all environment variables.
    # If on your system the environment can contain secrets,
    # you may want to clear them:
    # --clearenv

    # Bind the current folder read-write and chdir there.
    --bind "$REPO" "$REPO"
    --chdir "$REPO"
    --setenv DROP_ENV "BOX"
)

# --- Read-only system binds ---
SYS_RO_BINDS=(
    /usr
    /bin
    /sbin
    /lib
    /lib64
    /etc/alternatives
    /etc/nsswitch.conf
    /etc/hosts
    /etc/localtime
    /etc/timezone
    /etc/pki
    /etc/ca-certificates
    /etc/ssl
    /etc/crypto-policies
    /etc/fonts
    /nix/store
)
# Bind all of them read-only.
for p in "${SYS_RO_BINDS[@]}"; do
    [[ -e "$p" ]] && BWRAP+=(--ro-bind "$p" "$p")
done

BWRAP+=(--ro-bind-try /etc/ld.so.cache /etc/ld.so.cache)

# resolv.conf is fun because it's a symlink into /run,
# a folder which we do not want to expose.
RESOLV_REAL="$(readlink -f /etc/resolv.conf 2>/dev/null || true)"
if [[ -n "$RESOLV_REAL" && -f "$RESOLV_REAL" ]]; then
    BWRAP+=(--ro-bind "$RESOLV_REAL" /etc/resolv.conf)
fi

# Unshare the network if needed.
if [[ "$ALLOW_NET" -eq 0 ]]; then
    BWRAP+=(--unshare-net)
fi

# Create a fresh home directory.
# The username and the path is the same as on the host
# so that everything keeps working.
BWRAP+=(--setenv HOME "$HOME"
    --dir "$HOME")

# --- Home read-only binds ---
HOME_RO_BINDS=(
    .local/bin
    .fonts
    .local/share/fonts
    .cache/antidote
    .config/git
    .config/atuin
    .config/bat
    .config/carapace
    .config/direnv
    .config/docker
    .config/gitui
    .config/nvim
    .config/ripgrep
    .config/yazi
    .config/zellij
    .config/zsh-patina
    .nix-profile
    .p10k.zsh
    .zshenv
    .zprofile
    .zshrc
)
for rel in "${HOME_RO_BINDS[@]}"; do
    [[ -e "$HOME/$rel" ]] && BWRAP+=(--ro-bind "$HOME/$rel" "$HOME/$rel")
done

# --- Home read-write binds ---
HOME_RW_BINDS=(
    .cache/zellij
    .local/share/nvim
    work
    tmp
)
for rel in "${HOME_RW_BINDS[@]}"; do
    [[ -e "$HOME/$rel" ]] && BWRAP+=(--bind "$HOME/$rel" "$HOME/$rel")
done

# --- Home overlays ---
# The sandbox can write here, but the changes
# will not affect the host filesystem.
HOME_TMP_OVERLAYS=(
    .cache/fontconfig
    .cargo/registry
    .cargo/git
    .gradle
    .npm
    .cache/npm
    .local/share/pnpm/store
    go/pkg
)
for rel in "${HOME_TMP_OVERLAYS[@]}"; do
    [[ -d "$HOME/$rel" ]] && BWRAP+=(--overlay-src "$HOME/$rel" --tmp-overlay "$HOME/$rel")
done

# Set up $PATH with the paths that we have inside this sandbox.
BWRAP+=(--setenv PATH "$HOME/.config/carapace/bin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:$HOME/.local/bin")

if [[ "$PASS_DRI" -eq 1 && -d /dev/dri ]]; then
    BWRAP+=(--dev-bind /dev/dri /dev/dri)
fi

# EGL complains without this.
BWRAP+=(--ro-bind /sys /sys)

# Wayland and Docker: bind only the socket into a fresh runtime dir.
XDG_RT="${XDG_RUNTIME_DIR:-}"
WAYLAND_SOCK="${WAYLAND_DISPLAY:-wayland-0}"
if [[ -n "$XDG_RT" && -S "$XDG_RT/$WAYLAND_SOCK" ]]; then
    BWRAP+=(--dir /run/user
        --dir /run/user/1000-sbox
        --bind "$XDG_RT/$WAYLAND_SOCK" "/run/user/1000-sbox/$WAYLAND_SOCK"
        --setenv XDG_RUNTIME_DIR /run/user/1000-sbox
        --setenv WAYLAND_DISPLAY "$WAYLAND_SOCK"
        --bind "$XDG_RT/docker.sock" "/run/user/1000-sbox/docker.sock"
        --setenv DOCKER_SOCKET "/run/user/1000-sbox/docker.sock"
        --setenv DOCKER_HOST "unix:///run/user/1000-sbox/docker.sock")
else
    BWRAP+=(--unsetenv WAYLAND_DISPLAY)
fi

# Execute our big commandline and pass it
# the rest of the arguments (the command to run).
CMD=("${@:-zellij}")
exec "${BWRAP[@]}" "${CMD[@]}"
