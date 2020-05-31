docker build -t kamilesta/client:latest -t kamilesta/client:$SHA -f ./client/Dockerfile ./client
docker build -t kamilesta/server:latest -t kamilesta/server:$SHA -f ./server/Dockerfile ./server
docker build -t kamilesta/worker:latest -t kamilesta/worker:$SHA -f ./worker/Dockerfile ./worker

docker push kamilesta/client:latest
docker push kamilesta/server:latest
docker push kamilesta/worker:latest

docker push kamilesta/client:$SHA
docker push kamilesta/server:$SHA
docker push kamilesta/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kamilesta/client:$SHA
kubectl set image deployments/server-deployment server=kamilesta/server:$SHA
kubectl set image deployments/worker-deployment worker=kamilesta/worker:$SHA