docker build -t franzu/multi-client:latest -t franzu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t franzu/multi-server:latest -t franzu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t franzu/multi-worker:latest -t franzu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push franzu/multi-client:latest
docker push franzu/multi-server:latest
docker push franzu/multi-worker:latest

docker push franzu/multi-client:$SHA
docker push franzu/multi-server:$SHA
docker push franzu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=franzu/multi-server:$SHA
kubectl set image deployments/client-deployment client=franzu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=franzu/multi-worker:$SHA