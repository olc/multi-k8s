docker build -t olc/multi-client:latest -t olc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olc/multi-server:latest -t olc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olc/multi-worker:latest -t olc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olc/multi-client:latest
docker push olc/multi-server:latest
docker push olc/multi-worker:latest

docker push olc/multi-client:$SHA
docker push olc/multi-server:$SHA
docker push olc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olc/multi-server:$SHA
kubectl set image deployments/client-deployment server=olc/multi-client:$SHA
kubectl set image deployments/worker-deployment server=olc/multi-worker:$SHA
