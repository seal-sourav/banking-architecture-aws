# ADR-003: Database Design & Cross-Region Replication

## Status
Accepted

## Context
The system handles **financial transactions**, requiring:
- High availability
- Strong data durability
- Cross-region resilience
- Low read latency

Challenges:
- Data consistency across regions
- Replication lag
- Failover handling

## Decision
Use **Amazon Aurora (or RDS) with Multi-AZ + Cross-Region Replication**.

## Architecture Approach
- Primary region handles writes
- Secondary region maintains read replica
- Cross-region replication enabled
- Automatic failover within region (Multi-AZ)

## Data Strategy

### Writes
- Directed to primary region

### Reads
- Served locally where possible
- Read replicas used for scaling

## Consistency Model
- Eventual consistency across regions
- Strong consistency within region

## Failover Strategy
- In case of regional failure:
  - Secondary region promoted to primary
  - Application reroutes traffic

## Alternatives Considered

### 1. DynamoDB Global Tables
- Considered but not chosen due to:
  - Complex relational queries
  - Banking workload requirements

### 2. Active-Active Writes
- Rejected due to conflict resolution complexity

## Trade-offs

### ❌ Challenges
- Replication lag (seconds)
- Failover orchestration complexity

### ✅ Benefits
- High durability
- Disaster resilience
- Scalable read performance

## Notes
Future enhancement:
- Evaluate **Aurora Global Database** for lower replication latency