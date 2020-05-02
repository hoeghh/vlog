# Package RKE system-images to files
This script is made to download the images RKE needs to spinn up a Kubernetes cluster, and save those to files.
Those files can then be transfered to an air gab'd location and used to install Kubernetes without and active internet connection.

## Usage
Run ./getImages.sh [VERSION]

eg. 
```
./getImages.sh v1.16.6-rancher1-1
```
or simply run it without parameters to get the current default Kubernetes version by RKE.
```
./getImages.sh
```

## Output
The images will be put in tar files in the `/output` folder in a subfolder named with the choosen version.

The script will output this text
```
./getImages.sh v1.16.6-rancher1-1
 - Downloading version v1.16.6-rancher1-1

 - Fetching list of images on version v1.16.6-rancher1-1
   - Pulling image rancher/coreos-etcd:v3.3.15-rancher1
   - Pulling image rancher/rke-tools:v0.1.52
   - Pulling image rancher/k8s-dns-kube-dns:1.15.0
   - Pulling image rancher/k8s-dns-dnsmasq-nanny:1.15.0
   - Pulling image rancher/k8s-dns-sidecar:1.15.0
   - Pulling image rancher/cluster-proportional-autoscaler:1.7.1
   - Pulling image rancher/coredns-coredns:1.6.2
   - Pulling image rancher/hyperkube:v1.16.6-rancher1
   - Pulling image rancher/coreos-flannel:v0.11.0-rancher1
   - Pulling image rancher/flannel-cni:v0.3.0-rancher5
   - Pulling image rancher/calico-node:v3.10.2
   - Pulling image rancher/calico-cni:v3.10.2
   - Pulling image rancher/calico-kube-controllers:v3.10.2
   - Pulling image rancher/calico-pod2daemon-flexvol:v3.10.2
   - Pulling image rancher/coreos-flannel:v0.11.0
   - Pulling image weaveworks/weave-kube:2.5.2
   - Pulling image weaveworks/weave-npc:2.5.2
   - Pulling image rancher/pause:3.1
   - Pulling image rancher/nginx-ingress-controller:nginx-0.25.1-rancher1
   - Pulling image rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1
   - Pulling image rancher/metrics-server:v0.3.4

 - Waiting for all images to be done pulling #####################
   - All images are pulled.

 - Now starting to save images to folder
   - Saving rancher/coreos-etcd:v3.3.15-rancher1 to output/v1.16.6-rancher1-1/ranchercoreosetcdv3315rancher1.tar
   - Saving rancher/rke-tools:v0.1.52 to output/v1.16.6-rancher1-1/rancherrketoolsv0152.tar
   - Saving rancher/k8s-dns-kube-dns:1.15.0 to output/v1.16.6-rancher1-1/rancherk8sdnskubedns1150.tar
   - Saving rancher/k8s-dns-dnsmasq-nanny:1.15.0 to output/v1.16.6-rancher1-1/rancherk8sdnsdnsmasqnanny1150.tar
   - Saving rancher/k8s-dns-sidecar:1.15.0 to output/v1.16.6-rancher1-1/rancherk8sdnssidecar1150.tar
   - Saving rancher/cluster-proportional-autoscaler:1.7.1 to output/v1.16.6-rancher1-1/rancherclusterproportionalautoscaler171.tar
   - Saving rancher/coredns-coredns:1.6.2 to output/v1.16.6-rancher1-1/ranchercorednscoredns162.tar
   - Saving rancher/hyperkube:v1.16.6-rancher1 to output/v1.16.6-rancher1-1/rancherhyperkubev1166rancher1.tar
   - Saving rancher/coreos-flannel:v0.11.0-rancher1 to output/v1.16.6-rancher1-1/ranchercoreosflannelv0110rancher1.tar
   - Saving rancher/flannel-cni:v0.3.0-rancher5 to output/v1.16.6-rancher1-1/rancherflannelcniv030rancher5.tar
   - Saving rancher/calico-node:v3.10.2 to output/v1.16.6-rancher1-1/ranchercaliconodev3102.tar
   - Saving rancher/calico-cni:v3.10.2 to output/v1.16.6-rancher1-1/ranchercalicocniv3102.tar
   - Saving rancher/calico-kube-controllers:v3.10.2 to output/v1.16.6-rancher1-1/ranchercalicokubecontrollersv3102.tar
   - Saving rancher/calico-pod2daemon-flexvol:v3.10.2 to output/v1.16.6-rancher1-1/ranchercalicopod2daemonflexvolv3102.tar
   - Saving rancher/coreos-flannel:v0.11.0 to output/v1.16.6-rancher1-1/ranchercoreosflannelv0110.tar
   - Saving weaveworks/weave-kube:2.5.2 to output/v1.16.6-rancher1-1/weaveworksweavekube252.tar
   - Saving weaveworks/weave-npc:2.5.2 to output/v1.16.6-rancher1-1/weaveworksweavenpc252.tar
   - Saving rancher/pause:3.1 to output/v1.16.6-rancher1-1/rancherpause31.tar
   - Saving rancher/nginx-ingress-controller:nginx-0.25.1-rancher1 to output/v1.16.6-rancher1-1/ranchernginxingresscontrollernginx0251rancher1.tar
   - Saving rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1 to output/v1.16.6-rancher1-1/ranchernginxingresscontrollerdefaultbackend15rancher1.tar
   - Saving rancher/metrics-server:v0.3.4 to output/v1.16.6-rancher1-1/ranchermetricsserverv034.tar

 - Done fetching RKE system images for version v1.16.6-rancher1-1


tree output
output/
└── v1.16.6-rancher1-1
    ├── log.txt
    ├── ranchercalicocniv3102.tar
    ├── ranchercalicokubecontrollersv3102.tar
    ├── ranchercaliconodev3102.tar
    ├── ranchercalicopod2daemonflexvolv3102.tar
    ├── rancherclusterproportionalautoscaler171.tar
    ├── ranchercorednscoredns162.tar
    ├── ranchercoreosetcdv3315rancher1.tar
    ├── ranchercoreosflannelv0110rancher1.tar
    ├── ranchercoreosflannelv0110.tar
    ├── rancherflannelcniv030rancher5.tar
    ├── rancherhyperkubev1166rancher1.tar
    ├── rancherk8sdnsdnsmasqnanny1150.tar
    ├── rancherk8sdnskubedns1150.tar
    ├── rancherk8sdnssidecar1150.tar
    ├── ranchermetricsserverv034.tar
    ├── ranchernginxingresscontrollerdefaultbackend15rancher1.tar
    ├── ranchernginxingresscontrollernginx0251rancher1.tar
    ├── rancherpause31.tar
    ├── rancherrketoolsv0152.tar
    ├── weaveworksweavekube252.tar
    └── weaveworksweavenpc252.tar
```
