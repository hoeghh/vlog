# Package RKE system-images to files
These two scripts are made to download the images RKE needs to spinn up a Kubernetes cluster, and save those to files.
Those files can then be transfered to an air gab'd location and used to install Kubernetes without and active internet connection.

First example uses Docker which requires you to have both the Docker cli and Docker Daemon running. It will first do a `docker pull`, and then a `docker save`. Very few automated pipelines have access to a Docker daemon for security reasons, so this might not be a valid path to go. 

Next example doesnt require Docker at all, and is more flexible. It downloads the Docker images directly to disk in one command, but could also fetch them from one repo, and save them in another repository. So it could fetch them from the docker hub, and push to an internal docker registry. Its much easier to integrate into a CD pipeline.

Both scripts support custom source registry url, if set in the top of the script. Some companies operate behind a firewall, and need to use an proxy repository. The Docker scripts downloads all images in parallel to speed up the process. The Skopeo script can do that, but it tends to break so i disabled it again. I dont know why it does, but it does it own parallel thing in the background so it might be hammering the Docker hub to much if we started all of them in parallel. 

## Usage with Docker cli + Docker daemon
Run ./dockerGetImages.sh [VERSION]

eg. 
```
./dockerGetImages.sh v1.16.6-rancher1-1
```
or simply run it without parameters to get the current default Kubernetes version by RKE.
```
./dockerGetImages.sh
```

## Usage with Skopeo
Run ./skopeoGetImages.sh [VERSION]

eg.
```
./skopeoGetImages.sh v1.16.6-rancher1-1
```
or simply run it without parameters to get the current default Kubernetes version by RKE.
```
./skopeoGetImages.sh
```


## Output
The images will be put in tar files in the `/output` folder in a subfolder named with the choosen version.

### Output with Docker
The script will output this text
```
./dockerGetImages.sh v1.17.4-rancher1-3
 - Downloading version v1.17.4-rancher1-3
 - Fetching list of images on version v1.17.4-rancher1-3
   - Pulling image rancher/coreos-etcd:v3.4.3-rancher1
   - Pulling image rancher/rke-tools:v0.1.56
   - Pulling image rancher/k8s-dns-kube-dns:1.15.0
   - Pulling image rancher/k8s-dns-dnsmasq-nanny:1.15.0
   - Pulling image rancher/k8s-dns-sidecar:1.15.0
   - Pulling image rancher/cluster-proportional-autoscaler:1.7.1
   - Pulling image rancher/coredns-coredns:1.6.5
   - Pulling image rancher/k8s-dns-node-cache:1.15.7
   - Pulling image rancher/hyperkube:v1.17.4-rancher1
   - Pulling image rancher/coreos-flannel:v0.11.0-rancher1
   - Pulling image rancher/flannel-cni:v0.3.0-rancher5
   - Pulling image rancher/calico-node:v3.13.0
   - Pulling image rancher/calico-cni:v3.13.0
   - Pulling image rancher/calico-kube-controllers:v3.13.0
   - Pulling image rancher/calico-ctl:v2.0.0
   - Pulling image rancher/calico-pod2daemon-flexvol:v3.13.0
   - Pulling image rancher/coreos-flannel:v0.11.0
   - Pulling image weaveworks/weave-kube:2.5.2
   - Pulling image weaveworks/weave-npc:2.5.2
   - Pulling image rancher/pause:3.1
   - Pulling image rancher/nginx-ingress-controller:nginx-0.25.1-rancher1
   - Pulling image rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1
   - Pulling image rancher/metrics-server:v0.3.6

 - Waiting for all images to be done pulling #######################
   - All images are pulled. 

 - Now starting to save images to folder
   - Saving rancher/coreos-etcd:v3.4.3-rancher1 to output/v1.17.4-rancher1-3/ranchercoreosetcdv343rancher1.tar
   - Saving rancher/rke-tools:v0.1.56 to output/v1.17.4-rancher1-3/rancherrketoolsv0156.tar
   - Saving rancher/k8s-dns-kube-dns:1.15.0 to output/v1.17.4-rancher1-3/rancherk8sdnskubedns1150.tar
   - Saving rancher/k8s-dns-dnsmasq-nanny:1.15.0 to output/v1.17.4-rancher1-3/rancherk8sdnsdnsmasqnanny1150.tar
   - Saving rancher/k8s-dns-sidecar:1.15.0 to output/v1.17.4-rancher1-3/rancherk8sdnssidecar1150.tar
   - Saving rancher/cluster-proportional-autoscaler:1.7.1 to output/v1.17.4-rancher1-3/rancherclusterproportionalautoscaler171.tar
   - Saving rancher/coredns-coredns:1.6.5 to output/v1.17.4-rancher1-3/ranchercorednscoredns165.tar
   - Saving rancher/k8s-dns-node-cache:1.15.7 to output/v1.17.4-rancher1-3/rancherk8sdnsnodecache1157.tar
   - Saving rancher/hyperkube:v1.17.4-rancher1 to output/v1.17.4-rancher1-3/rancherhyperkubev1174rancher1.tar
   - Saving rancher/coreos-flannel:v0.11.0-rancher1 to output/v1.17.4-rancher1-3/ranchercoreosflannelv0110rancher1.tar
   - Saving rancher/flannel-cni:v0.3.0-rancher5 to output/v1.17.4-rancher1-3/rancherflannelcniv030rancher5.tar
   - Saving rancher/calico-node:v3.13.0 to output/v1.17.4-rancher1-3/ranchercaliconodev3130.tar
   - Saving rancher/calico-cni:v3.13.0 to output/v1.17.4-rancher1-3/ranchercalicocniv3130.tar
   - Saving rancher/calico-kube-controllers:v3.13.0 to output/v1.17.4-rancher1-3/ranchercalicokubecontrollersv3130.tar
   - Saving rancher/calico-ctl:v2.0.0 to output/v1.17.4-rancher1-3/ranchercalicoctlv200.tar
   - Saving rancher/calico-pod2daemon-flexvol:v3.13.0 to output/v1.17.4-rancher1-3/ranchercalicopod2daemonflexvolv3130.tar
   - Saving rancher/coreos-flannel:v0.11.0 to output/v1.17.4-rancher1-3/ranchercoreosflannelv0110.tar
   - Saving weaveworks/weave-kube:2.5.2 to output/v1.17.4-rancher1-3/weaveworksweavekube252.tar
   - Saving weaveworks/weave-npc:2.5.2 to output/v1.17.4-rancher1-3/weaveworksweavenpc252.tar
   - Saving rancher/pause:3.1 to output/v1.17.4-rancher1-3/rancherpause31.tar
   - Saving rancher/nginx-ingress-controller:nginx-0.25.1-rancher1 to output/v1.17.4-rancher1-3/ranchernginxingresscontrollernginx0251rancher1.tar
   - Saving rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1 to output/v1.17.4-rancher1-3/ranchernginxingresscontrollerdefaultbackend15rancher1.tar
   - Saving rancher/metrics-server:v0.3.6 to output/v1.17.4-rancher1-3/ranchermetricsserverv036.tar

 - Done fetching RKE system images for version v1.17.4-rancher1-3

 - Generated with RKE version rke version v1.1.0
Elapsed: 0hrs 6min 10sec
```

