## Kubernetes Notes

## Common Commands

### Display the Service

```
kubectl get service

NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   25h

# or

kubectl get svc  # short form for service - same result
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   25h
```

### Delete a Service

```
$ kubectl delete svc nginx-svc
service "nginx-svc" deleted
```

### Display Deployment

```
$ kubectl get deployment # Currently we get- no resource found in default namespace - as nothing is deployed yet
No resources found in default namespace.

$ kubectl get deploy # same as above
No resources found in default namespace.
```

### Delete Deployments

```
$ kubectl delete deploy nginx-deployment
deployment.apps "nginx-deployment" deleted
```

### Display Pods

```
$ kubectl get pods # Shows the pods # We don't have any yet
No resources found in default namespace.
```

MORE TBA