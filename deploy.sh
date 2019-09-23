docker build -t pranabjyoti/multi-client:latest -t pranabjyoti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pranabjyoti/multi-server:latest -t pranabjyoti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pranabjyoti/multi-worker:latest -t pranabjyoti/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pranabjyoti/multi-client:latest
docker push pranabjyoti/multi-server:latest
docker push pranabjyoti/multi-worker:latest

docker push pranabjyoti/multi-client:$SHA
docker push pranabjyoti/multi-server:$SHA
docker push pranabjyoti/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pranabjyoti/multi-server:$SHA
kubectl set image deployments/client-deployment client=pranabjyoti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pranabjyoti/multi-worker:$SHA