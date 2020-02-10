mvn clean package;
scp -i ~/.paasrc/inventory/dimitri/privatekey.pem target/K8sControllerMaven.jar cloud-user@139.54.131.57:/home/cloud-user/JavaK8sController;