### Output with Skopeo
```
./skopeoGetImages.sh v1.16.8-rancher1-3
 - Downloading version v1.16.8-rancher1-3
 - Fetching list of images on version v1.16.8-rancher1-3

 - Waiting for all images to be done pulling
   - Pulling image rancher/coreos-etcd:v3.3.15-rancher1
   - Pulling image rancher/rke-tools:v0.1.56
   - Pulling image rancher/k8s-dns-kube-dns:1.15.0
   - Pulling image rancher/k8s-dns-dnsmasq-nanny:1.15.0
   - Pulling image rancher/k8s-dns-sidecar:1.15.0
   - Pulling image rancher/cluster-proportional-autoscaler:1.7.1
   - Pulling image rancher/coredns-coredns:1.6.2
   - Pulling image rancher/k8s-dns-node-cache:1.15.7
   - Pulling image rancher/hyperkube:v1.16.8-rancher1
   - Pulling image rancher/coreos-flannel:v0.11.0-rancher1
   - Pulling image rancher/flannel-cni:v0.3.0-rancher5
   - Pulling image rancher/calico-node:v3.13.0
   - Pulling image rancher/calico-cni:v3.13.0
   - Pulling image rancher/calico-kube-controllers:v3.13.0
   - Pulling image rancher/calico-ctl:v2.0.0
   - Pulling image rancher/calico-pod2daemon-flexvol:v3.13.0
   - Pulling image rancher/coreos-flannel:v0.11.0
   - Pulling image weaveworks/weave-kube:2.5.2
   - Pulling image weaveworks/weave-npc:2.5.2
   - Pulling image rancher/pause:3.1
   - Pulling image rancher/nginx-ingress-controller:nginx-0.25.1-rancher1
   - Pulling image rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1
   - Pulling image rancher/metrics-server:v0.3.4

 - Done fetching RKE system images for version v1.16.8-rancher1-3

 - Generated with RKE version rke version v1.1.0
Elapsed: 0hrs 9min 27sec
```

### Files
``` 
tree
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

