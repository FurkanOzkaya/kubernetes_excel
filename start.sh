echo "Initilazing local registry"
docker run -d -p 5000:5000 --restart=always --name registry registry:2

cd excel_vue

echo "Building Frontend Image"

docker build -t excel_frontend:0.0.1 .

echo "Tagging frontend"

docker tag excel_frontend:0.0.1 localhost:5000/excel_frontend:0.0.1 

echo "Pushing Image to local Repository"

docker push localhost:5000/excel_frontend:0.0.1 

cd ../postgresql_json_excel

echo "Building Backend Image"

docker build -t excel_backend:0.0.1 .

echo "Tagging Backend"

docker tag excel_backend:0.0.1 localhost:5000/excel_backend:0.0.1 

echo "Pushing Image to local Repository"

docker push localhost:5000/excel_backend:0.0.1

cd ..

echo "Kubernetes Deployments and Services Creating"

kubectl apply -f postgresql_secret.yaml

sleep 5 

kubectl apply -f postgresql_configmap.yaml

sleep 5 

kubectl apply -f postgresql.yaml

sleep 15

kubectl apply -f backend_deployment.yaml

sleep 10

kubectl apply -f frontend_deployment.yaml

