echo -e "Starting script Java jar to k8s pod\n";
RED='\e[91m'
NOMORECOLOR='\033[0m'
if [ "$#" == 1 ]
then
	if test -f "K8sControllerMaven.jar"; 
	then
		mkdir $1;
        	cp Dockerfile $1/;
        	cp pod-def.yaml $1/;
        	sed -i "s/PODNAME/$1/g" $1/pod-def.yaml;
        	cp K8sControllerMaven.jar $1/;
        	cd $1;
		docker rmi "$1:latest" -f;
		docker rmi "bcmt-registry:5000/$1:1.0.0" -f;
		docker build . -t $1;
        	docker tag "$1:latest" "bcmt-registry:5000/$1:1.0.0";
        	docker push "bcmt-registry:5000/$1:1.0.0";
        	kubectl delete -f pod-def.yaml;
		kubectl apply -f pod-def.yaml;
        	cd ..;
        	rm K8sControllerMaven.jar;
	else
		echo -e "${RED}K8sControllerMaven.jar not here, first launch createAndSendJar.sh in target of maven${NOMORECOLOR}\n";
		exit 1;
	fi
else
	echo -e "${RED}Require one argument, the name of the pod and the folder${NOMORECOLOR}\n";
	exit 1;
fi
echo -e "Finish";
exit 0;

