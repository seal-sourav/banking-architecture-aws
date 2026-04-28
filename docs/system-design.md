# System Design: Mobile Banking Platform (AWS Multi-Region)

## Overview
This system is designed for a **high-availability mobile banking application** serving users across regions with strict uptime and performance requirements.

The architecture follows a **multi-region active-active model**, where both regions handle live traffic and can operate independently.

---

## Design Goals
- High availability (target: 99.99%+)
- Low latency for geographically distributed users
- Fault isolation (regional failures should not cascade)
- Stateless, horizontally scalable services
- Secure by design

---

## High-Level Flow

1. User requests hit **Route53**
2. Routed to nearest region using latency-based routing
3. Requests pass through **CloudFront + WAF**
4. Traffic enters VPC via **ALB / API Gateway**
5. Requests handled by **ECS Fargate microservices**
6. Data fetched from:
   - RDS (transactional data)
   - Redis (caching)
7. Response returned via same path

---

## Application Layer

### Stateless Services
All services are designed to be stateless:
- No session storage in containers
- Session data (if needed) stored in Redis

This allows:
- Easy horizontal scaling
- Fast failover between regions

---

## Networking

Each region has:
- Dedicated VPC
- Public subnets (ALB, API Gateway)
- Private subnets (ECS services)
- Data subnets (RDS, Redis)

Strict security group rules isolate tiers.

---

## Data Layer

- **RDS (Multi-AZ)** for transactional integrity
- Cross-region replication enabled
- Redis used for:
  - Session caching
  - Frequently accessed data

---

## Security Considerations

- WAF protects against common web attacks
- IAM roles enforce least privilege
- No direct public access to backend services
- Encryption:
  - At rest (RDS, S3)
  - In transit (HTTPS)

---

## Trade-offs

- Multi-region adds cost and operational complexity
- Cross-region data consistency is eventual, not instant
- Requires strong observability to debug distributed issues

---

## Final Note

This design prioritizes **resilience and user experience over cost**, which is aligned with expectations for banking-grade systems.