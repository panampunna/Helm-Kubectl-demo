##   cat Helm/helm.bash_aliases >>    ~/.bash_aliases

## helm  helm charts  
XX() {
	sudo chmod 666 /var/run/docker.sock	
	minikube start &	
}        

XX1() {
	kubectl get roles,rolebindings,clusterroles,clusterrolebindings --all-namespaces
        echo -e "\n kubectl get  namespaces   "
	kubectl get  namespaces
	echo -e "\n kubectl get  serviceaccounts   "
	kubectl get  serviceaccounts
	#################  Role and RoleBinding ################
	kubectl create role 	pod-reader1  --verb get,list 	--resource pods
	kubectl create rolebinding pod-reader-binding1 --namespace=default --role=pod-reader1 --serviceaccount=default:admin-user
	
}


HHHI() {
	echo "Kubernetes  for Helm : RUN HHHI from folder 2023-ubuntu   "
   	Todayis=$(date +%A)
    	lowercase_day=$(echo "$Todayis" | tr '[:upper:]' '[:lower:]')
    	echo "Current day: $lowercase_day"

    	folder_name=$(basename "$PWD")
    	echo "Current folder: $folder_name"

    if [ "$folder_name" != "linu-raj" ]; then
        echo "Folder you are running the script is wrong"
#        exit
       echo  "#############    The current folder ##########################  " 
	 pwd
        return
    else
        echo "You are good to go"
    fi

	vjp_code_path=$PWD
    	echo $vjp_code_path
	sudo apt update
    	echo "1.2 SNAP = "snap install kubectl --classic" |## |  "kubectl version --client"  ###   "
#	sudo snap install firefox
#	sudo snap install chromium
	sudo snap install curl
	sudo snap install kubectl --classic
        sudo snap install docker
	sudo apt update
	echo -e "\n\n  sleep 60  " 
	sleep 60
        sudo chmod 666 /var/run/docker.sock
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
	echo -e "\n\n ls -l minikube_latest_amd64.deb "
	ls -l minikube_latest_amd64.deb
	sudo dpkg -i minikube_latest_amd64.deb
	echo -e "\n\n sudo minikube start "
	minikube start 
	sleep 9
	echo -e "\n\n sudo   apt-get install bash-completion   next   " 
	sudo   apt-get install bash-completion
	kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
	kubectl get services
	sudo snap install helm --classic
	echo " sudo helm completion bash | sudo tee  /etc/bash_completion.d/helm > /dev/null    "
	sudo apt-get install bash-completion
	sudo helm completion bash | sudo tee  /etc/bash_completion.d/helm > /dev/null
	echo " ADDING HELM REPO   " 
	helm repo add stable https://charts.helm.sh/stable
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
	helm repo add bitnami https://charts.bitnami.com/bitnami		
	helm repo add elastic https://Helm.elastic.co

	helm repo update
	helm repo list
	echo " install kubernetes-dashboard  in kb namespace   "
	kubectl create namespace kb
	helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard  -n kb
	sleep 9
	export KPOD_NAME=$(kubectl get pods -n kb -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
	echo https://127.0.0.1:8443/
	echo " pod need time to come up =  sleep 20  "
	sleep 20
	kubectl -n kb  port-forward $KPOD_NAME 8443:8443 & 
# 	chromium-browser 	https://127.0.0.1:8443/#/login  &
	sleep 9 
	kubectl apply -f    $vjp_code_path/Helm/admin-user.yaml
	echo -e "\n     kubectl create serviceaccount -n kubernetes-dashboard admin-user "
	kubectl create serviceaccount -n default admin-user
	echo -e "\n Token : kubectl -n kubernetes-dashboard create token admin-user token for the user admin-user  \n\n  "
	kubectl -n default     create token admin-user
	echo -e "\n\n install kubernetes-dashboard  END \n\n\n\n "
	echo " deploy  panampunna website : settings in  mychart FOLDER   "
	echo -e "	helm install nginx   $vjp_code_path/Helm/./mychart    --debug --dry-run \n\n  "
	kubectl create namespace vjp
	helm install vjp-pod-name    $vjp_code_path/Helm/./mychart  -n vjp 
	sleep 20
	echo "   kubectl  get pods  " 
	kubectl  get pods	--all-namespaces
	
	export POD_NAME=$(kubectl get pods --namespace vjp -l "app.kubernetes.io/name=mychart,app.kubernetes.io/instance=vjp-pod-name" -o jsonpath="{.items[0].metadata.name}") 
	export CONTAINER_PORT=$(kubectl get pod --namespace vjp $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  	echo "Visit http://127.0.0.1:8080 to use your application"
	sleep 9
	kubectl -n kb  port-forward $KPOD_NAME 8443:8443 &
  	kubectl --namespace  vjp  port-forward $POD_NAME 8080:$CONTAINER_PORT  & 
#	firefox    	http://127.0.0.1:8080  & 
#	chromium-browser        https://127.0.0.1:8443/#/login  &
	echo -e " \n\n  ##################################"
	echo  "  #### this will create a pod with nginc image in default namespace with name www  ==  kubectl  run www --image nginx   "
	echo  "  ####  kubectl create  job a-job --image nginx  " 
	kubectl create  job a-job --image nginx
	echo  "#####   kubectl get  jobs --all-namespaces -o wide  ###########"
	kubectl get  jobs --all-namespaces -o wide
	kubectl apply  -f   $vjp_code_path/Helm/users/kb-user-w.yaml
	echo  -e"#####  kubectl create token kb-user -n kb #####   \n\n   " 
	kubectl create token kb-user -n kb
	echo  -e " \n\n kubectl config current-context  " 
	kubectl config current-context
 	echo -e " \n\n #kubectl create cronjob j-cron-default --image=vimaldevops/panampunna-kerala:V4 --schedule="5 23 13 8 1"	"
	kubectl create cronjob j-cron --image=vimaldevops/panampunna-kerala:V4 --schedule="5 23 13 8 1"
	kubectl get  cronjobs --all-namespaces 
	echo "# kubectl create ingress my-ingress --rule="foo.com/bar=svc1:8080,tls=my-cert"    #######"
	kubectl create ingress my-ingress --rule="foo.com/bar=svc1:8080,tls=my-cert"
	echo -e "  kubectl get pods --all-namespaces  \n\n"
        kubectl         get pods        --all-namespaces
        kubectl         get service     --all-namespaces
        kubectl         get deployments --all-namespaces


	
#	kubectl create namespace grafana-namespace
#	kubectl create namespace elk-namespace
#	kubectl create namespace john-namespace
	kubectl get namespaces --all-namespaces
		#helm install grafana grafana/grafana  -n grafana-namespace
		# helm install elasticsearch elastic/elasticsearch -n elk-namespace
		# helm install logstash elastic/logstash  -n elk-namespace
		# helm install kibana elastic/kibana     -n elk-namespace
		# helm install nginx ./mychart/ --debug --dry-run 
 }


HHHUser() {
        echo "##########  kubectl  USERS RBAC  etc    ###############"
	echo "###	kubectl get serviceaccounts   " 
                vjp_code_path=$PWD
	        echo $vjp_code_path
	echo "### 	kubectl config current-context  " 
	kubectl config current-context
	echo  " kubectl get serviceaccounts   "	
		kubectl get serviceaccounts
	echo  " kubectl get service   "	
		kubectl get service
	echo  " kubectl get clusterrolebindings  "
		kubectl get clusterrolebindings 
	echo -e " \n\n ###  kubectl get clusterrolebindings  | grep vjp   ################ \n\n\n  "
		kubectl get clusterrolebindings  | grep vjp
	echo  " kubectl get clusterroles  "
		kubectl get clusterroles
	echo -e " \n\n ### kubectl      create token admin-user  Admin access  ################ \n\n\n  "
		kubectl      create token admin-user
#	echo  " kubectl create serviceaccounts vjp  "
#		kubectl create serviceaccounts vjp
#	echo  " kubectl describe serviceaccounts vjp  "
#		 kubectl describe serviceaccounts vjp

	#	kubectl create serviceaccount -n default vjp
	#	kubectl apply -f    $vjp_code_path/Helm/kube-dashboard-users/vjp-user.yaml
#	echo  " kubectl -n default     create token vjp  "
#		kubectl -n default     create token vjp
#		kubectl config --kubeconfig=$vjp_code_path/Helm/config-exercise/config-demo    view		
#		kubectl config  --kubeconfig=/home/john/.kube/config  view  
	echo  " kubectl config get-users  "
		kubectl config get-users
	echo  " kubectl config get-clusters  "
		kubectl config get-clusters
	echo  " kubectl config get-contexts  "
		kubectl config get-contexts
	echo  " kubectl config current-context  "
		kubectl config current-context
	echo  " kubectl get roles  "
		kubectl get roles
	echo  " kubectl create role john-role --verb=get,list --resource=pods,services  "
#		kubectl create role john-role --verb=get,list --resource=pods,services
	echo  " kubectl describe roles  john-role  "
#		kubectl describe roles  john-role
#		kubectl edit  role john-role
		kubectl config view

	echo "##########  kubectl  USERS RBAC  etc END    ###############"
}
# https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/
# kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
# kubectl config --kubeconfig=config-demo set-cluster test --server=https://5.6.7.8 --insecure-skip-tls-verify
#
#


HHHIK() {
        echo "##########  HELM  install sudo snap install helm --classic ###############"
		sudo snap install helm --classic
	echo " helm  auto fill tab sudo apt-get install bash-completion "
	echo " sudo helm completion bash | sudo tee  /etc/bash_completion.d/helm > /dev/null    " 
		sudo apt-get install bash-completion
		sudo helm completion bash | sudo tee  /etc/bash_completion.d/helm > /dev/null
	
		helm  install --help
	echo "#	Initialize a Helm Chart Repository   " 	
	echo "#  helm repo add bitnami https://charts.bitnami.com/bitnami   " 
#	 helm repo add bitnami https://charts.bitnami.com/bitnami
	echo "# helm search repo bitnami   " 
#	helm search repo bitnami
	echo "#    helm repo update   ||  helm  list   ################# " 
		helm repo update
#	echo "#   helm install bitnami/mysql --generate-name    ################ "
#		helm install bitnami/mysql --generate-name
#	echo "#   helm show all bitnami/mysql ||  THIS will give a big output    ################# "
#		helm show all bitnami/mysql
		helm  list
#		echo -e"\n\n\n   helm uninstall mysql-TAB	  ################# "
#		helm uninstall mysql-1687790150 
		helm repo add stable https://charts.helm.sh/stable
	        helm repo update
	echo "######   END ############################################ "
}
######################################

HHHInfo() {
        echo "##########  HELM indo   ###############"
   
	echo -e  "##  HHHInfo  " 
	helm repo add jenkins https://charts.jenkins.io
	helm repo update
	helm search repo jenkins
	helm install my-jenkins jenkins/jenkins
	##"
}

