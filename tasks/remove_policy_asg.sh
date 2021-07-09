#!/bin/bash
#ASGName=EDA-Dev-st2api-100-blue-config-20200319101803296300000001-asg
clear
echo "=================================================================";
echo "Enter Asg name to remove termination policy and scale in policy";
echo "=================================================================";
read ASGName;echo "ASG Name: ${ASGName}"
if test -z "$ASGName"
then
      echo "***Script will not accept empty string***"
      echo "***Enter valid ASGName***"
      exit
#else
#      echo "\$var is NOT empty"
fi
echo "=================================================================";
region=us-east-1
#aws autoscaling update-auto-scaling-group --region=${region}  --auto-scaling-group-name ${ASGName}
#aws autoscaling suspend-processes --region=${region} --auto-scaling-group-name ${ASGName}
aws autoscaling resume-processes --region=${region} --auto-scaling-group-name ${ASGName};
echo "all suspended process resumed in asg: ${ASGName}"
aws autoscaling update-auto-scaling-group --region=${region} --auto-scaling-group-name ${ASGName} --no-new-instances-protected-from-scale-in
echo "Remove scalein protection for asg: ${ASGName}"
for InstanceId in `aws autoscaling describe-auto-scaling-groups --region=${region} --auto-scaling-group-name ${ASGName} | grep -i instanceid  | awk '{ print $2}' | cut -d',' -f1| sed -e 's/"//g'`
do
#aws ec2 describe-instances --region=us-east-1 --instance-ids $i | grep -i PrivateIpAddress | awk '{ print $2 }' | head -1 | cut -d"," -f1
aws autoscaling set-instance-protection --region=${region}  --instance-ids ${InstanceId} --auto-scaling-group-name ${ASGName} --no-protected-from-scale-in

aws ec2 terminate-instances --region=${region}  --instance-ids ${InstanceId} &
echo "Remove instance protection for InstanceId: ${InstanceId}"
#aws autoscaling update-auto-scaling-group  --region=${region}  --auto-scaling-group-name ${ASGName} --max-size 0 --min-size 0
done;
echo "=================================================================";
