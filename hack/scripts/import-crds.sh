#!/bin/bash

# Copyright AppsCode Inc. and Contributors
#
# Licensed under the AppsCode Community License 1.0.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://github.com/appscode/licenses/raw/1.0.0/AppsCode-Community-1.0.0.md
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eou pipefail

crd_dir=${1:-}

api_repo_url=https://github.com/voyagermesh/apimachinery.git
api_repo_tag=${VOYAGERMESH_APIMACHINERY_TAG:-master}

if [ "$#" -ne 1 ]; then
    if [ "${api_repo_tag}" == "master" ]; then
        echo "Error: missing path_to_input_crds_directory"
        echo "Usage: import-crds.sh <path_to_input_crds_directory>"
        exit 1
    fi

    tmp_dir=$(mktemp -d -t api-XXXXXXXXXX)
    # always cleanup temp dir
    # ref: https://opensource.com/article/20/6/bash-trap
    trap \
        "{ rm -rf "${tmp_dir}"; }" \
        SIGINT SIGTERM ERR EXIT

    mkdir -p ${tmp_dir}
    pushd $tmp_dir
    git clone $api_repo_url
    repo_dir=$(ls -b1)
    cd $repo_dir
    git checkout $api_repo_tag
    popd
    crd_dir=${tmp_dir}/${repo_dir}/crds
fi

KMODULES_CUSTOM_RESOURCES_TAG=${KMODULES_CUSTOM_RESOURCES_TAG:-v0.32.0}
KUBERNETES_SIGS_GATEWAY_API_TAG=${KUBERNETES_SIGS_GATEWAY_API_TAG:-v1.3.2}
VOYAGERMESH_GATEWAY_API_TAG=${VOYAGERMESH_GATEWAY_API_TAG:-v0.0.7}

crd-importer \
    --input=${crd_dir} \
    --input=https://github.com/kmodules/custom-resources/raw/${KMODULES_CUSTOM_RESOURCES_TAG}/crds/metrics.appscode.com_metricsconfigurations.v1.yaml \
    --out=./charts/voyager-crds/crds

crd-importer \
    --input=${crd_dir} \
    --out=./charts/voyager/crds

crd-importer \
    --input=${crd_dir} \
    --out=. --output-yaml=crds/voyager-crds.yaml

# only add v1 apis
crd-importer \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml \
    --input=https://github.com/kubernetes-sigs/gateway-api/raw/${KUBERNETES_SIGS_GATEWAY_API_TAG}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml \
    --out=./charts/gateway-api/crds

crd-importer \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_kafkaroutes.yaml \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_mongodbroutes.yaml \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_mssqlserverroutes.yaml \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_mysqlroutes.yaml \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_postgresroutes.yaml \
    --input=https://github.com/voyagermesh/gateway-api/raw/${VOYAGERMESH_GATEWAY_API_TAG}/config/crd/bases/gateway.voyagermesh.com_redisroutes.yaml \
    --out=./charts/voyager-gateway/crds
