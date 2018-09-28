# build docker images
docker build -t nunocf/multi-client:latest -t nunocf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nunocf/multi-server:latest -t nunocf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nunocf/multi-worker:latest -t nunocf/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# push docker images
docker push nunocf/multi-client:latest
docker push nunocf/multi-server:latest
docker push nunocf/multi-worker:latest
docker push nunocf/multi-client:$SHA
docker push nunocf/multi-server:$SHA
docker push nunocf/multi-worker:$SHA
# apply kubernetes config
kubectl apply -f k8s
# set images to most updated versions
kubectl set image deployments/client-deployment client=nunocf/multi-client:$SHA
kubectl set image deployments/server-deployment server=nunocf/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nunocf/multi-worker:$SHA