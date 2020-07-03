#!/bin/bash
echo "Support versions of Kubernetes by your current RKE version:"
rke config --system-images --all | grep version | cut -d"[" -f2 | cut -d"]" -f1 | sort

