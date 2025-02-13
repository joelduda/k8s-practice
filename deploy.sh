docker build -t joelduda/multi-client:latest -t joelduda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joelduda/multi-server:latest -t joelduda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joelduda/multi-worker:latest -t joelduda/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push joelduda/multi-client:latest
docker push joelduda/multi-server:latest
docker push joelduda/multi-worker:latest

docker push joelduda/multi-client:$SHA
docker push joelduda/multi-server:$SHA
docker push joelduda/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=joelduda/multi-client:$SHA
kubectl set image deployments/server-deployment server=joelduda/multi-server:$SHA
kubectl set image deployments/worker-deployment server=joelduda/multi-worker:$SHA