/*
Copyright The Voyager Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package v1alpha1

import (
	core "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

const (
	ResourceKindVoyagerOperator = "VoyagerOperator"
	ResourceVoyagerOperator     = "voyageroperator"
	ResourceVoyagerOperators    = "voyageroperators"
)

// VoyagerOperator defines the schama for Voyager Operator Installer.

// +genclient
// +genclient:skipVerbs=updateStatus
// +k8s:openapi-gen=true
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// +kubebuilder:object:root=true
// +kubebuilder:resource:path=voyageroperators,singular=voyageroperator,categories={voyager,appscode}
type VoyagerOperator struct {
	metav1.TypeMeta   `json:",inline,omitempty"`
	metav1.ObjectMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
	Spec              VoyagerOperatorSpec `json:"spec,omitempty" protobuf:"bytes,2,opt,name=spec"`
}

// VoyagerOperatorSpec is the schema for Voyager Operator values file
type VoyagerOperatorSpec struct {
	//+optional
	NameOverride string `json:"nameOverride" protobuf:"bytes,1,opt,name=nameOverride"`
	//+optional
	FullnameOverride string       `json:"fullnameOverride" protobuf:"bytes,2,opt,name=fullnameOverride"`
	ReplicaCount     int32        `json:"replicaCount" protobuf:"varint,3,opt,name=replicaCount"`
	Voyager          ContianerRef `json:"voyager" protobuf:"bytes,4,opt,name=voyager"`
	Haproxy          ImageRef     `json:"haproxy" protobuf:"bytes,5,opt,name=haproxy"`
	Cleaner          ImageRef     `json:"cleaner" protobuf:"bytes,6,opt,name=cleaner"`
	ImagePullPolicy  string       `json:"imagePullPolicy" protobuf:"bytes,7,opt,name=imagePullPolicy"`
	//+optional
	ImagePullSecrets []string `json:"imagePullSecrets" protobuf:"bytes,8,rep,name=imagePullSecrets"`
	//+optional
	CloudProvider *string `json:"cloudProvider" protobuf:"bytes,9,opt,name=cloudProvider"`
	//+optional
	CloudConfig string `json:"cloudConfig" protobuf:"bytes,10,opt,name=cloudConfig"`
	//+optional
	CriticalAddon bool `json:"criticalAddon" protobuf:"varint,11,opt,name=criticalAddon"`
	//+optional
	LogLevel    int32       `json:"logLevel" protobuf:"varint,12,opt,name=logLevel"`
	Persistence CloudConfig `json:"persistence" protobuf:"bytes,13,opt,name=persistence"`
	//+optional
	Annotations map[string]string `json:"annotations" protobuf:"bytes,14,rep,name=annotations"`
	//+optional
	PodAnnotations map[string]string `json:"podAnnotations" protobuf:"bytes,15,rep,name=podAnnotations"`
	//+optional
	NodeSelector map[string]string `json:"nodeSelector" protobuf:"bytes,16,rep,name=nodeSelector"`
	// If specified, the pod's tolerations.
	// +optional
	Tolerations []core.Toleration `json:"tolerations" protobuf:"bytes,17,rep,name=tolerations"`
	// If specified, the pod's scheduling constraints
	// +optional
	Affinity *core.Affinity `json:"affinity" protobuf:"bytes,18,opt,name=affinity"`
	// PodSecurityContext holds pod-level security attributes and common container settings.
	// Optional: Defaults to empty.  See type description for default values of each field.
	// +optional
	PodSecurityContext *core.PodSecurityContext `json:"podSecurityContext" protobuf:"bytes,19,opt,name=podSecurityContext"`
	ServiceAccount     ServiceAccountSpec       `json:"serviceAccount" protobuf:"bytes,20,opt,name=serviceAccount"`
	// +optional
	IngressClass *string     `json:"ingressClass" protobuf:"bytes,21,opt,name=ingressClass"`
	Apiserver    WebHookSpec `json:"apiserver" protobuf:"bytes,22,opt,name=apiserver"`
	//+optional
	EnableAnalytics bool `json:"enableAnalytics" protobuf:"varint,23,opt,name=enableAnalytics"`
	// +optional
	RestrictToOperatorNamespace bool      `json:"restrictToOperatorNamespace" protobuf:"varint,24,opt,name=restrictToOperatorNamespace"`
	Templates                   Templates `json:"templates" protobuf:"bytes,25,opt,name=templates"`
}

type ImageRef struct {
	Registry   string `json:"registry" protobuf:"bytes,1,opt,name=registry"`
	Repository string `json:"repository" protobuf:"bytes,2,opt,name=repository"`
	Tag        string `json:"tag" protobuf:"bytes,3,opt,name=tag"`
}

type ContianerRef struct {
	ImageRef `json:",inline" protobuf:"bytes,1,opt,name=imageRef"`
	// Compute Resources required by the sidecar container.
	// +optional
	Resources core.ResourceRequirements `json:"resources" protobuf:"bytes,2,opt,name=resources"`
	// Security options the pod should run with.
	// +optional
	SecurityContext *core.SecurityContext `json:"securityContext" protobuf:"bytes,3,opt,name=securityContext"`
}

type CloudConfig struct {
	//+optional
	Enabled  bool   `json:"enabled" protobuf:"varint,1,opt,name=enabled"`
	HostPath string `json:"hostPath" protobuf:"bytes,2,opt,name=hostPath"`
}

type ServiceAccountSpec struct {
	Create bool `json:"create" protobuf:"varint,1,opt,name=create"`
	//+optional
	Name *string `json:"name" protobuf:"bytes,2,opt,name=name"`
	//+optional
	Annotations map[string]string `json:"annotations" protobuf:"bytes,3,rep,name=annotations"`
}

type WebHookSpec struct {
	GroupPriorityMinimum    int32  `json:"groupPriorityMinimum" protobuf:"varint,1,opt,name=groupPriorityMinimum"`
	VersionPriority         int32  `json:"versionPriority" protobuf:"varint,2,opt,name=versionPriority"`
	EnableValidatingWebhook bool   `json:"enableValidatingWebhook" protobuf:"varint,3,opt,name=enableValidatingWebhook"`
	CA                      string `json:"ca" protobuf:"bytes,4,opt,name=ca"`
	//+optional
	BypassValidatingWebhookXray bool            `json:"bypassValidatingWebhookXray" protobuf:"varint,5,opt,name=bypassValidatingWebhookXray"`
	UseKubeapiserverFqdnForAks  bool            `json:"useKubeapiserverFqdnForAks" protobuf:"varint,6,opt,name=useKubeapiserverFqdnForAks"`
	Healthcheck                 HealthcheckSpec `json:"healthcheck" protobuf:"bytes,7,opt,name=healthcheck"`
	ServingCerts                ServingCerts    `json:"servingCerts" protobuf:"bytes,8,opt,name=servingCerts"`
}

type HealthcheckSpec struct {
	//+optional
	Enabled bool `json:"enabled" protobuf:"varint,1,opt,name=enabled"`
}

type ServingCerts struct {
	Generate bool `json:"generate" protobuf:"varint,1,opt,name=generate"`
	//+optional
	CaCrt string `json:"caCrt" protobuf:"bytes,2,opt,name=caCrt"`
	//+optional
	ServerCrt string `json:"serverCrt" protobuf:"bytes,3,opt,name=serverCrt"`
	//+optional
	ServerKey string `json:"serverKey" protobuf:"bytes,4,opt,name=serverKey"`
}

type Templates struct {
	Cfgmap *string `json:"cfgmap" protobuf:"bytes,1,opt,name=cfgmap"`
}

// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// VoyagerOperatorList is a list of VoyagerOperators
type VoyagerOperatorList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty" protobuf:"bytes,1,opt,name=metadata"`
	// Items is a list of VoyagerOperator CRD objects
	Items []VoyagerOperator `json:"items,omitempty" protobuf:"bytes,2,rep,name=items"`
}
