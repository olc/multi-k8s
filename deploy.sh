docker build -t olecam/multi-client:latest -t olecam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olecam/multi-server:latest -t olecam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olecam/multi-worker:latest -t olecam/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olecam/multi-client:latest
docker push olecam/multi-server:latest
docker push olecam/multi-worker:latest

docker push olecam/multi-client:$SHA
docker push olecam/multi-server:$SHA
docker push olecam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olecam/multi-server:$SHA
kubectl set image deployments/client-deployment client=olecam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olecam/multi-worker:$SHA
