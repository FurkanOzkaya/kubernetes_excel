echo "=========================="
echo "=========================="
echo "=========================="
echo "Initilazing local registry"
echo "=========================="
echo "=========================="
echo "=========================="
docker run -d -p 5000:5000 --restart=always --name registry registry:2

cd ./excel_vue

echo "=========================="
echo "=========================="
echo "=========================="
echo "Building Frontend Image"
echo "=========================="
echo "=========================="
echo "=========================="

docker build -t excel_frontend:0.0.1 .

echo "=========================="
echo "=========================="
echo "=========================="
echo "Tagging frontend"
echo "=========================="
echo "=========================="
echo "=========================="

docker tag excel_frontend:0.0.1 localhost:5000/excel_frontend:0.0.1 

echo "=========================="
echo "=========================="
echo "=========================="
echo "Pushing Image to local Repository"
echo "=========================="
echo "=========================="
echo "=========================="

docker push localhost:5000/excel_frontend:0.0.1 

cd ../postgresql_json_excel

echo "=========================="
echo "=========================="
echo "=========================="
echo "Building Backend Image"
echo "=========================="
echo "=========================="
echo "=========================="

docker build -t excel_backend:0.0.1 .

echo "=========================="
echo "=========================="
echo "=========================="
echo "Tagging Backend"
echo "=========================="
echo "=========================="
echo "=========================="

docker tag excel_backend:0.0.1 localhost:5000/excel_backend:0.0.1 

echo "=========================="
echo "=========================="
echo "=========================="
echo "Pushing Image to local Repository"
echo "=========================="
echo "=========================="
echo "=========================="

docker push localhost:5000/excel_backend:0.0.1

cd ..

echo "=========================="
echo "=========================="
echo "=========================="
echo "Kubernetes Deployments and Services Creating"
echo "=========================="
echo "=========================="
echo "=========================="

kubectl apply -f postgresql_secret.yaml

sleep 10 

kubectl apply -f postgresql_configmap.yaml

sleep 10

kubectl apply -f django_cofigmap.yaml

sleep 10

kubectl apply -f persistent_volume.yaml

sleep 15

kubectl apply -f postgresql.yaml

sleep 20

kubectl apply -f backend_deployment.yaml

sleep 20

kubectl apply -f frontend_deployment.yaml

