# ADR-001: Multi-Region Active-Active Architecture

## Status
Accepted

## Context
The system supports a **mobile banking platform** with strict requirements for:
- Near-zero downtime (target: 99.99%+ availability)
- Global user base with latency sensitivity
- Regulatory expectations around resilience and disaster recovery

A single-region deployment, even with Multi-AZ, introduces:
- Regional outage risk
- Increased latency for geographically distant users
- Limited disaster recovery capability

## Decision
Adopt a **Multi-Region Active-Active architecture** across two AWS regions.

Both regions:
- Serve live traffic simultaneously
- Maintain identical infrastructure stacks
- Are independently scalable and deployable

## Architecture Approach
- Stateless services deployed in both regions
- Traffic distributed via Route53 latency-based routing
- Health checks enable automatic failover
- Data replicated across regions

## Consequences

### ✅ Positive
- Eliminates regional single point of failure
- Improves latency by serving traffic from nearest region
- Enables seamless failover without manual intervention
- Supports zero-downtime deployments

### ❌ Trade-offs
- Increased infrastructure cost (~1.5x–2x)
- Higher operational complexity
- Data consistency challenges across regions

## Alternatives Considered

### 1. Single Region (Multi-AZ)
- Rejected due to regional failure risk

### 2. Active-Passive DR
- Rejected due to failover delay and underutilized resources

## Notes
This design aligns with **AWS Well-Architected Framework (Reliability + Performance Efficiency)** and is commonly used in high-critical systems like banking and payments.