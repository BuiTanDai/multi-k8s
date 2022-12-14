docker build -t buitandai96/multi-client:latest -t buitandai96/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t buitandai96/multi-server:latest -t buitandai96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t buitandai96/multi-worker:latest -t buitandai96/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push buitandai96/multi-client:latest
docker push buitandai96/multi-server:latest
docker push buitandai96/multi-worker:latest

docker push buitandai96/multi-client:$SHA
docker push buitandai96/multi-server:$SHA
docker push buitandai96/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=buitandai96/multi-server:$SHA
kubectl set image deployments/client-deployment client=buitandai96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=buitandai96/multi-worker:$SHA