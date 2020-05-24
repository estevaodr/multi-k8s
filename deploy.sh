docker build -t estevaodr/multi-client:latest -t estevaodr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t estevaodr/multi-server:latest -t estevaodr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t estevaodr/multi-worker:latest -t estevaodr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push estevaodr/multi-client:latest
docker push estevaodr/multi-server:latest
docker push estevaodr/multi-worker:latest

docker push estevaodr/multi-client:$SHA
docker push estevaodr/multi-server:$SHA
docker push estevaodr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=estevaodr/multi-server:$SHA
kubectl set image deployments/client-deployment client=estevaodr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=estevaodr/multi-worker:$SHA

rm -r service-account.json

git rm service-account.json


