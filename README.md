
# 📖 AWS ALB + EC2 Python App Deployment: Complete Troubleshooting & Setup Guide

## ✅ Essential AWS Resources:
- VPC
- Subnets (2+ in different AZs)
- Security Groups
- EC2 Instance
- Application Load Balancer (ALB)
- 2 Target Groups (for ports 5000 and 5001)
- Listener Rule (HTTP:80 → Weighted forward to both target groups)

## 📌 Common Deployment Pitfalls:

### ❌ Mistake 1:
**Not adding ALB’s security group inbound rule for port 80 (HTTP)**

**Fix:**
```bash
aws ec2 authorize-security-group-ingress --group-id <alb-sg-id> --protocol tcp --port 80 --cidr 0.0.0.0/0 --region <region>
```

### ❌ Mistake 2:
**Flask apps not running on expected ports inside EC2**

**Check via:**
```bash
sudo netstat -tulnp | grep python
curl localhost:5000/
curl localhost:5001/
```

### ❌ Mistake 3:
**Health checks failing due to wrong port/path/protocol**

**Check Health Status:**
```bash
aws elbv2 describe-target-health --target-group-arn <tg-arn> --region <region>
```

## 📌 AWS CLI Debugging Commands

### 🔍 Describe ALB
```bash
aws elbv2 describe-load-balancers --names <alb-name> --region <region>
```

### 🔍 Describe Listeners
```bash
aws elbv2 describe-listeners --load-balancer-arn <alb-arn> --region <region>
```

### 🔍 Describe Target Groups
```bash
aws elbv2 describe-target-groups --region <region>
```

### 🔍 Check Target Health
```bash
aws elbv2 describe-target-health --target-group-arn <tg-arn> --region <region>
```

### 🔍 Security Group Inbound Rules
```bash
aws ec2 describe-security-groups --group-ids <sg-id> --region <region>
```

## 📌 Final Sanity Checklist ✅

- [x] EC2 running, apps active on expected ports
- [x] ALB active, internet-facing
- [x] At least 2 subnets in different AZs
- [x] Security group for ALB allows inbound HTTP (port 80) from 0.0.0.0/0
- [x] Target groups attached to ALB, health checks configured on correct ports
- [x] EC2 security group allows inbound 5000/5001 traffic from ALB SG

## 📌 ALB Access URL (no ports appended)
Use only:
```
http://<ALB-DNS-Name>/
```

## 📌 Quick Fix Script (Security Group Port 80)
```bash
aws ec2 authorize-security-group-ingress --group-id <alb-sg-id> --protocol tcp --port 80 --cidr 0.0.0.0/0 --region <region>
```

## 📌 Bonus: Health Status Summary Command
```bash
aws elbv2 describe-target-health --target-group-arn <tg-arn> --region <region> --query 'TargetHealthDescriptions[*].TargetHealth.State'
```

## 📦 Pro Tip:
Always verify SG Ingress, Health Checks, and App Listening Ports before testing ALB URL.

---

Prepared for Ali 🚀
