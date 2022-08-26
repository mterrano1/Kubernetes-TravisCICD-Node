docker build -t mterrano1/multi-client:latest -t mterrano1/multi-client: $SHA -f ./client/Dockerfile ./client
docker build -t mterrano1/multi-server:latest -t mterrano1/multi-server: $SHA -f ./server/Dockerfile ./server
docker build -t mterrano1/multi-worker:latest -t mterrano1/multi-worker: $SHA -f ./worker/Dockerfile ./worker
docker push mterrano1/multi-client:latest
docker push mterrano1/multi-server:latest
docker push mterrano1/multi-worker:latest

docker push mterrano1/multi-client:$SHA
docker push mterrano1/multi-server:$SHA
docker push mterrano1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mterrano1/multi-server:$SHA
kubectl set image deployments/client-deployment client=mterrano1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mterrano1/multi-worker:$SHA