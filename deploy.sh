docker build -t uryadovalex/multi-client:latest -t uryadovalex/multi-client:latest:$SHA -f ./client/Dockerfile ./client
docker build -t uryadovalex/multi-server:latest -t uryadovalex/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uryadovalex/multi-worker:latest -t uryadovalex/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push uryadovalex/multi-client:latest
docker push uryadovalex/multi-server:latest
docker push uryadovalex/multi-worker:latest

docker push uryadovalex/multi-client:$SHA
docker push uryadovalex/multi-server:$SHA
docker push uryadovalex/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=uryadovalex/multi-client:$SHA
kubectl set image deployments/server-deployment server=uryadovalex/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=uryadovalex/multi-worker:$SHA