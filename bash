# Clear all virtualbox garbage and reinstall
sudo find / -iname "virtualbox" | xargs  sudo rm -rf && sudo dnf install VirtualBox-7.0

# Update all pip outdated packages
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U

# VirtualBox ignore kvm driver in kernel
export VBOX_HWVIRTEX_IGNORE_SVM_IN_USE=true

# Update all already pulled docker images
#docker images --format "{{.Repository}}:{{.Tag}}" | xargs -L1 docker pull
docker images | grep -v ^REPO | sed 's/ \+/:/g' | cut -d: -f1,2 | xargs -L1 docker pull
docker image prune